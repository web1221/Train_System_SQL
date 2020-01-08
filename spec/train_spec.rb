require 'spec_helper'
require 'rspec'
require 'pry'

describe '#Train' do
  before(:each) do
    @city = City.new({:name => "Portland", :id => nil})
    @city.save()
  end

  describe('#==') do
    it("is the same train if it has the same attributes as another train") do
      train = Train.new({:destination =>"Seattle", :city_id => @city.id, :time => "12:00", :id => nil})
      train2 = Train.new({:destination =>"Seattle", :city_id => @city.id, :time => "12:00", :id => nil})
      expect(train).to(eq(train2))
    end
  end

  describe('.all') do
    it("returns a list of all trains") do
      train = Train.new({:destination =>"Denver", :city_id => @city.id, :time => "12:00", :id => nil})
      train.save()
      train2 = Train.new({:destination =>"Seattle", :city_id => @city.id, :time => "12:00", :id => nil})
      train2.save()
      expect(Train.all).to(eq([train, train2]))
    end
  end

  describe('#save') do
  it("saves a train") do
    train = Train.new({:destination =>"Denver", :city_id => @city.id, :time => "12:00", :id => nil})
    train.save()
    expect(Train.all).to(eq([train]))
  end
end

describe('.find') do
  it("finds a train by id") do
    train = Train.new({:destination =>"Denver", :city_id => @city.id, :time => "12:00", :id => nil})
    train.save()
    train2 = Train.new({:destination =>"Seattle", :city_id => @city.id, :time => "12:00", :id => nil})
    train2.save()
    expect(Train.find(train.id)).to(eq(train))
  end
end

describe('#update') do
  it("updates a train by id") do
    train = Train.new({:destination =>"Denver", :city_id => @city.id, :time => "12:00", :id => nil})
    train.save()
    train.update("Seattle", @city.id)
    expect(train.destination).to(eq("Seattle"))
  end
end

describe('#delete') do
  it("deletes a train by id") do
    train = Train.new({:destination =>"Denver", :city_id => @city.id, :time => "12:00", :id => nil})
    train.save()
    train2 = Train.new({:destination =>"Seattle", :city_id => @city.id, :time => "12:00", :id => nil})
    train2.save()
    train.delete()
    expect(Train.all).to(eq([train2]))
  end
end

describe('.find_by_city') do
  it("finds trains for a city") do
    city2 = City.new({:name => "Seattle", :id => nil})
    city2.save
    train = Train.new({:destination =>"Denver", :city_id => @city.id, :time => "12:00", :id => nil})
    train.save()
    train2 = Train.new({:destination =>"Chicago", :city_id => city2.id, :time => "12:00", :id => nil})
    train2.save()
    expect(Train.find_by_city(city2.id)).to(eq([train2]))
  end
end

describe('#city') do
  it("finds the city a train belongs to") do
    train = Train.new({:destination =>"Denver", :city_id => @city.id, :time => "12:00", :id => nil})
    train.save()
    expect(train.city()).to(eq(@city))
  end
end

describe('#delete') do
it("deletes all trains belonging to a deleted city") do
  city = City.new({:name => "Seattle", :id => nil})
  city.save()
  train = Train.new({:destination =>"Denver", :city_id => city.id, :time => "12:00", :id => nil})
  train.save()
  city.delete()
  expect(Train.find(train.id)).to(eq(nil))
end
end

end
