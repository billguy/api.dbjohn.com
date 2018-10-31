class PicSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers

  attributes :id, :published, :title, :permalink, :caption, :location, :lat, :lng, :src, :tags, :tag_list, :photo, :src, :msrc, :w, :h, :date_taken, :make, :model, :f_number, :exposure_time, :iso_speed_ratings, :created_at, :updated_at
  attribute :prev_permalink, if: :show_action?
  attribute :prev_thumb_url, if: :show_action?
  attribute :next_permalink, if: :show_action?
  attribute :next_thumb_url, if: :show_action?

  def current_user
    instance_options[:current_user]
  end

  def show_action?
    instance_options[:action] == :show
  end

  def thumb_url(pic)
    if Rails.env.production?
      pic.photo.variant(resize: "200x133").processed.service_url
    else
      rails_representation_url(pic.photo.variant(resize: "200x133").processed)
    end
  end

  def prev_pic
    object.prev(!current_user).first
  end

  def next_pic
    object.next(!current_user).first
  end

  def prev_thumb_url
    thumb_url(prev_pic)
  end

  def next_thumb_url
    thumb_url(next_pic)
  end

  def src
    Rails.env.production? ? object.photo.service_url : rails_blob_url(object.photo)
  end

  def photo
    object.photo.attachment.blob.signed_id
  end

  def msrc
    if Rails.env.production?
      object.photo.variant(resize: "200x133").processed.service_url
    else
      rails_representation_url(object.photo.variant(resize: "200x133").processed)
    end
  end

  def w
    object.photo.metadata[:width]
  end

  def h
    object.photo.metadata[:height]
  end

  def date_taken
    object.photo.metadata[:date_taken]
  end

  def make
    object.photo.metadata[:make]
  end

  def model
    object.photo.metadata[:model]
  end

  def f_number
    object.photo.metadata[:f_number]
  end

  def exposure_time
    object.photo.metadata[:exposure_time]
  end

  def iso_speed_ratings
    object.photo.metadata[:iso_speed_ratings]
  end

end
