class TextMessagesController < ApplicationController
    include CableReady::Broadcaster

    def create

        @message = TextMessage.create(text_message_params)
        if @message.valid?
            cable_ready["list_channel_#{params[:text_message][:list_id]}"].insert_adjacent_html(
                selector: "#messages",
                position: "afterbegin",
                html: render_to_string(partial: "text_messages/message", locals: {message:@message, count: @message.list.text_messages.count })
            )
            cable_ready["list_channel_#{params[:text_message][:list_id]}"].broadcast
        else
            cable_ready["list_channel_#{params[:text_message][:list_id]}"].inner_html(
                selector: "#text-message-validation-message",
                html: "<h5>Text messages must be a word and 30 characters or less!</h5>"
            )
            cable_ready["list_channel_#{params[:text_message][:list_id]}"].broadcast
        end

        # render status :ok
        # redirect_to list_path(params[:text_message][:list_id])
        # @message.save
        # redirect_to @message.list
        # if @message.save
        #     redirect_to @message
        # end

        # respond_to do |format|
        #     if @message.save
        # end
    end


    private
    def text_message_params
        # params.require(:list).permit(:title, :categories_id)
        params.require(:text_message).permit(:content, :list_id)
    end
end
