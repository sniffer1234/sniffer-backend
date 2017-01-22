class Api::EstablishmentsController < ApplicationController

  # GET /api/establishments
  def index
    e = {
      data: [
        {
          id: 1,
          name: 'Pacha Floripa',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          image: 'http://leocoelho.com/website/wp-content/uploads/2012/12/Pacha-Floripa-reformada.jpg',
          phone: '(48) 3225-5596',
          address: 'Rodovia Jornalista Maurício Sirotski Sobrinho, s/n - Jurerê Internacional, Florianópolis - SC, 88058-250'
        },
        {
          id: 2,
          name: 'Jhon Bull Club',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          image: 'https://media-cdn.tripadvisor.com/media/photo-s/09/b1/5a/ce/john-bull-floripa.jpg',
          phone: '(48) 3225-5596',
          address: 'Rodovia Jornalista Maurício Sirotski Sobrinho, s/n - Jurerê Internacional, Florianópolis - SC, 88058-250'
        },
        {
          id: 3,
          name: 'Parador P12',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          image: 'http://www.festadasemana.com.br/florianopolis/imagens/estabelecimento/f4172.jpg',
          phone: '(48) 3225-5596',
          address: 'Rodovia Jornalista Maurício Sirotski Sobrinho, s/n - Jurerê Internacional, Florianópolis - SC, 88058-250'
        }
      ]
    }

    render json: e
  end

  def show
  end
end
