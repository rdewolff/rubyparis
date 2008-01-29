class Sportif < ActiveRecord::Base
  belongs_to :personne, :foreign_key => "id"
  belongs_to :nation, :foreign_key => "pays"
  has_one :entraineur
end
