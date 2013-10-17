class CreateCharacterskills < ActiveRecord::Migration
  def change
    create_table :CharacterSkills do | t |
      t.integer :character_id
      t.integer :skill_id
      t.timestamps
    end
  end
end



