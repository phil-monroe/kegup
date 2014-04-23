
class Import < Thor

  desc "distributors [PATH]", "load distributors from scraped json"
  def distributors(path="data/distributors.json")
    require "./config/environment"

    DistributorImporter.from_file(path).import
  end
end
