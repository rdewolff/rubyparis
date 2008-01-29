class Competition < ActiveRecord::Base
  belongs_to :administrateur
  has_many :groupe
  has_and_belongs_to_many :parieur
end
