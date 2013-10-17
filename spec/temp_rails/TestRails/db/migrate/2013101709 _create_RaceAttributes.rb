class CreateRaceattributes < ActiveRecord::Migration
  def change
    create_table :RaceAttributes do | t |
      t.integer :race_id
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end



