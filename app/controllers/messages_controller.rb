class MessagesController < ApplicationController
  def create(room_uuid, message)
    dice_roll = DiceRoll.new(message[:dice_syntax])
    dice_roll.roll!
    room = Room.find_by!(uuid: room_uuid)

    if dice_roll.valid? && Message.create(room_id: room.id, body: dice_roll.message, player_name: "asonas", dice_syntax: message[:dice_syntax])
      redirect_to room_path(uuid: room.uuid)
    else
    end
  end
end
