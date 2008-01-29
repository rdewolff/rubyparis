class Equipe < ActiveRecord::Base
  belongs_to :entraineur
  belongs_to :nation, :foreign_key => "pays"
  has_many :joueur, :foreign_key => "club"
  has_many :match #, :class_name => "Match"
end
