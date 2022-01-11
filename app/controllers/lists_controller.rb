require 'digest/sha1'

class ListsController < ApplicationController
  include CableReady::Broadcaster

  before_action :set_list, only: %i[ show edit update destroy ]
  before_action :log_impression, :only=> [:show]

  # GET /lists or /lists.json
  def index
    @numCols = 3

    @recent_lists = List.all.order(created_at: :desc).limit(6)

    top_impressions = Impression.where(impressionable_type: "List").group(:impressionable_id).count.sort_by {|_key, value| -value}.map {|row| row[0]}

    # byebug

    @hottest_lists = List.where(id: top_impressions).limit(6)
    # byebug

    # @popular_lists = [31, 40, 50, 51, 52, 53, 54, 55]
  end

  # GET /lists/1 or /lists/1.json
  def show
    # conn = ActionCable.server.connections.first { |c| c.current_user == user_id }
    # @num_viewers = conn.count_unique_connections(params[:id])
    # byebug
    @text_message_len = @list.text_messages.count
  end

  # # GET /lists/new
  def new
    @list = List.new
  end

  # # GET /lists/1/edit
  # def edit
  # end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params)
    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /lists/1 or /lists/1.json
  # def update
  #   respond_to do |format|
  #     if @list.update(list_params)
  #       format.html { redirect_to @list, notice: "List was successfully updated." }
  #       format.json { render :show, status: :ok, location: @list }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @list.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end

  end

  def create_copy_text
    list = List.find(params[:id])
    # byebug
    result = []
    list.text_messages.each do |text_message|
      result << text_message.content
    end
    # add joining line to end of string as well
    result = result.join(", ") + "\n"
    respond_to do |format|
      format.json { render json: { data: result }.to_json }
    end
    list.increment!(:num_copies)
  end

  def log_impression
    @list = List.find(params[:id])
    # this assumes you have a current_user method in your authentication system
    @list.impressions.create(ip_address: request.remote_ip)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      # params.require(:list).permit(:title, :categories_id)
      params.require(:list).permit(:title, category_ids: [])
    end
end
