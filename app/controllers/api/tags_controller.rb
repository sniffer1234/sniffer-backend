class Api::TagsController < Api::BaseController

  def index
    @tags = {
      data: Tag.aliases.map { |tag, key| { name: I18n.t(tag), alias: tag } }
    }
    
    render json: @tags, root: 'data'
  end
end
