// javascript
// let count = 0
// count = count+1

// console.log(count)
// initialize count to 0
// listen for the clicks on the increment button
// increment when the button is clicked
// change the count-el in the html to reflect the new count

let countEl = document.getElementById("count-el")
// console.log(countEl)

let count = 0

function increment() {
    count += 1
    countEl.textContent = count
  //  console.log(count)
} 

let saveEl = document.getElementById("save-el")

function save() {
    let text = count + " - "
    saveEl.textContent += text
    // console.log(count)
    countEl.textContent = 0
    count = 0
}



