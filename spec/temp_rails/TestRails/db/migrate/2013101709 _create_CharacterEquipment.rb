class CreateCharacterequipment < ActiveRecord::Migration
  def change
    create_table :CharacterEquipment do | t |
      t.integer :character_id
      t.integer :equipment_id
      t.timestamps
    end
  end
end



