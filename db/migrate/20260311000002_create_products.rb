class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string     :name,        null: false
      t.text       :description
      t.decimal    :price,       null: false, default: 0, precision: 10, scale: 2
      t.references :category,    null: false, foreign_key: true
      # 0 = both, 1 = lunch, 2 = dinner  (matches Product enum)
      t.integer    :shift,       null: false, default: 0

      t.timestamps
    end

    add_index :products, :shift
  end
end
