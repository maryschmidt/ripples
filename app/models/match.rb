class Match < ActiveRecord::Base
  has_many :participants, dependent: :destroy
end
