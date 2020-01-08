require('pry')
require("rspec")
require('spec_helper')

describe '#City' do

  describe('#==') do
    it("is the same city if it has the same attributes as another city") do
      city = City.new({:name => "Portland", :id => nil})
      city2 = City.new({:name => "Portland", :id => nil})
      expect(city).to(eq(city2))
    end
  end

  describe('.all') do
    it("returns an empty array when there are no Cities") do
      expect(City.all).to(eq([]))
    end
  end

  describe('#save') do
  it("saves a city") do
    city = City.new({:name => "Portland", :id => nil})
    city.save()
    city2 = City.new({:name => "Seattle", :id => nil})
    city2.save()
    expect(City.all).to(eq([city, city2]))
  end
end

describe('.find') do
  it("finds an city by id") do
    city = City.new({:name => "Portland", :id => nil})
    city.save()
    city2 = City.new({:name => "Seattle", :id => nil})
    city2.save()
    expect(City.find(city.id)).to(eq(city))
  end
end

describe('#update') do
  it("updates a city by id") do
    city = City.new({:name => "Portland", :id => nil})
    city.save()
    city.update("Seattle")
    expect(city.name).to(eq("Seattle"))
  end
end

describe('#delete') do
  it("deletes an city by id") do
    city = City.new({:name => "Portland", :id => nil})
    city.save()
    city2 = City.new({:name => "Seattle", :id => nil})
    city2.save()
    city.delete()
    expect(City.all).to(eq([city2]))
  end
end

describe('.search') do
  it("Searches for matching cities by name") do
    city1 = City.new({:name => "Portland Oregon", :id => nil})
    city1.save()
    city2 = City.new({:name => "Seattle Washington", :id => nil})
    city2.save()
    city3 = City.new({:name => "Portland Oregon", :id => nil})
    city3.save()
    expect(City.search("Oregon")).to(eq([city1,city3]))
  end
end



end
