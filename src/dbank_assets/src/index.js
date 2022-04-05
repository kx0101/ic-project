import {dbank} from "../../declarations/dbank";

// async updating the current amount.
window.addEventListener("load", async function() {
  update();
});

document.querySelector("form").addEventListener("submit", async function(e) {
  e.preventDefault();

  // disabling the button so the user does not spam the button since the update function
  // takes a while to load.
  const button = e.target.querySelector("#submit-btn");
  button.setAttribute("disabled", true);

  // parseFloat because in declerations the functions should return a float value
  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  if (document.getElementById("input-amount").value.length != 0){
    await dbank.topUp(inputAmount);
  } 

  if (document.getElementById("withdrawal-amount").value.length != 0){
    await dbank.withdraw(outputAmount);
  }

  // updating the compound interest
  await dbank.compound();

  update();

  // clearing the text
  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";
  button.removeAttribute('disabled');

});

async function update() {
  // updating the currentAmount
  const currentAmount = await dbank.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
}  