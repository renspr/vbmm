class Member < ActiveRecord::Base

  # validations
  validates_presence_of   :name
  validates_uniqueness_of :name

  # attributes whitelist
  attr_accessible :location_string
  attr_accessible :name, :location_string, :vb_id, as: :admin

  # geocoding
  geocoded_by :location_string # can also be an IP address
  after_validation :geocode    # auto-fetch coordinates

  # Downcase and strip name
  before_validation do
    if name.present?
      name.downcase!
      name.strip!
    end
  end

end