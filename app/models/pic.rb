class Pic < ApplicationRecord

  include Navigatable
  include Exifable

  has_one_attached :photo

  validate :correct_mime_type?
  validates_presence_of :caption

  before_save :update_location, if: :coords_changed?
  before_destroy :destroy_photo

  reverse_geocoded_by :latitude, :longitude do |pic, geo|
    pic.location  = [geo.first.city, " #{geo.first.state}"].join(",")
  end

  alias_attribute :latitude, :lat
  alias_attribute :longitude, :lng

  private

    def coords_changed?
      will_save_change_to_lat? || will_save_change_to_lng?
    end

    def correct_mime_type?
      if photo.try(:atttached?) && !photo.image?
        photo.purge
        errors.add(:photo, 'Must be an image file')
      end
    end

    def destroy_photo
      photo.purge
    end

    def update_location
      reverse_geocode if Rails.env.production?
    end
end
