module Api
  module V1
    class ComicsController < ApplicationController
      def index
        @comics = RakutenWebService::Books::Book.search(size: "9")
        render json: { comics: @comics }
      end
    end
  end
end
