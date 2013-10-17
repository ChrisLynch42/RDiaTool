class CreateRaces < ActiveRecord::Migration
  def change
    create_table :Races do | t |
      t.string :title
      t.string :description
      t.boolean :npc
      t.timestamps
    end
  end
end



