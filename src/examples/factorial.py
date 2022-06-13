import math

def oneline_factorial(n):
    return math.prod(i for i in range(1, n + 1))

print(oneline_factorial(5))
