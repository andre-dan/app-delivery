class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :user,  null: false, foreign_key: true
      t.integer    :status, default: 0, null: false  # enum: pending, accepted, preparing, on_the_way, delivered, cancelled
      t.decimal    :total,              null: false, precision: 10, scale: 2
      t.text       :delivery_address
      t.integer    :payment_method, default: 0       # enum: pix, card, wallet
      t.decimal    :cashback_earned, precision: 10, scale: 2, default: 0.0
      t.decimal    :cashback_used,   precision: 10, scale: 2, default: 0.0
      t.string     :promo_code
      t.decimal    :discount,        precision: 10, scale: 2, default: 0.0
      t.timestamps
    end

    add_index :orders, :status
    add_index :orders, :created_at
  end
end
