class Api::ZipcodeController < ApplicationController

  # GET /api/zipcode
  def index
    response = ViaCep::Address.new(params[:zipcode]) rescue nil

    unless response
      return render :json => { :error => { :description => "Nenhum resultado encontrado com este cep", :code => 422 }} , :status => 422
    else
      city = City.find_by(name: response.city)

      @address = Address.new(
        city_id: city.id,
        zipcode: response.zipcode,
        street: response.street,
        number: params[:number],
        neighborhood: response.neighborhood
      )

      render json: @address, root: 'data'
    end
  end
end
