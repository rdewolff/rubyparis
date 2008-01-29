class Match < ActiveRecord::Base
  belongs_to :groupe
  belongs_to :arbitre
  belongs_to :equipea, :class_name => "Equipe", :foreign_key => "equipeA"
  belongs_to :equipeb, :class_name => "Equipe", :foreign_key => "equipeB"
  has_and_belongs_to_many :parieur
end