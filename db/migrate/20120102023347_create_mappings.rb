class CreateMappings < ActiveRecord::Migration
  def change
    create_table :mappings do |t|
      t.integer :outcome_id
      t.integer :mappable_id
      t.string :mappable_type
      t.integer :value

      t.timestamps
    end
  end
end
