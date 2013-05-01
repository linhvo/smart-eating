require 'fatsecret'
namespace :db do
  desc "get date from fatsecret"
  task :fatsecret_data => :environment do
    FatSecret.init(ENV['FATSECRET_KEY'], ENV['FATSECRET_SECRET'])
    a=  FatSecret.search_food('Beans & Legumes')
    puts a["foods"]["food"][0]["food_description"].split("|")
    puts a["foods"]["food"].length
  end
end