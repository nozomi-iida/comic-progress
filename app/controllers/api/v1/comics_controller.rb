module Api
  module V1
    class ComicsController < ApplicationController
      def index
        comics = Comic.all
        render json: comics, adapter: :json
      end

      def create
        user = User.first
        comic = Comic.new(comic_params)
        comic.user_id = user.id
        if comic.save
          render json: comic, status: :created, adapter: :json
        else
          render json: { error: "can't create comic" }
        end
      end

      def show
        comic = Comic.find(params[:id])
        render json: comic, adapter: :json
      end

      def update
        comic = Comic.find(params[:id])
        comic.update(comic_params)
        render json: comic, adapter: :json
      end

      def destroy
        comic = Comic.find(params[:id])
        comic.destroy
        head 204
      end

      private

      def comic_params
        params.require(:comic).permit(:name, :volume, :image)
      end
    end
  end
end
