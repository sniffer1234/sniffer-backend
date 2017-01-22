class Api::EventsController < ApplicationController
  def index
    e = {
      data: [
        {
          id: 1,
          name: 'Pato Loko',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          image: 'http://www.pilgrimageclubbingtours.com/Pacha1.jpg',
          location: 'Rodovia Jornalista Maurício Sirotski Sobrinho, s/n - Jurerê Internacional, Florianópolis - SC, 88058-250',
          establishmentID: 1
        },
        {
          id: 2,
          name: 'Fantasiarq',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          image: 'http://www.pilgrimageclubbingtours.com/Pacha1.jpg',
          location: 'Rodovia Jornalista Maurício Sirotski Sobrinho, s/n - Jurerê Internacional, Florianópolis - SC, 88058-250',
          establishmentID: 1
        },
        {
          id: 3,
          name: 'Betonada da Civil',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          image: 'http://www.pilgrimageclubbingtours.com/Pacha1.jpg',
          location: 'Rodovia Jornalista Maurício Sirotski Sobrinho, s/n - Jurerê Internacional, Florianópolis - SC, 88058-250',
          establishmentID: 1
        }
      ]
    }

    render json: e
  end

  def show
  end

  def create
  end
end
