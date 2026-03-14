module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      before_action :authenticate_user!

      private

      def authenticate_user!
        header = request.headers["Authorization"]
        token  = header&.split(" ")&.last
        raise JWT::DecodeError, "Missing token" if token.blank?

        payload = JsonWebToken.decode(token)
        raise JWT::DecodeError, "Invalid token type" unless payload[:type] == "access"

        @current_user = User.find(payload[:user_id])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
        render json: { error: "Unauthorized: #{e.message}" }, status: :unauthorized
      end

      def current_user
        @current_user
      end

      def render_success(data, status: :ok)
        render json: { data: data }, status: status
      end

      def render_errors(resource, status: :unprocessable_entity)
        render json: { errors: resource.errors.full_messages }, status: status
      end
    end
  end
end
