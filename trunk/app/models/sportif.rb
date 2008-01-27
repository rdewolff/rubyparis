class Sportif < ActiveRecord::Base
  belongs_to :personnes
  has_one :entraineurs
end
