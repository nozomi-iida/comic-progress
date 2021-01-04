module Api
  module V1
    class ComicsController < ApplicationController
      def index
        @comics = RakutenWebService::Books::Book.search(booksGenreId: "001005")
        render json: { status: "success", data: @comics }
      end
    end
  end
end
