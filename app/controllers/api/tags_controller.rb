class Api::TagsController < Api::BaseController

  def index
    @tags = Tag.all.order(:name)

    render json: @tags, root: 'data'
  end
end
