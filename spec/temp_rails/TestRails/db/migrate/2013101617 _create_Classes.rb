class CreateClasses < ActiveRecord::Migration
  def change
    create_table :Classes do | t |
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end



