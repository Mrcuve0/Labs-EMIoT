#include "inc/dpm_policies.h"
#include <stdio.h>
#include <math.h>

int dpm_simulate(psm_t psm, dpm_policy_t sel_policy, dpm_timeout_params tparams, dpm_history_params hparams, char *fwl)
{

    FILE *fp;
    psm_interval_t idle_period;
    psm_time_t history[DPM_HIST_WIND_SIZE];
    psm_time_t curr_time = 0;
    psm_state_t curr_state = PSM_STATE_ACTIVE;
    psm_state_t prev_state = PSM_STATE_ACTIVE;
    psm_energy_t e_total = 0;
    psm_energy_t e_tran;
    psm_energy_t e_tran_total = 0;
    psm_energy_t e_total_no_dpm = 0;
    psm_time_t t_tran_total = 0;
    psm_time_t t_waiting = 0;
    psm_time_t t_idle_ideal = 0;
    psm_time_t t_state[PSM_N_STATES] = {0};
    int n_tran_total = 0;

    fp = fopen(fwl, "r");
    if (!fp)
    {
        printf("[error] can't open file %s!\n", fwl);
        return 0;
    }

    dpm_init_history(history);

    // main loop
    while (fscanf(fp, "%lf%lf", &idle_period.start, &idle_period.end) == 2)
    {

        t_idle_ideal += psm_duration(idle_period);
        dpm_update_history(history, psm_duration(idle_period));
        /*printf("idle: %lf %lf\n", idle_period.start, idle_period.end);*/

        // for each instant until the end of the current idle period
        for (; curr_time < idle_period.end; curr_time++)
        {

            // compute next state
            if (!dpm_decide_state(&curr_state, curr_time, idle_period, history,
                                  sel_policy, tparams, hparams))
            {
                printf("[error] cannot decide next state!\n");
                return 0;
            }
            /*printf("curr: %lf, state: %s\n", curr_time, PSM_STATE_NAME(curr_state));*/

            if (curr_state != prev_state)
            {
                if (!psm_tran_allowed(psm, prev_state, curr_state))
                {
                    printf("[error] prohibited transition!\n");
                    return 0;
                }
                e_tran = psm_tran_energy(psm, prev_state, curr_state);
                e_tran_total += e_tran;
                t_tran_total += psm_tran_time(psm, prev_state, curr_state);
                n_tran_total++;
                e_total += psm_state_energy(psm, curr_state) + e_tran;
            }
            else
            {
                e_total += psm_state_energy(psm, curr_state);
            }
            e_total_no_dpm += psm_state_energy(psm, PSM_STATE_ACTIVE);
            // statistics of time units spent in each state
            t_state[curr_state]++;
            // time spent actively waiting for timeout expirations
            if (curr_state == PSM_STATE_ACTIVE && curr_time >=
                                                      idle_period.start)
            {
                t_waiting++;
            }

            prev_state = curr_state;
        }
    }
    fclose(fp);

    printf("[sim] Active time in profile = %.6lfs \n", (curr_time - t_idle_ideal) * PSM_TIME_UNIT);
    printf("[sim] Idle time in profile = %.6lfs\n", t_idle_ideal * PSM_TIME_UNIT);
    printf("[sim] Total time = %.6lfs\n", curr_time * PSM_TIME_UNIT);
    printf("[sim] Timeout waiting time = %.6lfs\n", t_waiting * PSM_TIME_UNIT);
    for (int i = 0; i < PSM_N_STATES; i++)
    {
        printf("[sim] Total time in state %s = %.6lfs\n", PSM_STATE_NAME(i),
               t_state[i] * PSM_TIME_UNIT);
    }
    printf("[sim] Time overhead for transition = %.6lfs\n", t_tran_total * PSM_TIME_UNIT);
    printf("[sim] N. of transitions = %d\n", n_tran_total);
    printf("[sim] Energy for transitions = %.6fJ\n", e_tran_total * PSM_ENERGY_UNIT);
    printf("[sim] Energy w/o DPM = %.6fJ, Energy w DPM = %.6fJ\n",
           e_total_no_dpm * PSM_ENERGY_UNIT, e_total * PSM_ENERGY_UNIT);
    printf("[sim] %2.1f percent of energy saved.\n", 100 * (e_total_no_dpm - e_total) /
                                                         e_total_no_dpm);

    return 1;
}

