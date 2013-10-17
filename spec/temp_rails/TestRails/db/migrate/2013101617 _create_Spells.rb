class CreateSpells < ActiveRecord::Migration
  def change
    create_table :Spells do | t |
      t.string :title
      t.string :description
      t.integer :level
      t.integer :domain_id
      t.integer :range
      t.string :damage
      t.string :requirement
      t.string :effect
      t.string :special
      t.boolean :ritual
      t.timestamps
    end
  end
end



