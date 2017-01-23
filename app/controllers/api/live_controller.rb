class Api::LiveController < Api::BaseController
  def index
    s = {
      data: [
        {
          id: 1,
          name: 'Marcos',
          time: '15:00',
          image: 'https://upload.wikimedia.org/wikipedia/en/e/ef/Pacha_logo.png',
          video: ''
        },
        {
          id: 2,
          name: 'José',
          time: '16:00',
          image: 'https://upload.wikimedia.org/wikipedia/en/e/ef/Pacha_logo.png',
          video: ''
        },
        {
          id: 3,
          name: 'Rafael',
          time: '18:00',
          image: 'https://upload.wikimedia.org/wikipedia/en/e/ef/Pacha_logo.png',
          video: ''
        }
      ]
    }

    render json: s
  end
end
