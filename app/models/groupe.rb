class Groupe < ActiveRecord::Base
  belongs_to :competition
  has_many :match
end
