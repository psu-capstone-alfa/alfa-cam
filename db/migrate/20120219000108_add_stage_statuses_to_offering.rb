class AddStageStatusesToOffering < ActiveRecord::Migration
  def change
    add_column :offerings, :review_done, :boolean
    add_column :offerings, :importing_done, :boolean
    add_column :offerings, :details_done, :boolean
    add_column :offerings, :objectives_done, :boolean
    add_column :offerings, :content_done, :boolean
    add_column :offerings, :assessments_done, :boolean
  end
end
