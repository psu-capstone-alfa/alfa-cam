class CreateContentGroupNames < ActiveRecord::Migration
  def change
    create_table :content_group_names do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
