
namespace :db do
  desc "get date from fatsecret"
  task :fatsecret_food_groups => :environment do

    response = RestClient.get "http://www.fatsecret.com/calories-nutrition/"
    doc = Nokogiri::HTML(response)
    doc.css('table a.prominent').each do |a|
      next if a['href'].match "/member"
      food_url = "http://www.fatsecret.com#{a['href']}"
      food_response = RestClient.get food_url
      page = Nokogiri::HTML(food_response)
      page.css('div.food_links a').each do |food_link|
        link_array = food_link['href'].split("/")
        food = link_array[link_array.length - 1]
        if food.include? "(" and food.include? ")"
          food = food.gsub("(", "").gsub(")", "")
          puts food
          FoodGroup.create!(name: food) unless FoodGroup.find_by_name(food)
        end
      end
    end
  end
end