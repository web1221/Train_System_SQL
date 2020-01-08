class Train
  attr_accessor

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @time = attributes.fetch(:time)
    @id_city = attributes.fetch(:id_city)
  end
end
