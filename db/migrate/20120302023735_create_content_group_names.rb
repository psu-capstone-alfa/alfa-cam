class CreateContentGroupNames < ActiveRecord::Migration
  def change
    create_table :content_group_names do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end

    add_column :content_groups, :content_group_name_id, :integer
    remove_column :content_groups, :name
  end
end
