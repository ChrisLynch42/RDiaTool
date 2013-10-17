class CreateArmors < ActiveRecord::Migration
  def change
    create_table :Armors do | t |
      t.string :title
      t.string :description
      t.float :cost
      t.integer :armor_bonus
      t.integer :weight
      t.integer :speed
      t.integer :don
      t.integer :remove
      t.timestamps
    end
  end
end



