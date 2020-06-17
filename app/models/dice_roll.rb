class DiceRoll
  attr_accessor :dice_syntax, :errors, :dices, :message, :results

  def initialize(dice_syntax)
    @dice_syntax = dice_syntax
    @dices = []
    @results = []

    parse
    validate
  end

  def message
    m = []
    sum = 0
    @results.each do |ds, r|
      m.push "#{ds} => #{r}"
      sum += r
    end
    m.push "SUM: #{sum}"
    m.join("\n")
  end

  def error_messages
    m = []
    @dices.each do |d|
      m.push d.errors.full_messages
    end
    m
  end

  def roll!
    return error_messages unless valid?
    r = {}

    @dices.each do |d|
      1.upto d.amount do |i|
        c = rand(1..d.face_count)
        r["#{d.dice_syntax}(#{i})"] = c
      end
    end
    @results = r
  end

  # 1d6
  # 1d6+1d6
  # 1d6+4
  # #{amount}d#{face_count}
  # #{amount}
  # !!! not implements
  # 1d100-2d6
  def parse
    @dice_syntax.split("+").each do |d|
      amount, face_count = d.split("d")
      @dices.push Dice.new(amount, face_count)
    end
  end

  def validate
    @dices.each do |d|
      d.validate
    end
  end

  def valid?
    @dices.all? { |d| d.errors.empty? }
  end

  class Dice
    attr_accessor :amount, :face_count

    include ActiveModel::Validations
    validates :face_count, numericality: { less_than_or_equal_to: 300, greater_than: 0 }
    validates :amount, numericality: { less_than_or_equal_to: 300, greater_than: 0 }

    def initialize(amount, face_count)
      @amount = amount.to_i
      @face_count = face_count.to_i
    end

    def dice_syntax
      "#{amount}d#{face_count}"
    end
  end
end
