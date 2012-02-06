class CreateContentGroups < ActiveRecord::Migration
  def change
    create_table :content_groups do |t|
      t.integer :offering_id
      t.string :name

      t.timestamps
    end

    change_table :content do |t|
      t.integer :content_group_id
      t.remove :offering_id
    end
  end
end
