class Equipe < ActiveRecord::Base
  belongs_to :entraineur
  has_many   :joueur
end
