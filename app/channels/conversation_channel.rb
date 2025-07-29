class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation_#{params[:conversation_id]}"
  end

  def speak(data)
    message = Message.create!(
      content: data["message"],
      user: current_user,
      conversation_id: params["conversation_id"]
    )

    ActionCable.server.broadcast("conversation_#{params[:conversation_id]}", {
      type: "message",
      id: message.id,
      user: current_user.email,
      content: message.content,
      timestamp: message.created_at.strftime("%H:%M")
    })
  end

  def mark_as_read(data)
    message_ids = data["message_ids"]
    Message.where(id: message_ids, read_at: nil).update_all(read_at: Time.current)

    ActionCable.server.broadcast("conversation_#{params['conversation_id']}", {
      type: "read",
      ids: message_ids
    })
  end
end
