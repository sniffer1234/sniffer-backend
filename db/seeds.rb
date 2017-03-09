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
u = User.new(
  name: 'Sniffer Admin',
  email: 'contato@snifferapp.com',
  password: 'sniffer1234',
  password_confirmation: 'sniffer1234',
  role: 'admin'
)
u.save
