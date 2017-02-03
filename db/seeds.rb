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
u = User.new(name: 'Rafael Motta', email: 'rafaelmotta021@gmail.com', password: 'galera07', password_confirmation: 'galera07')
u.skip_confirmation!
u.save


u = User.new(email: 'juliano@sfhera.com.br', password: 'juliano1', password_confirmation: 'galera07', name: 'Juliano Londero', role: 'admin')
u.skip_confirmation!
u.save

# Establishments
e = Establishment.create(
  name: 'Pacha Floripa',
  description: 'Os maiores clubs de música eletrônica do Brasil, Warung, Grupo Sirena e Grupo El Divino, se juntaram - formando o maior grupo de entretenimento do país – e abriram em novembro de 2008 a 3ª franquia da espanhola Pacha. Depois do sucesso do club em São Paulo (inaugurado em novembro de 2006) e Búzios – RJ (inaugurado em abril de 2007), a nova região escolhida é a badalada praia de Jurerê, em Florianópolis, SC. Modular, a casa poderá comportar de 2 a 12 mil pessoas, sendo distribuída em uma pista interativa só de house – com entrada e estacionamento exclusivo para os 25 camarotes - e uma terraza com todas as vertentes da música eletrônica. ',
  small_description: 'Os maiores clubs de música eletrônica do Brasil, Warung, Grupo Sirena e Grupo El Divino, se juntaram',
  phone: '(48) 3028-5300',
  email: 'contato@pachafloripa.com.br',
  facebook: 'https://www.facebook.com/pachafloripa/?fref=ts',
  instagram: 'https://www.instagram.com/pachafloripaoficial'
)

Address.create(
  city_id: City.where(name: 'Florianópolis').first.id,
  addressable_type: 'Establishment',
  addressable_id: Establishment.last.id,
  street: 'Rodovia Maurício Sirotsky Sobrinho',
  number: '2500',
  zipcode: '88053-700',
  neighborhood: 'Jurerê Internacional'
)

e = Establishment.create(
  name: 'John Bull Floripa',
  description: 'Ao longo de 15 anos o John Bull Floripa se consolidou como uma das mais prestigiadas casas noturnas de Florianópolis. A casa é conhecida pelos shows ao vivo com o melhor do Rock, além da decoração temática com lendas do rock,  ambiente climatizado, cardápio diferenciado, vista para a Lagoa da Conceição e estacionamento. Por diversas vezes premiada como “Melhor Casa de Música ao Vivo de Santa Catarina”, agora oferece um novo espaço gastronômico, com bares exclusivos para espumantes, vinhos, chopp e cervejas artesanais.',
  small_description: 'Uma das mais prestigiadas casas noturnas de Florianópolis.',
  phone: '(48) 3232-8535',
  email: 'contato@johnbullfloripa.com.br',
  facebook: 'https://www.facebook.com/johnbullfloripa',
  instagram: ''
)

Address.create(
  city_id: City.where(name: 'Florianópolis').first.id,
  addressable_type: 'Establishment',
  addressable_id: Establishment.last.id,
  street: 'Avenida das Rendeiras',
  number: '1046',
  zipcode: '88062-400',
  neighborhood: 'Lagoa da Conceição'
)

e = Establishment.create(
  name: 'General Lee',
  small_description: 'Casa climatizada de rock tem covers e festivais em clima intimista com cervejas seletas e menu do sul dos EUA.',
  description: 'Redneck é o termo utilizado nos Estados Unidos e Canadá para nomear o estereótipo de um homem que mora no interior e tem uma baixa renda. Sua origem deve-se ao fato de que pelo trabalho constante dos trabalhadores rurais em exposição ao sol acabam ficando com seus pescoços avermelhados (do inglês red neck, “pescoço vermelho”). O General Lee traz este conceito estético e se inspira no filme The Dukes of Hazzard, dirigido por Jay Chandrasekhar e baseado na série de TV da década de 70.',
  phone: '(48) 3028-3445',
  email: 'lucianojung@gmail.com',
  facebook: 'https://www.facebook.com/General-Lee-271761482844679/?fref=ts',
  instagram: ''
)

