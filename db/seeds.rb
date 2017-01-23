require 'net/http'
require 'net/https'
require 'json'


# Set cities and state
http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
states = JSON.parse http.get('/celsodantas/br_populate/master/states.json').body

states.each do |s|
  state = State.new(name: s["name"], short_name: s["acronym"], region: s["region"])
  state.save!

  last_state = State.last

  s["cities"].each do |c|
    city = City.new(name: c['name'], state_id: last_state.id)
    city.save!
  end
end

#Users
u = User.new(email: 'rafaelmotta021@gmail.com', password: 'galera07', name: 'Rafael Motta').save
u = User.new(email: 'marcosdemetrio@gmail.com', password: 'galera07', name: 'Marcos Demetrio').save


# Establishment
Establishment.create(
  name: 'Pacha Floripa',
  description: 'A praia de Jurerê Internacional abriga a Pacha Floripa, clube de 110 mil metros quadrados que tem capacidade para atender até 12 mil pessoas. Sob a administração dos grupos El Divino, Sirena e Warung, a Pacha Floripa conta com pista interativa - onde o gênero eletrônico house predomina e há 25 camarotes com entrada e estacionamento exclusivos. A casa também disponibiliza um palco livre para shows de artistas internacionais. Nove bares, um espaço gourmet, que serve pizzas e sushis, e estacionamento com capacidade para três mil veículos completam a lista de serviços oferecidos.',
  phone: '(48) 3282-2054',
  email: 'contato@pachafloripa.com.br',
  facebook: 'https://www.facebook.com/pachafloripa/?fref=ts',
  instagram: 'https://www.instagram.com/pachafloripaoficial'
)

Address.create(
  city_id: City.where(name: 'Florianópolis').first.id,
  addressable_id: Establishment.find(1).id,
  addressable_type: 'Establishment',
  street: 'Rodovia Jornalista Maurício Sirotski Sobrinho',
  number: 's/n',
  zipcode: '88058-250',
  neighborhood: 'Jurerê'
)

Establishment.create(
  name: 'Chop do Gus',
  description: 'Ambiente aconchegante, com estilo de botequim e decoração exclusiva. Música ao vivo todos os dias, porções exclusivas com pratos flambados, delicioso chopp Brahma e uma harmoniosa carta de vinhos.',
  phone: '(48) 3028-5807',
  email: 'contato@chopdogus.com.br',
  facebook: 'https://www.facebook.com/choppdogusoficial'
)

Address.create(
  city_id: City.where(name: 'Florianópolis').first.id,
  addressable_id: Establishment.find(2).id,
  addressable_type: 'Establishment',
  street: 'R. João Pio Duarte Silva',
  number: '1650',
  zipcode: '88037-001',
  neighborhood: 'Córrego Grande'
)

Establishment.create(
  name: 'P12',
  description: 'Junto à praia, amplo espaço reconhecido pelas pool parties e música eletrônica também recebe artistas famosos.',
  phone: '(48) 3284-8156',
  email: 'contato@p12.com.br',
  facebook: 'https://www.facebook.com/p12jurere',
  instagram: 'https://www.instagram.com/p12jurere/?hl=pt-br'
)

Address.create(
  city_id: City.where(name: 'Florianópolis').first.id,
  addressable_id: Establishment.find(3).id,
  addressable_type: 'Establishment',
  street: 'Servidão José Cardoso de Oliveira',
  number: 's/n',
  zipcode: '88053-306',
  neighborhood: 'Jurerê Internacional'
)
