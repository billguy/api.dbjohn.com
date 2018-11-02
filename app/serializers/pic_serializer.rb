class PicSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers

  attributes :id, :published, :title, :permalink, :caption, :location, :lat, :lng, :src, :tags, :tag_list, :created_at, :updated_at
  attribute :prev_permalink, if: :show_action?
  attribute :prev_thumb_url, if: :show_action?
  attribute :next_permalink, if: :show_action?
  attribute :next_thumb_url, if: :show_action?

  # I don't like the idea of having to give travis my RAILS_MASTER_KEY just to test Active storage
  attribute :photo, if: :photo_attached?
  attribute :src, if: :photo_attached?
  attribute :msrc, if: :photo_attached?
  attribute :w, if: :photo_attached?
  attribute :h, if: :photo_attached?
  attribute :date_taken, if: :photo_attached?
  attribute :make, if: :photo_attached?
  attribute :model, if: :photo_attached?
  attribute :f_number, if: :photo_attached?
  attribute :exposure_time, if: :photo_attached?
  attribute :iso_speed_ratings, if: :photo_attached?

  def current_user
    instance_options[:current_user]
  end

  def show_action?
    instance_options[:action] == :show
  end

  def photo_attached?
    object.photo.attached?
  end

  def watermark_options
    { gravity: 'SouthEast', draw: 'image Over 0,0 0,0 "' + Rails.root.join('public/dbjohn_watermark.png').to_s + '"' }
  end

  def photo_url(photo, options={})
    return unless photo_attached?
    options = watermark_options.merge(options.except(:watermark)) if options[:watermark]
    if Rails.env.production?
      photo.variant(combine_options: options).processed.service_url
    else
      rails_representation_url(photo.variant(combine_options: options).processed)
    end
  end

  def prev_pic
    object.prev(!current_user)
  end

  def next_pic
    object.next(!current_user)
  end

  def prev_thumb_url
    photo_url(prev_pic.photo, {thumbnail: '230x230^', gravity: 'center', extent: '230x230'})
  end

  def next_thumb_url
    photo_url(next_pic.photo, {thumbnail: '230x230^', gravity: 'center', extent: '230x230'})
  end

  def src
    photo_url(object.photo, { resize: "720x540", watermark: true })
  end

  def photo
    object.photo.attachment.blob.signed_id
  end

  def msrc
    photo_url(object.photo, {thumbnail: '230x230^', gravity: 'center', extent: '230x230'})
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