Address.create(
  city_id: City.where(name: 'Florianópolis').first.id,
  addressable_type: 'Establishment',
  addressable_id: Establishment.last.id,
  street: 'Rua Cônego Bernardo',
  number: '101',
  zipcode: '88036-570',
  neighborhood: 'Trindade'
)

e = Establishment.create(
  name: 'Armazem Vieira',
  description: 'Patrimônio histórico, etílico, gastronômico e musical. Balcão com mais de 160 anos de tradição em um ambiente art nouveau com mesas de botequim. Acepipes exclusivos, uma generosa carta de bebidas e coquetéis, música ao vivo, charutos baianos e cubanos e uma cachaça que é engarrafada no local.',
  small_description: 'Patrimônio histórico, etílico, gastronômico e musical.',
  phone: '(48) 3333-8687',
  email: 'armazemvieira@armazemvieira.com.br ',
  facebook: 'https://www.facebook.com/armazemvieira',
  instagram: ''
)

Address.create(
  city_id: City.where(name: 'Florianópolis').first.id,
  addressable_type: 'Establishment',
  addressable_id: Establishment.last.id,
  street: '02',
  number: 'Rua Aldo Alves',
  zipcode: '88045-600',
  neighborhood: 'Saco dos Limões'
)

e = Establishment.create(
  name: 'Guacamole Cocina Mexicana',
  description: 'Uma mistura de cores e sabores intensos dá o tom ao Guacamole Cocina Mexicana. Recriando uma atmosfera descontraída e bastante divertida, o local, sem dúvidas, se transformou em um pedacinho do México em Florianópolis, com decoração especialmente temática e até criação de uma linha de souvenirs. O diferencial do Guacamole é a “noite completa”, que inclui gastronomia de qualidade e muita diversão com os tequileiros e mariachis. O cardápio, inclui clássicos da gastronomia como os burritos, chilaquilles e as famosas enchiladas.',
  small_description: 'Uma mistura de cores e sabores intensos dá o tom ao Guacamole Cocina Mexicana',
  phone: '(48) 3225-0900',
  email: 'contato@guacamolemex.com.br',
  facebook: 'https://www.facebook.com/guacamolefln',
  instagram: ''
)

Address.create(
  city_id: City.where(name: 'Florianópolis').first.id,
  addressable_type: 'Establishment',
  addressable_id: Establishment.last.id,
  street: 'Av. Jorn. Rubens de Arruda Ramos',
  number: '2006',
  zipcode: '88015-700',
  neighborhood: 'Centro'
)

e = Establishment.create(
  name: 'Speedy Food',
  description: 'Delivery de amplo cardápio de hambúrgueres, sanduíches e porções, incluindo suprema bacon, x-frango e fritas.',
  small_description: 'Ultrapasse sua fome com o Speedy Food.',
  phone: '(48) 3371-4100',
  email: 'contato@speedyfood.com.br',
  facebook: 'http://www.facebook.com.br/speedyfoodbr',
  instagram: ''
)

Address.create(
  city_id: City.where(name: 'Florianópolis').first.id,
  addressable_type: 'Establishment',
  addressable_id: Establishment.last.id,
  street: 'Rua Lauro Linhares',
  number: '1747',
  zipcode: '88036-002',
  neighborhood: 'Trindade'
)

e = Establishment.create(
  name: 'Chopp do gus',
  description: 'Boteco aconchegante e estilizado, com temas e bandas de rock nostálgico, petiscos e ambiente de taberna.',
  small_description: 'Boteco aconchegante e estilizado, com temas e bandas de rock nostálgico, petiscos e ambiente de taberna.',
  phone: '(48) 3028-5807',
  email: 'contato@choppdogus.com.br',
  facebook: 'www.facebook.com/choppdogus',
  instagram: ''
)

Address.create(
  city_id: City.where(name: 'Florianópolis').first.id,
  addressable_type: 'Establishment',
  addressable_id: Establishment.last.id,
  street: 'R. João Pio Duarte Silva',
  number: '1650',
  zipcode: '88037-001',
  neighborhood: 'Córrego Grande'
)
