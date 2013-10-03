class CreateColumn < ActiveRecord::Migration
  def change
    create_table :column do | t |
      t.string :column_name
      t.string :column_description
      t.timestamps
    end
  end
end



