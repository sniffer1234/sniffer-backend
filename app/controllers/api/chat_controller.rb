class Api::ChatController < Api::BaseController

  before_action :load_establishment
  before_action :load_chat

  # GET /api/establishments/:establishment_id/chats
  def index
    @chat.messages = @chat.chat_messages.page(params[:page] || 1)
    render json: @chat, root: 'data', meta: pagination_dict(@chat.messages)
  end

  private
  def load_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def load_chat
    @chat = @establishment.chat
  end

end
