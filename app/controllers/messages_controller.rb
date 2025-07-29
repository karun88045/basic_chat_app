class MessagesController < ApplicationController
  # before_action :authenticate_user!

  # def index
  #   @messages = Message.all
  # end

  # def new
  #   @message = Message.new
  # end

  # def create
  #   message = current_user.messages.build(body: params[:body])
  #   if message.save
  #     redirect_to chat_rooms_path
  #   end
  # end

  # def show
  # end

  # def edit
  # end

  # private

  # def message_params
  #   # params.require(:message).permit(:body, :user_id)

  # end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params.merge(user: current_user))

    if @message.save
      # broadcast is handled via after_create_commit
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
