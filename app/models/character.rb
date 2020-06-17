require 'csv'
class Character < ApplicationRecord
  validates :name, uniqueness: true
  ACCEPTED_NPC_ATTRIBUTES = %w[
    name
    siz
    app
    str
    con
    dex
    int
    edu
    pow
    san
  ].freeze
  attr_accessor :parsed_params

  def self.load_from_csv!(csv)
    csv = CSV.parse(csv, headers: true)

    csv.each do |row|
      Character.create!(
        player_name: row["シート名"],
        name: row["キャラ名"],
        siz: row["SIZ(体格)"],
        app: row["APP(外見)"],
        str: row["STR(筋力)"],
        con: row["CON(体力)"],
        dex: row["DEX(敏捷)"],
        int: row["INT(知性)"],
        edu: row["EDU(教育)"],
        pow: row["POW(精神力)"],
        san: row["現在の正気"],
        raw_data: row.to_h.to_json
      )
    end
  end

  IGNORE_SKILL_NAME = %w[
    シート名
    キャラ名
    イメージ
    SIZ(体格)
    APP(外見)
    STR(筋力)
    CON(体力)
    DEX(敏捷)
    INT(知性)
    EDU(教育)
    POW(精神力)
    現在の正気
    現在の幸運
    現在の耐久
    現在のMP
    現金
    支払レベル
    資産
  ].freeze

  def skills
    json = JSON.parse(self.raw_data)
    s = {}
    json.each do |key, value|
      next if IGNORE_SKILL_NAME.include? key
      normalize_value = value.match(/^\d+/)[0]
      s["#{key}(#{value})"] = normalize_value.to_i
    end
    s.sort { |a, b| a[1] <=> b[1] }.reverse
  end
end
