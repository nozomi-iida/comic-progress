module Api
  module V1
    class ComicsController < ApplicationController
      def index
        comics = Comic.all
        render json: comics, adapter: :json
      end

      def create
        comic = Comic.new(comic_params)
        comic.user_id = @current_user.id
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
        if @current_user.id == comic.user.id
          comic.update(comic_params)
          render json: comic, adapter: :json
        else
          render json: { error: "can't update comic" }
        end
      end

      def destroy
        comic = Comic.find(params[:id])
        if @current_user.id == comic.user.id
          comic.destroy
          head 204
        else
          render json: { error: "can't delete comic" }
        end
      end

      private

      def comic_params
        params.require(:comic).permit(:name, :volume, :image)
      end
    end
  end
end
