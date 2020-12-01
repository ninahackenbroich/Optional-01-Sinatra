class Recipe
  attr_reader :name, :description, :prep_time, :rating
  attr_accessor :done

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done]
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
