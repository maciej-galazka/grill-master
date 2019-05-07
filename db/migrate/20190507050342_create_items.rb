class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :quantity
      t.references :product, foreign_key: true, index: { unique: true},
                             null: false

      t.timestamps
    end
  end
end
