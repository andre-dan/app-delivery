module Api
  module V1
    class ProductsController < BaseController
      # GET /api/v1/products
      # Optional params: category_id, featured, shift (lunch/dinner/both), q (search)
      def index
        products = Product.all
        products = products.where(category_id: params[:category_id]) if params[:category_id].present?
        products = products.where(is_featured: true) if params[:featured].present?
        products = products.where(shift: params[:shift]) if params[:shift].present?
        products = products.where("name ILIKE ?", "%#{sanitize_search(params[:q])}%") if params[:q].present?
        render_success(products.map(&:as_api_json))
      end

      # GET /api/v1/products/:id
      def show
        product = Product.find(params[:id])
        render_success(product.as_api_json)
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Produto não encontrado." }, status: :not_found
      end

      private

      # Prevent LIKE-injection by escaping special pattern characters
      def sanitize_search(query)
        query.to_s.gsub(/[%_\\]/) { |c| "\\#{c}" }
      end
    end
  end
end
