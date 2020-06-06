import consumer from "./consumer"

const chatChannel = consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('connected')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log('disconnected')
  },

  received(data) {
    console.log("received: " + data)
    return document.querySelector('.js-messages').insertAdjacentHTML('afterbegin', data['message']);
  },

  speak: function() {
    console.log("speak: ")
    let roomUuid = document.querySelector(".js-room-id").value
    let playerName = document.querySelector(".js-player-name").value
    let skillName = document.querySelector(".js-skill-name").value
    let diceSyntax = document.querySelector(".js-dice-syntax").value
    console.log(diceSyntax)
    return this.perform('speak', {
      room_uuid: roomUuid,
      player_name: playerName,
      skill_name: skillName,
      dice_syntax: diceSyntax,
    });
  }
});

window.addEventListener('DOMContentLoaded', (event) => {
  console.log('DOM fully loaded and parsed');
  document.querySelector(".js-message-form--submit").addEventListener('click', (event) => {
    event.preventDefault();
    console.log('click')
    chatChannel.speak()
  });
});


