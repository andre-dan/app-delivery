class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string  :name,            null: false
      t.string  :email,           null: false
      t.string  :password_digest, null: false
      t.string  :phone
      t.string  :avatar_url
      t.decimal :cashback_balance, precision: 10, scale: 2, default: 0.0, null: false
      t.integer :level,            default: 1,   null: false
      t.integer :xp_points,        default: 0,   null: false
      t.integer :xp_to_next,       default: 100, null: false
      t.string  :badges,           array: true, default: []
      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
