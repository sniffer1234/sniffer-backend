class Api::SniffsController < Api::BaseController

  # GET /api/sniffs
  def index


    #
    #
    #
    # TODO IMPROVE THIS
    if params[:establishment_id]
      @sniffs = Sniff.where(sniffable_type: 'Establishment', sniffable_id: params[:establishment_id])
      render json: @sniffs, root: 'data'
    else
      @establishments = Establishment.joins(:sniffs)
                                     .page(params[:page] || 1)

      render json: @establishments,
             each_serializer: EstablishmentSniffSerializer,
             root: 'data',
             meta: pagination_dict(@establishments)
    end
  end
end
