require 'csv'
class Charactor < ApplicationRecord
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
  ]
  attr_accessor :parsed_params

  def self.load_from_csv!(csv)
    csv = CSV.parse(csv, headers: true)

    csv.each.with_index do |row|
      Charactor.create!(
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
end
