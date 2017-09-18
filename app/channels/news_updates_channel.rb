class NewsUpdatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{self.channel_name}:messages"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
