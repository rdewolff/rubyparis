class Administrateur < ActiveRecord::Base
  belongs_to :utilisateur, :foreign_key => "id"
  has_many :competition
end
