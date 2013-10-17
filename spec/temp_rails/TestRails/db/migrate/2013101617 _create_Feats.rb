class CreateFeats < ActiveRecord::Migration
  def change
    create_table :Feats do | t |
      t.string :title
      t.string :description
      t.string :prerequisites
      t.string :benefit
      t.timestamps
    end
  end
end



