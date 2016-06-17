class Location < ActiveRecord::Base
  has_many :directions
  has_many :location_tags
  has_many :tags, through: :location_tags
  has_many :comments


  def get_image
    "/images/" + self.name.downcase.gsub(" ", "_") + ".gif"
  end

end
