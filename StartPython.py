# -StartPython.py *- coding: utf-8 -*-
"""
Spyder Editor

#%% starts a new cell. Use second green triangle to run just the cell that
your mouse has last clicked in (or Ctrl-Enter on a PC or Command-Return on a
Macintosh or Menu>Run>Run Cell)
"""
#%%
def hello():
    print("Hello, world!")

#%%
def myname():
    print("My name is Pauline")
    
#%%
def ourschool():
    print("Coursera is our school")

#%%  
  
""" This will run forever. In this case Ctrl-C will stop it, but sometimes
that doesn't work. In that case, click away IP Console to stop; click yes to 
kill kernel. Open a new IPConsole on the Console menu to restart """
#%%
def forever():
    while True:
        pass
  
#%% 
def areatriangle(b,h):
    """calculate the area of a triangle"""
    area=0.5*b*h
    print("the area of the triangle with base",b,"and height",h,"is",area)
    
#%%
"""farenheit to celcius conversion"""
def farenheit_to_celcius(temp):
    new_temp= 5*(temp-32)/9
    print("Your temp in celcius is",new_temp,"C")
    
#%%
"""Input function"""
def info():
    fname=input("Enter your first name:", )
    lname=input("Enter your last name:", )
    city=input("Enter your city:", )
    ##full_info = fname + " " + lname + " " + city
    print("Thank you", fname, lname, "of", city, "for using our services.")

#%%
"""If statements"""
def if_statement():
    
    x=5
    y=8
    z=0
    
    if x>0:
        print("x is a positive number")
    else:
        print("x is a negative integer")
        
    if y>0:
        print("y is a positive number")
    else:
        print("y is a negative integer")
    
    if z>0:
        print("z is a positive number")
    else:
        print("z is a negative integer")
        
#%%
"""Trying out input and if statements"""
def input_if():
    
        x=print("Please enter a number:", )
        x=input()
        print(x, "is your number")
                
        if x>0:
            print("x is a positve integer")
        elif x<0:
            print("x is a negative integer")
        elif x==0:
            print("x is equal to zero")
