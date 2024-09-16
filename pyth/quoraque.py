##write a program that allows a user to input 10 elements into an array and then search the array and display whether
##element searched for is there or not

#initialize empty array
my_arr = []

#input elements into array 10 times
for i in range(10):
    elements = input(f'Enter element {i+1}: ')
    my_arr.append(elements)

#print(my_arr)

#search for an element in the array 
def search_arr():
    query = input(f'Enter element to search for in array here: ')
    if query in my_arr:
        print(f'that element was found in array')
    else:
        print(f'that element is not in the array')

search_arr()
