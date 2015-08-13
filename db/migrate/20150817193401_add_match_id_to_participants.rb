class AddMatchIdToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :match_id, :bigint
  end
end
