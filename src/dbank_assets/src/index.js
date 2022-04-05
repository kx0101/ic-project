import {dbank} from "../../declarations/dbank";

// async updating the current amount.
window.addEventListener("load", async function() {
  const currentAmount = await dbank.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
});

document.querySelector("form").addEventListener("submit", async function(e) {
  e.preventDefault();

  // disabling the button so the user does not spam the button since the update function
  // takes a while to load.
  const button = e.target.querySelector("submit-btn");
  button.setAttribute("disabled", true);

  // parseFloat because in declerations the functions should return a float value
  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  await dbank.topUp(inputAmount);

  // updating the currentAmount
  const currentAmount = await dbank.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;

  button.removeAttribute('disabled');

});