import sys

def multiply(a,b):
    result = int(a)*int(b)  
    return result  

userParameters = sys.argv[1:]
result = multiply(userParameters[0], userParameters[1])
print(result) 
