# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

{
  "marvinmarnold@gmail.com" => "marvinsafe2choose",
  "rodrigo@dktinternational.org" => "rodrigosafe2choose"
}.each do |k, v|
  User.create!(email: k, password: v)
end