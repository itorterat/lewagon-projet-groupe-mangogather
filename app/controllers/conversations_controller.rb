class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.joins(:messages)
                                 .where('sender_id = ? OR recipient_id = ?', current_user.id, current_user.id)
                                 .distinct
                                 .includes(:messages)
                                 .sort_by { |conversation| conversation.messages.last.created_at }
                                 .reverse
  end


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
