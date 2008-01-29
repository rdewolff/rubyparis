class Arbitre < ActiveRecord::Base
  belongs_to :sportif, :foreign_key => "id"
  has_many :match
end
