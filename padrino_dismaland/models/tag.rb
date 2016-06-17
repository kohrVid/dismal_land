class Tag < ActiveRecord::Base
  has_many :location_tags
  has_many :locations, through: :location_tags
  validates :name, presence: true, uniqueness: true

end
