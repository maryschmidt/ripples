class CreateMatchesAndParticipants < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :region
      t.string :match_version
      t.string :queue_type

      t.bigint :match_duration
      t.bigint :match_id
    end

    create_table :participants do |t|
      t.integer :champion_id
      t.integer :team_id
      t.integer :participant_id

      t.integer 'items', array: true

      t.integer :gold_earned
      t.integer :gold_spent

      t.string :role

      t.integer :kills
      t.integer :deaths
      t.integer :assists

      t.boolean :win, null: false

      t.text :timeline
    end
  end
end
