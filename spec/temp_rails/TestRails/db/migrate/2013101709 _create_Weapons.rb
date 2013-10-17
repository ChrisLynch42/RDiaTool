class CreateWeapons < ActiveRecord::Migration
  def change
    create_table :Weapons do | t |
      t.string :title
      t.string :description
      t.string :damage
      t.integer :attack_bonus
      t.integer :damage_bonus
      t.timestamps
    end
  end
end



