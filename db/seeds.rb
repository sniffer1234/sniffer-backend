# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


u = User.new(email: 'rafaelmotta021@gmail.com', password: 'galera07', name: 'Rafael Motta').save
u = User.new(email: 'marcosdemetrio@gmail.com', password: 'galera07', name: 'Marcos Demetrio').save
