class Api::ChatController < Api::BaseController

  before_action :load_establishment
  before_action :load_chat

  # GET /api/establishments/:establishment_id/chats
  def index
    render json: @chat, root: 'data'
  end

  private
  def load_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def load_chat
    @chat = @establishment.chat
  end

end
