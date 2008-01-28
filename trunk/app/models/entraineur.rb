class Entraineur < ActiveRecord::Base
  has_one :equipe
  belongs_to :sportif, :foreign_key => "id"
  # acts_as_list :scope => :parent_id # hiérarchise! ^^
end
