module Api
  module V1
    class OrdersController < BaseController
      # GET /api/v1/orders
      def index
        orders = current_user.orders.includes(:order_items).order(created_at: :desc)
        render_success(orders.map(&:as_api_json))
      end

      # GET /api/v1/orders/:id
      def show
        order = current_user.orders.includes(:order_items).find(params[:id])
        render_success(order.as_api_json)
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Pedido não encontrado." }, status: :not_found
      end

      # POST /api/v1/orders
      def create
        ActiveRecord::Base.transaction do
          cashback_used  = [params[:cashback_used].to_f, current_user.cashback_balance].min
          cashback_used  = 0.0 if cashback_used.negative?

          order = current_user.orders.build(
            delivery_address: order_params[:delivery_address],
            payment_method:   order_params[:payment_method] || "pix",
            promo_code:       order_params[:promo_code],
            discount:         order_params[:discount].to_f,
            cashback_used:    cashback_used,
            total:            0  # calculated below
          )

          items_data = params.require(:items)
          total      = 0.0

          items_data.each do |item_params|
            product = Product.find(item_params[:product_id])
            qty     = [item_params[:quantity].to_i, 1].max
            price   = product.price.to_f
            total  += price * qty

            order.order_items.build(
              product:              product,
              product_name:         product.name,
              unit_price:           price,
              quantity:             qty,
              customizations:       item_params[:customizations] || {},
              customizations_label: item_params[:customizations_label]
            )
          end

          order.total = [total - order.discount - cashback_used, 0].max

          if order.save
            # Deduct cashback if used
            current_user.decrement!(:cashback_balance, cashback_used) if cashback_used.positive?
            render_success(order.as_api_json, status: :created)
          else
            render_errors(order)
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def order_params
        params.permit(:delivery_address, :payment_method, :promo_code, :discount)
      end
    end
  end
end
