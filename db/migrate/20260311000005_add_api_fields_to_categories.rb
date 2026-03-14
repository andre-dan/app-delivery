class AddApiFieldsToCategories < ActiveRecord::Migration[8.1]
  def change
    add_column :categories, :image_url, :string
    add_column :categories, :emoji,     :string
  end
end
