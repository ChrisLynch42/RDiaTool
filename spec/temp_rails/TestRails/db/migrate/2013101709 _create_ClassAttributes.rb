class CreateClassattributes < ActiveRecord::Migration
  def change
    create_table :ClassAttributes do | t |
      t.integer :class_id
      t.string :title
      t.integer :level
      t.string :description
      t.timestamps
    end
  end
end



