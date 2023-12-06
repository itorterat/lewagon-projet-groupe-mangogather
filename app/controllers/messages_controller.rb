class MessagesController < ApplicationController
  before_action :set_conversation
  before_action :check_participation, only: %i[index new create]

  def index
    @messages = @conversation.messages
    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    user_ids = [@conversation.sender_id, @conversation.recipient_id]
    @message.author_id = current_user.id
    @message.receiver_id = user_ids.reject { |id| id == current_user.id }.first

    if @message.save
      ConversationChannel.broadcast_to(
        @conversation,
        render_to_string(partial: "messages/message", locals: { message: @message })
      )
      head :ok
    else
      render turbo_stream: turbo_stream.replace('message_form',
                                                partial: 'messages/form',
                                                locals: { conversation: @conversation, message: @message })
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def check_participation
    unless current_user.conversations.exists?(@conversation.id)
      redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cette conversation."
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
