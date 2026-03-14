module Api
  module V1
    class CategoriesController < BaseController
      # GET /api/v1/categories
      def index
        categories = Category.all
        include_products = ActiveModel::Type::Boolean.new.cast(params[:include_products])
        render_success(categories.map { |c| c.as_api_json(include_products: include_products) })
      end
    end
  end
end
