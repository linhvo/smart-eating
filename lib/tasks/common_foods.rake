namespace :db do
  desc "Get commons foods"
  task :common_foods => :environment do
    urls = []
    response = RestClient.get "http://www.fatsecret.com/calories-nutrition/"
    doc = Nokogiri::HTML(response)
    doc.css('a.prominent').each do |a|
      url = a['href']
      puts a.text
    end
    #doc.xpath('//a').each do |a|
    #  puts a.to_s if a.class == "prominent"
    #  end
  end
end