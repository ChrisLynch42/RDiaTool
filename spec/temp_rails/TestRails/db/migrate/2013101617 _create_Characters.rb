class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :Characters do | t |
      t.integer :race_id
      t.string :class_id
      t.string :type
      t.string :Specialty
      t.string :background
      t.string :eyes
      t.string :hair
      t.string :height
      t.string :weight
      t.integer :speed
      t.string :hit_dice
      t.integer :hit_points
      t.integer :initiative
      t.string :vision
      t.string :size
      t.integer :level
      t.integer :strength
      t.integer :constitution
      t.integer :dexterity
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma
      t.string :description
      t.boolean :npc
      t.timestamps
    end
  end
end



