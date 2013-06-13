require 'fatsecret'
namespace :db do
  desc "Get commons foods"
  task :common_foods => :environment do
    FatSecret.init(ENV['FATSECRET_KEY'], ENV['FATSECRET_SECRET'])
    @food_names = []
    BasicFood.delete_all
    FoodGroup.all.each do |food|
      get_fatsecret_food(food.name)
    end

    while @food_names.length > 0
      @food_names.each do |name|
        get_fatsecret_food(name)
      end

      sleep(1.minute)
    end
  end
end

def get_fatsecret_food(food)
  items = FatSecret.search_food(food)
  if items["foods"]

    item_list = items["foods"]["food"]
    item_list.each do |item|
      food_id = item["food_id"]
      if BasicFood.find_by_fatsecret_id(food_id)
        puts "#{food_id} already has"
        next
      else
        #"food_description"=>"Per 623g - Calories: 1552kcal | Fat: 96.40g | Carbs: 112.10g | Protein: 58.45g"
        food_description = item["food_description"].gsub("\n", "").split("-")[1].split("|")
        per_unit = item["food_description"].gsub("\n", "").split("-")[0]
        get_unit = item["food_description"].split("-")[0].split(" ")
        if get_unit.length == 2
          unit = get_unit[1].scan(/[a-z]/).join("")
        elsif get_unit.length == 3
          unit = get_unit[2]
        elsif get_unit.length == 4
          unit = "#{get_unit[get_unit.length - 2]}_#{get_unit[get_unit.length - 1]}"
        else
          unit = get_unit[get_unit.length - 1]
        end

        if per_unit.include? "/"
          amount = per_unit.split("/")[0].scan(/\d/).join("").to_f / per_unit.split("/")[1].scan(/\d./).join("").to_i
        else
          amount = per_unit.scan(/\d./).join("").to_f
        end
        fatsecret_id = item["food_id"]
        food_name = item["food_name"]
        food_url = item["food_url"]
        brand_name = item["brand_name"]
        puts "#{food_id}: #{food}: #{amount}#{unit}"
        save_item = BasicFood.create(name: food_name,
                                     fatsecret_id: fatsecret_id,
                                     fatsecret_url: food_url,
                                     brand_name: brand_name,
                                     amount: amount,
                                     unit: unit)
        food_description.each do |d|
          puts d
          if d.split(':').length > 1
            quantity= d.split(':')[1].scan(/\d./).join("").to_f
            if d.include? "Calories"
              puts " Calories  : #{quantity} "
              save_item.calories = quantity
            elsif d.include? "Fat"
              puts " Fat  : #{quantity} "
              save_item.fat = quantity
            elsif d.include? "Carbs"
              puts " Carbs  : #{quantity} "
              save_item.carb = quantity
            elsif d.include? "Protein"
              puts " Protein  : #{quantity} "
              save_item.protein = quantity
            else
              put "#{d} not defined"
            end
            save_item.save!
          else
            next
          end
        end
      end
    end
    if @food_names.include?(food)
      @food_names.delete(food)
    end
  else
    @food_names.push(food) unless @food_names.include?(food)
    puts "#{food}: #{items}"
  end
end



