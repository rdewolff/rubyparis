class Joueur < ActiveRecord::Base
  belongs_to :sportif, :foreign_key => "id"
  belongs_to :position
  belongs_to :equipe, :foreign_key => "club"
end
