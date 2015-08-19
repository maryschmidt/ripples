class Participant < ActiveRecord::Base
  include Clusterable

  belongs_to :match
end
