class AddFieldsToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :credits, :string
    add_column :offerings, :day_and_time, :string
    add_column :offerings, :textbook, :text
    add_column :offerings, :additional_textbooks, :text
    add_column :offerings, :required_or_elective, :string
  end
end
