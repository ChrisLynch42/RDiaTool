class CreateColumn_set < ActiveRecord::Migration
  def change
    create_table :column_set do | t |
      t.belongs_to :column_id
      t.integer :set_id
      t.string :changeme
      t.string :convertme
      t.timestamps
    end
  add_index :column_set, :column_id
  end
end



