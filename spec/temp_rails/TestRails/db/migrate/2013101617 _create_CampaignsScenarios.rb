class CreateCampaignsscenarios < ActiveRecord::Migration
  def change
    create_table :CampaignsScenarios do | t |
      t.integer :campaign_id
      t.integer :scenario_id
      t.timestamps
    end
  end
end



