class PicSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers

  attributes :id, :published, :title, :permalink, :caption, :location, :lat, :lng, :photo_url, :created_at, :updated_at

  def photo_url
    if object.photo.attached?
      Rails.env.production? ? object.photo.service_url : rails_blob_path(object.photo, only_path: true)
    end
  end

  def photo
    object.photo.attachment.blob.signed_id if object.photo.attached?
  end

end
