class CreateOrderItems < ActiveRecord::Migration[8.1]
  def change
    create_table :order_items do |t|
      t.references :order,   null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string     :product_name, null: false  # denormalized snapshot
      t.decimal    :unit_price,   null: false, precision: 10, scale: 2
      t.integer    :quantity,     null: false, default: 1
      t.jsonb      :customizations, default: {}
      t.string     :customizations_label
      t.timestamps
    end
  end
end
