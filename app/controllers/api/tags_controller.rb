class Api::TagsController < Api::BaseController

  # GET /api/tags
  def index
    @tags = Tag.all.order(:name)
    render json: @tags, root: 'data'
  end
end
