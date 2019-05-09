class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :kind
      t.string :name
      t.integer :product_ids, array: true
      t.float :price
      t.integer :count
    end
  end
end
