class Train
  attr_accessor :destination, :id, :time, :time2, :time3, :city_id

  def initialize(attributes)
    @destination = attributes.fetch(:destination)
    @id = attributes.fetch(:id)
    @time = attributes.fetch(:time, nil)
    @time2 = attributes.fetch(:time2, nil)
    @time3 = attributes.fetch(:time3, nil)
    @city_id = attributes.fetch(:city_id)
  end


  def ==(train_to_compare)
    if train_to_compare != nil
      (self.destination() == train_to_compare.destination()) && (self.city_id() == train_to_compare.city_id())
    else
      false
    end
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      destination = train.fetch("destination")
      city_id = train.fetch("city_id").to_i
      id = train.fetch("id").to_i
      time = train.fetch("time")
      time2 = train.fetch("time2")
      time3 = train.fetch("time3")
      trains.push(Train.new({:destination => destination, :city_id => city_id, :id => id, :time => time, :time2 => time2, :time3 => time3}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (destination, city_id, time, time2, time3) VALUES ('#{@destination}', '#{@city_id}', '#{@time}', '#{@time2}', '#{@time3}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    if train
      destination = train.fetch("destination")
      city_id = train.fetch("city_id").to_i
      id = train.fetch("id").to_i
      time = train.fetch("time")
      time2 = train.fetch('time2')
      time3 = train.fetch('time3')
      Train.new({:destination => destination, :city_id => city_id, :id => id, :time => time, :time2 => time2, :time3 => time3})
    else
      nil
    end
  end

  def update(destination, city_id)
    @destination = destination
    @city_id = city_id
    DB.exec("UPDATE trains SET destination = '#{@destination}', city_id = #{@city_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end

  def self.find_by_city(city_id)
    trains = []
    returned_trains = DB.exec("SELECT * FROM trains WHERE city_id = #{city_id};")
    returned_trains.each() do |train|
      destination = train.fetch("destination")
      id = train.fetch("id").to_i
      time = train.fetch('time')
      time2 = train.fetch('time2')
      time3 = train.fetch('time3')
      trains.push(Train.new({:destination => destination, :city_id => city_id, :id => id, :time => time, :time2 => time2, :time3 => time3}))
    end
    trains
  end

  def self.clear
    DB.exec("DELETE FROM trains *;")
  end

  def city
  City.find(@city_id)
end


end
