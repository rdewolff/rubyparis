class Match < ActiveRecord::Base
  belongs_to :groupe
  belongs_to :arbitre
  belongs_to :equipe, :foreign_key => "equipeA"
  belongs_to :equipe, :foreign_key => "equipeB"
  has_and_belongs_to_many :parieur
end