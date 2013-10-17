class CreateScenarioscharacters < ActiveRecord::Migration
  def change
    create_table :ScenariosCharacters do | t |
      t.integer :character_id
      t.integer :scenario_id
      t.timestamps
    end
  end
end



