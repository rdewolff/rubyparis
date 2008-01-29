class Personne < ActiveRecord::Base
  has_one :sportif
  has_one :utilisateur
end
