require 'json_struct'

class DistributorImporter
  DistributorData = JSONStruct.new(:name, :web_url, :address, :city, :state, :zip, :phone, :breweries, :breweries_brands)

  attr_accessor :data

  class << self
    def from_file(path)
      File.open(path) do |file|
        new file
      end
    end
  end

  def initialize(json)
    self.data = DistributorData.from_json(json)
  end


  def import
    ::Distributor.transaction do
      data.map do |data|
        distributor = import_distributor(data)
        import_beers(distributor, data.breweries_brands)
      end
    end

    true
  end

  def inspect
    "DistributorImporter< num_distributors: #{data.size} >"
  end

  private

  def import_distributor data
    ::Distributor.find_or_initialize_by(name: data.name).tap do |dist|
      dist.phone = data.phone
      dist.address = data.address
      dist.city = data.city
      dist.state = data.state
      dist.zip = data.zip
      dist.save!
    end
  end

  def import_beers distributor, beer_list
    beer_list.map(&:strip).select{|n| n.size > 0 }.each do |beer_name|
      beer = Beer.find_or_initialize_by(name: beer_name).tap do |beer|
        beer.style ||= Beer::UNKNOWN_STYLE
        beer.save!
      end
      distributor.beers << beer unless distributor.beers.include?(beer)
    end
  end

end
