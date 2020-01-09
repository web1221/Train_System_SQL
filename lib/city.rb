class City
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each()do |city|
    name = city.fetch("name")
    id = city.fetch("id").to_i
    cities.push(City.new({:name => name, :id => id}))
  end
  cities
end

def save
  result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
  @id = result.first().fetch("id").to_i
end

def ==(city_to_compare)
  if city_to_compare != nil
    self.name() == city_to_compare.name()
  else
    false
  end
end

def self.find(id)
  city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
  if city
    name = city.fetch("name")
    id = city.fetch("id").to_i
    City.new({:name => name, :id => id})
  else
    nil
  end
end

def update(name)
  @name = name
  DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{id};")
end

def delete()
  DB.exec("DELETE FROM cities WHERE id = #{@id};")
  DB.exec("DELETE FROM trains WHERE city_id = #{@id};")
end

def self.search(x)
  cities = self.all
  cities.select {|e| /#{x}/i.match? e.name}
end

def self.clear
  DB.exec("DELETE FROM cities *;")
end

def trains
  Train.find_by_city(self.id)
end

end
