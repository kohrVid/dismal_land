class Direction < ActiveRecord::Base
  belongs_to :location
  belongs_to :destination, class_name: "Location", foreign_key: :destination_id

  def get_direction_name
    directions = {
      "n" => "north", 
      "s" => "south", 
      "e" => "east",
      "w" => "west",
      "ne" => "north-east",
      "se" => "south-east",
      "nw" => "north-west",
      "sw" => "south-west"
    }
    return directions[self.direction] if directions.include? self.direction
  end

end
