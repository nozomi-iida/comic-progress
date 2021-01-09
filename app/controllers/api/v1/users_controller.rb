module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorized, only: [:auto_login]

      def index
        users = User.all
        render json: { users: users }
      end

      def create
        user = User.new(user_params)
        if user.save
          token = encode_token({ user_id: user.id })
          render json: { user: user, token: token }, status: :created
        end
      end

      def login
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          token = encode_token({ user_id: user.id })
          render json: { user: user, token: token }
        else
          render json: { error: "Invalid email or password" }
        end
      end

      def auto_login
        render json: user
      end

      def destroy
        user = User.find(params[:id])
        user.destroy
        head 204
      end

      private

      def user_params
        # FIXME: password,confirm_passwordが入ってくれない
        # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
        params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end
    end
  end
end
