class CreateColumn_set < ActiveRecord::Migration
  def change
    create_table :column_set do | t |
      t.integer :column_id
      t.integer :set_id
      t.string :changeme
      t.string :convertme
      t.timestamps
    end
  end
end



