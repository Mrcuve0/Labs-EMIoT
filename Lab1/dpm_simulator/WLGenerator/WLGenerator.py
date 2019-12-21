import os
import sys
import random
import matplotlib.pyplot as plot

# At least 1000 lines, we can do 10.000 lines

### Distributions

def uniform(min, max):
    return int(random.uniform(float(min), float(max)))

def gauss(mean, std_dev):
    return int(random.gauss(float(mean), float(std_dev)))

def exponential(mean):
    return int(random.expovariate(float(1/mean)))

def trimodal(mean1, mean2, mean3, std_dev1, std_dev2, std_dev3):
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
    WLfile = open("Case " + case + "/WL.txt", "w")
    for i in range(0, len(WL), 2):
        print(str(WL[i]) + " " + str(WL[i + 1]))
        WLfile.write(str(WL[i]) + " " + str(WL[i + 1]) + "\n")
    WLfile.close()

def printVal(listVal, case):
    print("\n>> Printing the values obtained...")
    valFile = open("Case " + case + "/values.txt", "w")
    for i in range(0, len(listVal)):
        print(str(listVal[i]))
        valFile.write(str(listVal[i]) + "\n")
    valFile.close()

def printHist(listVal, active, case):
    print("\n>> Printing the Histogram...")
    if active:
        plot.hist(listVal, bins=50)
        plot.savefig("Case " + case + "/Active.png")
    else:
        plot.clf()
        plot.hist(listVal, bins=50)
        plot.savefig("Case " + case + "/Idle.png")


def main(case, lines):

    WL = []
    listValActive = []
    listValIdle = []
    listVal = []
    
    for i in range(0, int(lines), 2):

        # ACTIVE
        num1 = uniform(1, 500)
        listVal.append(num1)
        listValActive.append(num1)
        if i >= 1:
            WL.append(WL[i - 1] + num1)
        else:
            WL.append(num1)
    
        # IDLE
        num2 = None
        if (case == "1"):
            # IDLE Case #1
            num2 = uniform(1, 100)
    
        if (case == "2"):
            # IDLE Case #2
            num2 = uniform(1, 400)
    
        if (case == "3"):
            # IDLE Case #3
            num2 = gauss(100, 20)
    
        if (case == "4"):
            # IDLE Case #4
            num2 = exponential(50)
    
        if (case == "5"):
            # IDLE Case #5
            num2 = trimodal(50, 100, 150, 10, 10, 10)

        listVal.append(num2)
        listValIdle.append(num2)
        WL.append(WL[i] + num2)

    printWorkLoad(WL, case)
    printVal(listVal, case)
    printHist(listValActive, active=True, case=case)
    printHist(listValIdle, active=False, case=case)


if __name__ == "__main__":

    if (len(sys.argv) != 3):
        print("Error, # of IDLECaseDistribution, # of lines")
        sys.exit()

    main(sys.argv[1], sys.argv[2])
