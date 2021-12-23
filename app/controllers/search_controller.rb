class SearchController < ApplicationController

    def index

        @lists = List.search(params[:search])
        @categories = Category.all.order(title: :asc)
    end

    private
    def list_search_params
        params.permit(:search)
    end
end
