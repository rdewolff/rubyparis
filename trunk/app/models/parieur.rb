class Parieur < ActiveRecord::Base
  belongs_to :utilisateur, :foreign_key => "id"
  has_and_belongs_to_many :competition
  has_and_belongs_to_many :match
end