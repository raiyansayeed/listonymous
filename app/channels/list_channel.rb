class ListChannel < ApplicationCable::Channel
  def subscribed
    stream_from "list_channel_#{params[:list_id]}"
    # byebug
    counter = count_unique_connections(params[:list_id])
    cable_ready["list_channel_#{params[:list_id]}"].inner_html(
      selector: "#num-viewers",
      html: counter.to_s
    )
    cable_ready["list_channel_#{params[:list_id]}"].broadcast
    ActionCable.server.broadcast("list_channel_#{params[:list_id]}", counter: counter)
    # byebug
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    counter = count_unique_connections(params[:list_id])
    cable_ready["list_channel_#{params[:list_id]}"].inner_html(
      selector: "#num-viewers",
      html: counter.to_s
    )
    cable_ready["list_channel_#{params[:list_id]}"].broadcast
    ActionCable.server.broadcast("list_channel_#{params[:list_id]}", counter: counter)
  end

  # https://stackoverflow.com/questions/46683252/actioncable-display-correct-number-of-connected-users-problems-multiple-tabs
  def update_viewers_counter
    # byebug
    counter = count_unique_connections(params[:list_id])
    cable_ready["list_channel_#{params[:list_id]}"].inner_html(
      selector: "#num-viewers",
      html: counter.to_s
    )
    cable_ready["list_channel_#{params[:list_id]}"].broadcast
    ActionCable.server.broadcast("list_channel_#{params[:list_id]}", counter: counter)
  end

  def count_unique_connections(list_id)
    connected_users = Hash.new { |h, k| h[k] = [] }
    ActionCable.server.connections.each do |connection|
      connected_users[list_id].push(connection.session_id)
    end
    return connected_users[list_id].uniq { |sess| sess.to_s }.length
  end

end