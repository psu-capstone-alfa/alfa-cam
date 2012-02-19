class AddGroupToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :group, :string
  end
end
