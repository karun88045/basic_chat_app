class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages

    # ✅ Mark incoming messages as read
    @messages.where(read_at: nil).where.not(user_id: current_user.id).update_all(read_at: Time.current)
  end

  def create
    @conversation = Conversation.between(current_user.id, params[:receiver_id]).first_or_create(
      sender_id: current_user.id,
      receiver_id: params[:receiver_id]
    )
    redirect_to conversation_path(@conversation)
  end
end
