class Nation < ActiveRecord::Base
  has_many :equipe
  has_many :sportif
  validates_presence_of :pays
  validates_uniqueness_of :pays
end
