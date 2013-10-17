class ModifyColumn_set < ActiveRecord::Migration
  def change
    change_table    :column_set    do | t |
      t.integer :column_id
      t.integer :set_id
      t.string :convertme
      t.remove :nogood
    end
  end
end



