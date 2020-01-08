require('sinatra')
require('sinatra/reloader')
require('./lib/city')
require('./lib/train')
require('pry')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'train_system'})

get('/') do
  @cities = City.all
  erb(:cities)
end

get("/cities") do
  if params["search"]
    @cities = City.search(params[:search])
  else
    @cities = City.all
  end
  erb(:cities)
end

post('/cities') do
  name = params[:city_name]
  city = City.new({:name => name, :id => nil})
  city.save()
  @cities = City.all()
  erb(:cities)
end

get("/cities/new") do
  erb(:new_city)
end

get('/cities/:id') do
  @city = City.find(params[:id].to_i())
  if @city == nil
    erb(:go_back)
  else
  erb(:city)
end
end

get('/cities/:id/edit') do
  @city = City.find(params[:id].to_i())
  erb(:edit_city)
end

patch('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.update(params[:name])
  @cities = City.all
  erb(:cities)
end

delete('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.delete()
  @cities = City.all
  erb(:cities)
end
