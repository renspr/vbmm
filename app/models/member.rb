class Member < ActiveRecord::Base

  # validations
  validates_presence_of   :name, :location_string, :longitude, :latitude
  validates_uniqueness_of :name

  # attributes whitelist
  attr_accessible :name, :location_string

  # geocoding
  geocoded_by :location_string # can also be an IP address
  before_validation :geocode    # auto-fetch coordinates

end