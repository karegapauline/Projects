"""Function that calculates the price for JadaEnt products"""
def jada_price(price,profit):
    selling_price = price+(0.2*price)+50+profit
    print("The product will cost",selling_price)
    