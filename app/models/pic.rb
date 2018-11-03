class Pic < ApplicationRecord

  include Navigatable
  include SharedScopes

  paginates_per 24

  acts_as_taggable

  permalink :title, unique: true

  has_one_attached :photo

  # :xlarge => "1440×1080>",
  # :large => "720x540>",
  # :medium => "230x230#",
  # :thumb => "100x100#",

  validate :correct_mime_type?
  validates_presence_of :title, :caption

  before_save :update_location, if: :coords_changed?
  before_save :analyze_photo
  before_destroy :destroy_photo

  reverse_geocoded_by :latitude, :longitude do |pic, geo|
    pic.location  = [geo.first.city, " #{geo.first.state}"].join(",")
  end

  alias_attribute :latitude, :lat
  alias_attribute :longitude, :lng

  scope :with_photos, -> { includes(photo_attachment: [:blob]).order(id: :desc) }
  scope :with_photos_and_tags, -> { with_photos.with_tags }

  def to_param
    permalink
  end

  def lat
    photo.metadata[:latitude] if photo.attached?
  end

  def lng
    photo.metadata[:longitude] if photo.attached?
  end

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

    def analyze_photo
      photo.analyze if photo.attached?
    end

end
