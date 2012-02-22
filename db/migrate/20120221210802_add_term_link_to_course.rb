class AddTermLinkToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :created_term_id, :integer
    add_column :courses, :retired_term_id, :integer
  end
end