int dpm_decide_state(psm_state_t *next_state, psm_time_t curr_time,
                     psm_interval_t idle_period, psm_time_t *history, dpm_policy_t policy,
                     dpm_timeout_params tparams, dpm_history_params hparams)
{

    double value_prediction;
    // hparams.alpha[0] = 3.55e-06;
    // hparams.alpha[1] = 0.9935;
    // hparams.alpha[2] = 63.718;

    switch (policy)
    {

    case DPM_TIMEOUT:

        // ORIGINAL
        // if(curr_time > idle_period.start + tparams.timeout[0]) {
        //     *next_state = PSM_STATE_IDLE;
        // } else {
        //     *next_state = PSM_STATE_ACTIVE;
        // }

        // ACTUAL VERSION (AFTER 01-12-2019)
        // Check if actual time is greater than Tto_idle
        if (curr_time > idle_period.start + tparams.timeout[0])
        {
            *next_state = PSM_STATE_IDLE;

            // Check if actual time is greater than Tto_sleep and if Tto_sleep is greater than Tto_idle
            // (so that the actual time is both greater than Tto_idle and Tto_sleep)
            if ((tparams.timeout[1] > tparams.timeout[0]) && (curr_time > idle_period.start + tparams.timeout[1]))
                *next_state = PSM_STATE_SLEEP;
        }
        else
        {
            *next_state = PSM_STATE_ACTIVE;
        }

        break;

    case DPM_HISTORY:
        if (curr_time < idle_period.start)
        {
            *next_state = PSM_STATE_ACTIVE;
        }
        else
        {
            *next_state = PSM_STATE_ACTIVE;
            /* LAB 3 EDIT
            double alpha[DPM_HIST_WIND_SIZE == 3]; <-- regression model coefficients
            double threshold[DPM_N_THRESHOLDS == 2]; 
            <-- thresholds on the predicted time that trigger a state transition 
            
            Thresholds should be equal to the two TBE
            history has space for 5 values (can be changed), can contain the latest 5 idle values for example
            Tidle[i]= K0 + K1Tidle[i-1] + K2Tidle[i-1]² + K3Tactive[i] + K4Tidle[i-1]Tactive[i] + K5Tactive[i]²
            K0 ...K5 = coefficients (determined empirically) (polyfit function)

            If the Tidle computed using the regression model is greater than one (or both) the thresholds,
            then we enter the corresponding sleep state.

            Tidle[i] = K1Tidle[i-1]² + K2Tidle[i-2] + K3
            */

            value_prediction = hparams.alpha[0] * pow(history[2], 2) + hparams.alpha[1] * history[1] + hparams.alpha[2];
            // history[0] = history[1];
            // history[1] = history[2];
            // history[0] = value_prediction;

            // hparams.alpha[i] * history[i] ....
            if (value_prediction >= (double)hparams.threshold[0])
            {
                *next_state = PSM_STATE_IDLE;
                if ((value_prediction >= (double)hparams.threshold[0]) && (value_prediction >= (double)hparams.threshold[1]) && (hparams.threshold[1] > hparams.threshold[0]))
                {
                    *next_state = PSM_STATE_SLEEP;
                }
            }
            else
            {
                *next_state = PSM_STATE_ACTIVE;
            }
        }
        break;

    default:
        printf("[error] unsupported policy\n");
        return 0;
    }
    return 1;
}

/* initialize idle time history */
void dpm_init_history(psm_time_t *h)
{
    for (int i = 0; i < DPM_HIST_WIND_SIZE; i++)
    {
        h[i] = 0;
    }
}

/* update idle time history */
void dpm_update_history(psm_time_t *h, psm_time_t new_idle)
{
    for (int i = 0; i < DPM_HIST_WIND_SIZE - 1; i++)
    {
        h[i] = h[i + 1];
    }
    h[DPM_HIST_WIND_SIZE - 1] = new_idle;
}
