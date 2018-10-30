class PicSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers

  attributes :id, :published, :title, :permalink, :caption, :location, :lat, :lng, :src, :tags, :tag_list, :photo, :src, :msrc, :w, :h, :created_at, :updated_at

  def src
    if object.photo.attached?
      Rails.env.production? ? object.photo.service_url : rails_blob_url(object.photo)
    end
  end

  def photo
    object.photo.attachment.blob.signed_id if object.photo.attached?
  end

  def msrc
    if object.photo.attached?
      if Rails.env.production?
        object.photo.variant(resize: "200x133").processed.service_url
      else
        rails_representation_url(object.photo.variant(resize: "200x133").processed)
      end
    end
  end

  def w
    object.photo.metadata[:width] if object.photo.attached?
  end

  def h
    object.photo.metadata[:height] if object.photo.attached?
  end

end
