class Api::ChatMessagesController < Api::BaseController

  before_action :load_establishment
  before_action :load_chat, only: [:create]

  # GET /api/establishments/:establishment_id/chats/:chat_id/:chat_message
  def create
    @chat_message = @chat.chat_messages.build(chat_message_params)

    unless @chat_message.save
      return render :json => { :error => { :code => 422, :description =>  @chat_message.errors.full_messages } }, :status => 422
    end

    message = ActiveModelSerializers::SerializableResource.new(@chat_message, adapter: :json, root: 'data').as_json

    Pusher.trigger("chat-#{@chat_message.chat.id}",
                   'new:message',
                    message
                  )

    render json: @chat_message, root: 'data'
  end

  private
  def load_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def load_chat
    @chat = @establishment.chat
  end

  def chat_message_params
    params.require(:chat_message).permit(
      :content
    ).merge(user_id: @current_user.id)
  end
end
