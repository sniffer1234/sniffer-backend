class MessageChannel < ApplicationCable::Channel
  def subscribed
    puts '--- oi ------'
    puts '--- oi ------'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
