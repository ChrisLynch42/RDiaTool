class CreateCharacterweapons < ActiveRecord::Migration
  def change
    create_table :CharacterWeapons do | t |
      t.integer :character_id
      t.integer :weapon_id
      t.timestamps
    end
  end
end



