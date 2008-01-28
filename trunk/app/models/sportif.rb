class Sportif < ActiveRecord::Base
  belongs_to :personne, :foreign_key => "id"
  has_one :entraineur
end
