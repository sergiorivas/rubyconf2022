# Please fill in the method definition below:

def Organizer(collection)
  Organizer.run(collection)
end

class Organizer
  def Organizer::run(collection)
    @my_organized_collection = []
    collection.each do |item|
      @my_organized_collection << item if worth_keeping?(item)
    end
    @my_organized_collection
  end

  def Organizer.worth_keeping?(item)
    item.is_a?(String) &&
      item.length > 5 &&
      item != 'tomatoes'
  end
end

# Modify the solution above. Emojis are free.
# Code below will check correctness.
example_collection = [
  'apples',
  33,
  nil,
  'hat',
  'tomatoes',
  'toothbrush',
  'laptop'
]
raise unless Organizer(example_collection) == %w[apples toothbrush laptop]

puts 'It works!'
