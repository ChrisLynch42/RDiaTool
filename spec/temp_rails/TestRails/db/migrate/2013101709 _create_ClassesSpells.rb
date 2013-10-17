class CreateClassesspells < ActiveRecord::Migration
  def change
    create_table :ClassesSpells do | t |
      t.integer :class_id
      t.integer :spell_id
      t.timestamps
    end
  end
end



