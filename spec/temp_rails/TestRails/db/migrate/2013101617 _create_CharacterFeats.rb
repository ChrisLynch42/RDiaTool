class CreateCharacterfeats < ActiveRecord::Migration
  def change
    create_table :CharacterFeats do | t |
      t.integer :character_id
      t.integer :feat_id
      t.timestamps
    end
  end
end



