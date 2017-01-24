class Admin::SniffsController < Admin::BaseController

  before_action :load_sniff, only: [:create, :destroy]

  # GET /admin/users
  def index
    @sniffs = Sniff.all.page(params[:page] || 1)
  end

  # POST /admin/users
  def create
  end

  # PUT /admin/users/:id
  def update
  end

  # DELETE /admin/users/:id
  def destroy
  end

  private
  def load_sniff
  end

end
