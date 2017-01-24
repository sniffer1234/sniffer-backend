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
u = User.new(email: 'rafaelmotta021@gmail.com', password: 'galera07', name: 'Rafael Motta', role: 'admin')
u.skip_confirmation!
u.save

100.times do
  u = User.new(
    email: Faker::Internet.email,
    password: 'snifferapp',
    name: Faker::Name.name,
    role: 'default'
  )
  u.skip_confirmation!
  u.save
end

50.times do
  e = Establishment.create(
    name: Faker::Company.name,
    description: Faker::Lorem.paragraph(6),
    small_description: Faker::Lorem.paragraph(1),
    phone: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.email,
    facebook: 'https://www.facebook.com/pachafloripa/?fref=ts',
    instagram: 'https://www.instagram.com/pachafloripaoficial'
  )

  Address.create(
    city_id: City.where(name: 'Florianópolis').first.id,
    addressable_type: 'Establishment',
    street: 'Servidão José Cardoso de Oliveira',
    number: 's/n',
    zipcode: '88053-306',
    neighborhood: 'Jurerê Internacional'
  )
end
