// define two variable numbers
let num1 = 8;
let num2 = 2;
// get by document (link the two docs)
document.getElementById("num1-el").textContent = num1
document.getElementById("num2-el").textContent = num2

let sumEl = document.getElementById("sum-el")

// create functions for each button 
function add() {
    // console.log("Add button was clicked")
    let sum1 = num1 + num2
    // console.log(sum1)
    sumEl.textContent = "Sum: " + sum1
}

 function subtract() {
     // console.log("Subtract button was clicked")
    let sum2 = num1 - num2
    // console.log(sum2)
    sumEl.textContent = "Sum: " + sum2
}

function divide() {
    // console.log("Divide button was clicked")
    let sum3 = num1 / num2
    // console.log(sum3)
    sumEl.textContent = "Sum: " + sum3
}

function multiply() {
     // console.log("Multiplication button was clicked")
    let sum4 = num1 * num2
     // console.log(sum4)
    sumEl.textContent = "Sum: " + sum4
}

// let sumEl = document.getElementById("sum-el")


// // monthly subscription model 