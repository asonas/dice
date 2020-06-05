// client/chat.jsからsendMessageをimportする必要がある
import { sendMessage } from "./index";
console.log(document.querySelector(".js-message-form"))

const form = document.querySelector(".js-message-form");
//console.log(form)
//const input = form.querySelector(".js-message-form--input");
//const submit = form.querySelector(".js-message-form--submit");

function submitForm() {
  sendMessage(input.value);
  input.value = "";
  input.focus();
}

input.addEventListener("keydown", event => {
  if (event.keyCode === 13 && event.metaKey) {
    event.preventDefault();
    submitForm();
  }
});

submit.addEventListener("click", event => {
  event.preventDefault();
  submitForm();
});
