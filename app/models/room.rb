class Room < ApplicationRecord

  def register!
    self.uuid = SecureRandom.uuid
    self.save!
  end
end
