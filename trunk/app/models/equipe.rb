class Equipe < ActiveRecord::Base
  belongs_to :entraineur
  belongs_to :nation, :foreign_key => "pays"
  has_many :joueur
  has_many :match
end
