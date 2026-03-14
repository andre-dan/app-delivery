class AddApiFieldsToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :image_url,       :string
    add_column :products, :is_featured,     :boolean, default: false, null: false
    add_column :products, :is_customizable, :boolean, default: false, null: false
    add_column :products, :rating,          :decimal, precision: 3, scale: 2, default: 0.0
    add_column :products, :rating_count,    :integer, default: 0
    add_column :products, :emoji,           :string
  end
end
