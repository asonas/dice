class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room"
  end

  def send_message(payload)
    dice_roll = DiceRoll.new(payload[:dice_syntax])
    dice_roll.roll!
    room = Room.find_by!(uuid: payload[:room_uuid])

    if dice_roll.valid? && Message.create(room_id: room.id, body: dice_roll.message, player_name: payload[:player_name], dice_syntax: payload[:dice_syntax])
      ActionCable.server.broadcast "room", message: render(message)
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
  end

  private
  def render(message)
    ApplicationController.new.helpers.c("message", message: message)
  end
end
