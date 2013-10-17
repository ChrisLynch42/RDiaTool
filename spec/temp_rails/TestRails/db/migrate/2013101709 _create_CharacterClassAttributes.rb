class CreateCharacterclassattributes < ActiveRecord::Migration
  def change
    create_table :CharacterClassAttributes do | t |
      t.integer :character_id
      t.integer :class_attribute_id
      t.timestamps
    end
  end
end



