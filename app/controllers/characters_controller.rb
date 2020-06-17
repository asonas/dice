class CharactersController < ApplicationController
  def new
  end

  def create(csv)
    Character.load_from_csv!(csv)
  end
end
