class CreateOutcomes < ActiveRecord::Migration
  def change
    create_table :outcomes do |t|
      t.string :key
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
