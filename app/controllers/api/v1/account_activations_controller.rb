module Api
  module V1
    class AccountActivationsController < ApplicationController
      before_action :authorized, except: [:edit]

      def edit
        user = User.find_by(email: params[:email])
        expires_in = 1.month.from_now.to_i
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
          user.activate
          token = encode_token({ user_id: user.id, exp: expires_in })
          render json: user, meta: { token: token }, status: :created, adapter: :json
        else
          render json: { error: "Something wrong" }
        end
      end
    end
  end
end
