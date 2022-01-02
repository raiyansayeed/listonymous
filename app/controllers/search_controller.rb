class SearchController < ApplicationController

    def index
        @q = List.ransack(params[:q])
        @pagy, @lists = pagy_countless(@q.result(distinct: true))
        @categories = Category.all.order(title: :asc)
        # byebug
    end

    private
    def list_search_params
        params.permit(:search, :q)
    end
end
