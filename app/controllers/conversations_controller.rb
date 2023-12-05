class ConversationsController < ApplicationController
  def create
    @conversation = Conversation.find_by(conversation_params)
    if @conversation.nil?
      @conversation = Conversation.create(conversation_params)
      flash[:notice] = 'Conversation créée avec succès !'
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
