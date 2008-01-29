class Utilisateur < ActiveRecord::Base
  belongs_to :personne, :foreign_key => "id"
  has_one :administrateur
  has_one :parieur
end