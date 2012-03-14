class AddRequiredFieldsToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :required_for_bsce, :string

    add_column :offerings, :required_for_bsenve, :string
  end
end
