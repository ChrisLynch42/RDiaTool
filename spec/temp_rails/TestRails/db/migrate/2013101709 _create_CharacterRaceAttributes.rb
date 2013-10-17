class CreateCharacterraceattributes < ActiveRecord::Migration
  def change
    create_table :CharacterRaceAttributes do | t |
      t.integer :character_id
      t.integer :race_attribute_id
      t.timestamps
    end
  end
end



