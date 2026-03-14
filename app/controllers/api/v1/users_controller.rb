module Api
  module V1
    class UsersController < BaseController
      # GET /api/v1/me
      def show
        render_success(current_user.as_api_json)
      end

      # PATCH /api/v1/me
      def update
        if current_user.update(user_params)
          render_success(current_user.as_api_json)
        else
          render_errors(current_user)
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :phone, :avatar_url)
      end
    end
  end
end
