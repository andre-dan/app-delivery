module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :verify_authenticity_token

      # POST /api/v1/auth/register
      def register
        user = User.new(register_params)
        if user.save
          render json: token_response(user), status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # POST /api/v1/auth/login
      def login
        user = User.find_by(email: login_params[:email].downcase)
        if user&.authenticate(login_params[:password])
          render json: token_response(user)
        else
          render json: { error: "Email ou senha inválidos." }, status: :unauthorized
        end
      end

      # POST /api/v1/auth/refresh
      def refresh
        payload = JsonWebToken.decode(params.require(:refresh_token))
        raise JWT::DecodeError, "Invalid token type" unless payload[:type] == "refresh"

        user = User.find(payload[:user_id])
        render json: {
          access_token:  JsonWebToken.encode_access(user.id),
          refresh_token: JsonWebToken.encode_refresh(user.id)
        }
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
        render json: { error: "Unauthorized: #{e.message}" }, status: :unauthorized
      end

      private

      def register_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone)
      end

      def login_params
        params.require(:session).permit(:email, :password)
      end

      def token_response(user)
        {
          access_token:  JsonWebToken.encode_access(user.id),
          refresh_token: JsonWebToken.encode_refresh(user.id),
          user:          user.as_api_json
        }
      end
    end
  end
end
