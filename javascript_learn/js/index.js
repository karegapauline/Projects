function digit() {
    console.log(42)
}

digit()

let lap1 = 34
let lap2 = 33
let lap3 = 36

// create function that logs out the sum of all the lap times
function lapTimes() {
    sumLapTime = lap1 + lap2 + lap3
    console.log(sumLapTime)
}

lapTimes()

let lapsCompleted = 0

// create a function that increments the lapsCompleted var with one
// run it three times

function addLaps() {
    lapsCompleted = lapsCompleted + 1
    console.log(lapsCompleted)
}
addLaps()
addLaps()
addLaps()

let username = "Pear"
let message = "You have three new notifications"
let messageToUser = message + " " + username + "!"

console.log(messageToUser)

let name = "Pauline"
let greeting = "Hello, my name is "

let myGreeting = greeting + name
console.log(myGreeting) 

let welcomeEl = document.getElementById("welcome-el")
// console.log(welcomeEl)
let name = "Pauline"
let greeting = "Good day, "
let myGreeting = greeting + name
welcomeEl.innerText = myGreeting
console.log(myGreeting)

welcomeEl.innerText += " 😀"
// console.log(myGreeting)