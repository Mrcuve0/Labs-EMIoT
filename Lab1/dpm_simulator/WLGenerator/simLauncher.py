import sys
import os
import subprocess
import re
import matplotlib.pyplot as plot

def main(case, step, max_Tto):

    val = []
    Tto_val = 0
    iterations = int(max_Tto/step)
    for i in range(0, iterations):

        subprocess.call("../dpm_simulator -t " + str(Tto_val) + " -psm ../example/psm.txt -wl ../WLGenerator/Case\ " + str(case) + "/WL.txt > ../WLGenerator/Case\ " + str(case) + "/Timeout_Results/T_" + str(Tto_val) + "results.txt", shell=True)

        fp = open("../WLGenerator/Case " + str(case) + "/Timeout_Results/T_" + str(Tto_val) + "results.txt", "r")
        for line in fp:
            # [sim] 9.1 percent of energy saved.
            if re.match("\[sim\] ([+-]?[0-9]*[.]?[0-9]+) percent of energy saved\.", line):
                val.append(re.findall("\[sim\] ([+-]?[0-9]*[.]?[0-9]+) percent of energy saved\.", line).pop())
        # print(val)
        Tto_val = Tto_val + step

    iter_list = list(range(0, max_Tto, step))
    print(iter_list)
    # print(iter_list.sort(reverse=True))
    print([float(i) for i in val])

    plot.bar(iter_list, height=[float(i) for i in val], linewidth=2.0)

    plot.grid(color='#95a5a6', linestyle='--', linewidth=1, axis='x', alpha=0.5)
    plot.xlabel('Tto (microS)')
    plot.ylabel('Energy Saved (%)')
    plot.title('Energy Saved v. Timeout values')
    plot.savefig("../WLGenerator/Case " + str(case) + "/Timeout_Results/percEnergySaved.svg")
    plot.savefig("../WLGenerator/Case " + str(case) + "/Timeout_Results/percEnergySaved.png")


if __name__ == "__main__":
    if (len(sys.argv) != 4):
        sys.exit("Erorr: plese use simLauncher <IDLE_CASE_#> <TIMEOUT_STEP> <MAX_TTO_VAL>")

    main(int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]))