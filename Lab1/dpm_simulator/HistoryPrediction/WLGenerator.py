import os
import sys
import random
import matplotlib.pyplot as plot

# At least 1000 lines, we can do 10.000 lines

### Distributions

def uniformCorrelated(min, max):
    return int(random.uniform(float(min), float(max)))

def gaussCorrelated(mean, std_dev):
    return int(random.gauss(float(mean), float(std_dev)))

def exponentialCorrelated(mean):
    return int(random.expovariate(float(1/mean)))

def trimodalCorrelated(mean1, mean2, mean3, std_dev1, std_dev2, std_dev3):
    toss = random.choice([0, 1, 2])
    if (toss == 0):
        num = int(random.gauss(mean1, std_dev1))
    elif (toss == 1):
        num = int(random.gauss(mean2, std_dev2))
    elif (toss == 2):
        num = int(random.gauss(mean3, std_dev3))
    return int(num)


### Utility functions

def printWorkLoad(WL, case):
    print("\n>> Printing the WorkLoad file...")
    WLfile = open("./Correlated/Case " + case + "/WL.txt", "w")
    for i in range(0, len(WL), 2):
        print(str(WL[i]) + " " + str(WL[i + 1]))
        WLfile.write(str(WL[i]) + " " + str(WL[i + 1]) + "\n")
    WLfile.close()

def printVal(listVal, case):
    print("\n>> Printing the values obtained...")
    valFile = open("./Correlated/Case " + case + "/values.txt", "w")
    for i in range(0, len(listVal)):
        print(str(listVal[i]))
        valFile.write(str(listVal[i]) + "\n")
    valFile.close()

def printValActive(listVal, case):
    print("\n>> Printing the values obtained...")
    valFile = open("./Correlated/Case " + case + "/activeValues.txt", "w")
    for i in range(0, len(listVal)):
        print(str(listVal[i]))
        valFile.write(str(listVal[i]) + "\n")
    valFile.close()

def printValIdle(listVal, case):
    print("\n>> Printing the values obtained...")
    valFile = open("./Correlated/Case " + case + "/idleValues.txt", "w")
    for i in range(0, len(listVal)):
        print(str(listVal[i]))
        valFile.write(str(listVal[i]) + "\n")
    valFile.close()

def printHist(listVal, active, case):
    print("\n>> Printing the Histogram...")
    if active:
        plot.hist(listVal, bins=50)
        plot.savefig("./Correlated/Case " + case + "/Active.png")
    else:
        plot.clf()
        plot.hist(listVal, bins=200)
        axes = plot.gca()
        #axes.set_xlim([0, 10000])
        plot.savefig("./Correlated/Case " + case + "/Idle.png")


def main(case, lines):

    WL = []
    listValActive = []
    listValIdle = []
    listVal = []
    num2 = 0

    unifMiddleActive = 250
    unifMiddle = 50
    unifMiddle_2 = 200

    for i in range(0, int(lines), 2):

        # ACTIVE
        if i >= 2:
            if (num1 - unifMiddleActive >= 0):
                num1 = uniformCorrelated(num1 - unifMiddleActive, 2 * unifMiddleActive + (num1 - unifMiddleActive))
            else:
                num1 = uniformCorrelated(num1 - unifMiddleActive, 2 * unifMiddleActive - (unifMiddleActive - num1))
            if (num1 < 0):
                num1 = -num1;
        else:
            num1 = uniformCorrelated(1, 500)
        listVal.append(num1)
        listValActive.append(num1)
        if i >= 1:
            WL.append(WL[i - 1] + num1)
        else:
            WL.append(num1)

        # IDLE
        if (case == "1"):
            # IDLE Case #1
            if i >= 2:
                if (num2 - unifMiddle >= 0):
                    num2 = uniformCorrelated(num2 - unifMiddle, 2 * unifMiddle + (num2 - unifMiddle))
                else:
                    num2 = uniformCorrelated(num2 - unifMiddle, 2 * unifMiddle - (unifMiddle - num2))
                if (num2 < 0):
                    num2 = -num2;
            else:
                num2 = uniformCorrelated(1, 100)

        if (case == "2"):
            # IDLE Case #2
            if i >= 2:
                if (num2 - unifMiddle >= 0):
                    num2 = uniformCorrelated(num2 - unifMiddle_2, 2 * unifMiddle_2 + (num2 - unifMiddle_2))
                else:
                    num2 = uniformCorrelated(num2 - unifMiddle_2, 2 * unifMiddle_2 - (unifMiddle_2 - num2))
                if (num2 < 0):
                    num2 = -num2;
            else:
                num2 = uniformCorrelated(1, 400)

        if (case == "3"):
            # IDLE Case #3
            if i >= 2:
                while True:
                    num2 = gaussCorrelated(num2, 20)
                    if num2 > 0:
                        break
            else:
                num2 = gaussCorrelated(100, 20)

        if (case == "4"):
            # IDLE Case #4
            if i >= 2:
                while True:
                    num2 = exponentialCorrelated(num2+1)
                    if num2 > 0:
                        break
            else:
                num2 = exponentialCorrelated(50)

        if (case == "5"):
            # IDLE Case #5
            if i >= 2:
                while True:
                    num2 = trimodalCorrelated(num2 - 50, num2, num2 + 50, 10, 10, 10)
                    if num2 > 0:
                        break
            else:
                num2 = trimodalCorrelated(50, 100, 150, 10, 10, 10)

        listVal.append(num2)
        listValIdle.append(num2)
        WL.append(WL[i] + num2)

    printWorkLoad(WL, case)
    printVal(listVal, case)
    printValActive(listValActive, case)
    printValIdle(listValIdle, case)
    printHist(listValActive, active=True, case=case)
    printHist(listValIdle, active=False, case=case)


if __name__ == "__main__":

    if (len(sys.argv) != 3):
        print("Error, # of IDLECaseDistribution, # of lines")
        sys.exit()

    main(sys.argv[1], sys.argv[2])
