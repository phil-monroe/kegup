require 'nokogiri'
require 'json'

require 'pry'

class Scrape < Thor

  ROOT_URL = "http://www.micromatic.com/"
  INDEX_URL = "#{ROOT_URL}beer-wholesale-distributor-cid-5042.html"

  desc "distributors", "Scrape distributors from Micromatic"
  def distributors(output='./distributors.json')
    distros = {}

    root_page = Nokogiri::HTML(open(INDEX_URL))
    links = root_page.css("#ctl01_dgData td a")

    distros = links.map do |link|
      url  = link['href'].strip
      name = link.text[/(.*)\s{2}/].strip if link.text[/(.*)\s{2}/]

      puts "Parsing #{name}"

      inner_page = Nokogiri::HTML(open(ROOT_URL + url))

      web_url = inner_page.css("#hlLink").text.strip if inner_page.css("#hlLink")
      address = inner_page.css("#lblAddress1").text.strip if inner_page.css("#lblAddress1").text
      city    = inner_page.css("#lblCity").text.strip if inner_page.css("#lblCity").text
      state   = inner_page.css("#lblState").text.strip if inner_page.css("#lblState").text
      zip     = inner_page.css("#lblZip").text.strip if inner_page.css("#lblZip").text
      phone   = inner_page.css("#lblPhone").text[/\d{3}-\d{3}-\d{4}/].strip if inner_page.css("#lblPhone").text[/\d{3}-\d{3}-\d{4}/]

      breweries = inner_page.css("#lblBreweries").text.split(',').map{|b|b.strip} if inner_page.css("#lblBreweries").text
      breweries_brands = inner_page.css("#dlBrands tr td").map{|b| b.text.strip} if inner_page.css("#dlBrands tr td")

      puts "Completed parsing #{name}"

      {
        name: name,
        web_url: web_url,
        address: address,
        city: city,
        state: state,
        zip: zip,
        phone: phone,
        breweries: breweries,
        breweries_brands: breweries_brands
      }
    end

    # Write it all out
    File.open(output, 'w') { |file|
      file.write distros.to_json
    }

  end
end