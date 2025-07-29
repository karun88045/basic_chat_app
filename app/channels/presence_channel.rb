class PresenceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "presence"

    ActionCable.server.broadcast("presence", {
      type: "join",
      user: current_user.email
    })
  end

  def unsubscribed
    ActionCable.server.broadcast("presence", {
      type: "leave",
      user: current_user.email
    })
  end
end
