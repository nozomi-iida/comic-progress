module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all
        render json: { users: users }
      end

      def create
        user = User.create(user_params)
        user.save
        render json: { users: user }, status: :created
      end

      def destroy
        user = User.find(params[:id])
        user.destroy
        head 204
      end

      private

      def user_params
        params.require(:user).permit(:first_name,
                                     :last_name,
                                     :email)
      end
    end
  end
end
