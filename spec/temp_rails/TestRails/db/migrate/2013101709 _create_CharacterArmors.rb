class CreateCharacterarmors < ActiveRecord::Migration
  def change
    create_table :CharacterArmors do | t |
      t.integer :character_id
      t.integer :armor_id
      t.boolean :donned
      t.timestamps
    end
  end
end



