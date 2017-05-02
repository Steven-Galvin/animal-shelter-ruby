require 'sinatra'
if development?
  require 'sinatra/reloader'
  also_reload('**/*.rb')
end

get('/') do
  @customers = RubyAnimals::Customer.findAll
  erb(:index)
end

post('/animals/new') do
  animal = params.fetch('animal')
  owner_id = params['owner_id']
  RubyAnimals::Animal.create(animal, owner_id)
  erb(:success)
end

post('/customers/new') do
  customer = params.fetch('customer')
  RubyAnimals::Customer.create(customer)
  erb(:success)
end

get('/customers') do
  @customers = RubyAnimals::Customer.findAll
  erb(:customers)
end

get('/animals') do
  @animals = RubyAnimals::Animal.findAll
  erb(:customers)
end

get('/animals/:name') do
  @animal = RubyAnimals::Animal.find(:name)
  erb(:customer)
end

get('/customers/:name') do
  @customer = RubyAnimals::Customer.find(:name)
  @pets = RubyAnimals::Animals.findBy('owner_id', @customer["id"])
  erb(:customer)
end
