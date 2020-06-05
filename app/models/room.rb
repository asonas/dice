class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  def register!
    self.uuid = SecureRandom.uuid
    self.save!
  end
end
