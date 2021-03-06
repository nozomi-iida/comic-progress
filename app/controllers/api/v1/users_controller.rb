module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorized, only: [:auto_login, :index]

      def index
        users = User.all
        render json: users, adapter: :json
      end

      def create
        user = User.new(user_params)
        expires_in = 1.month.from_now.to_i # 再ログインを必要とするまでの期間を１ヶ月とした場合
        if user.save
          user.send_activation_email
          # token = encode_token({ user_id: user.id, exp: expires_in })
          if user.activated?
            render json: user, status: :created, adapter: :json
          else
            render json: { warning: "Check your email for the activation link" }
          end
        else
          render json: { error: "Invalid email or password" }
        end
      end

      def destroy
        user = User.find(params[:id])
        user.destroy
        head 204
      end

      def login
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          token = encode_token({ user_id: user.id })
          render json: user, meta: { token: token }, adapter: :json
        else
          render json: { error: "Invalid email or password" }
        end
      end

      def auto_login
        render json: user
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end
    end
  end
end
