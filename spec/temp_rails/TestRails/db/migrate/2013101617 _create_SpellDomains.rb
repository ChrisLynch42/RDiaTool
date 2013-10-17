class CreateSpelldomains < ActiveRecord::Migration
  def change
    create_table :SpellDomains do | t |
      t.string :name
      t.string :description
      t.timestamps
    end
  end
end



