class CreateContent < ActiveRecord::Migration
  def change
    create_table :content do |t|
      t.integer :offering_id
      t.integer :position
      t.string :title

      t.timestamps
    end
  end
end
