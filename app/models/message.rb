class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  after_create_commit do
    broadcast_append_to "conversation_#{conversation.id}", target: "messages"
  end
end
