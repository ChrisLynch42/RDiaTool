class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :Campaigns do | t |
      t.string :name
      t.string :description
      t.timestamps
    end
  end
end



