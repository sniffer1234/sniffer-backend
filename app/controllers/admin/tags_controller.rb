class Admin::TagsController < Admin::BaseController

  before_action :load_tag, only: [:update, :destroy, :edit]

  # GET /admin/tags
  def index
    @tags = Tag.all.order(:name).page(params[:page] || 1)
  end

  # GET /admin/tags/new
  def new
    @tag = Tag.new
  end

  # GET /admin/tags/:id
  def edit
  end

  # POST /admin/tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to admin_tags_path, notice: 'Tag criada com sucesso.'
    else
      render :new
    end
  end

  # GET /admin/tags/:id
  def update
    if @tag.update_attributes(tag_params)
      redirect_to admin_tags_path, notice: 'Tag editada com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    if @tag.destroy
      redirect_to admin_tags_path, notice: 'Tag removida com sucesso.'
    end
  end

  private
  def load_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
