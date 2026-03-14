class MenuController < ApplicationController
  def index
    @categories = Category.all
    @selected_category = @categories.find_by(id: params[:category_id]) || @categories.first
    @products = products_for(@selected_category)
  end

  # Turbo Frame endpoint — returns only the products frame
  def products
    @categories = Category.all
    @selected_category = @categories.find_by(id: params[:category_id]) || @categories.first
    @products = products_for(@selected_category)
    render partial: "menu/products", locals: { products: @products }
  end

  private

  def products_for(category)
    return Product.none unless category

    category.products.active_now
  end
end
