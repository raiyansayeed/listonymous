class SearchController < ApplicationController

    def index
        @q = List.ransack(params[:q])
        @pagy, @lists = pagy_countless(@q.result(distinct: true))
        @categories = Category.all.order(title: :asc)

        respond_to do |format|
            format.html
            format.json { render json: { entries: render_to_string(partial: "search_results", formats: [:html]), pagination: view_context.pagy_bootstrap_nav(@pagy) }}
        end
        # byebug
    end

    private
    def list_search_params
        params.permit(:search, :q)
    end
end
