module Api
  module V1
    class FavoritesController < BaseController
      # GET /api/v1/favorites  → returns array of product_ids
      def index
        ids = current_user.favorites.pluck(:product_id)
        render_success(ids)
      end

      # POST /api/v1/favorites  body: { product_id: N }
      def create
        product = Product.find(params.require(:product_id))
        fav = current_user.favorites.find_or_create_by!(product: product)
        render_success({ id: fav.id, product_id: product.id }, status: :created)
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Produto não encontrado." }, status: :not_found
      end

      # DELETE /api/v1/favorites/:product_id
      def destroy
        fav = current_user.favorites.find_by(product_id: params[:id])
        if fav
          fav.destroy
          render_success({ product_id: params[:id].to_i })
        else
          render json: { error: "Favorito não encontrado." }, status: :not_found
        end
      end
    end
  end
end
