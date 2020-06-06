class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    dice_roll = DiceRoll.new(data["dice_syntax"])
    dice_roll.roll!
    room = Room.find_by!(uuid: data["room_uuid"])
    message = Message.create(room_id: room.id, body: dice_roll.message, player_name: data["player_name"], dice_syntax: data["dice_syntax"])

    if dice_roll.valid? && message.save
      ActionCable.server.broadcast 'room_channel', message: render_message(message)
    else
    end
  end

  private
  def render_message(message)
    ApplicationController.renderer.render partial: 'messages/message', locals: { message: message }
  end
end
