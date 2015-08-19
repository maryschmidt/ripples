class Match < ActiveRecord::Base
  include Clusterable

  has_many :participants, dependent: :destroy
end
