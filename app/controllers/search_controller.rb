class SearchController < ApplicationController

    def index

        title_order = params[:sort_title] == true.to_s ? :asc : :desc
        created_order = params[:sort_created_at] == true.to_s ? :asc : :desc
        updated_order = params[:sort_updated_at] == true.to_s ? :asc : :desc
        num_copies_order = params[:sort_num_copies] == true.to_s ? :asc : :desc
        num_items_order = params[:sort_num_items] == true.to_s ? :asc : :desc

        @lists = List.search(params[:search]).order(created_at: created_order);
        # @lists = List.search(params[:search]).order(title: title_order, created_at: created_order, updated_at: updated_order, num_copies: num_copies_order);
        # byebug
        @filter_settings = {sort_title: params[:sort_title], sort_created_at: params[:sort_created_at], sort_updated_at: params[:sort_updated_at], sort_num_copies: params[:sort_num_copies], sort_num_items: params[:sort_num_items]}
    end

    private
    def list_search_params
        params.permit(:search)
    end
end
