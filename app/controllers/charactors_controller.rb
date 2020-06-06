class CharactorsController < ApplicationController
  def new
  end

  def create(csv)
    Charactor.load_from_csv!(csv)
  end
end
