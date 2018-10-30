class AssetSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers

  attributes :id, :url, :thumb, :link, :attachment

  def url
    if object.attachment.attached?
      Rails.env.production? ? object.attachment.service_url : rails_blob_url(object.attachment)
    end
  end

  def link
    url
  end

  def thumb
    if object.attachment.attached?
      if Rails.env.production?
        object.attachment.variant(resize: "200x133").processed.service_url
      else
        rails_representation_url(object.attachment.variant(resize: "200x133").processed)
      end
    end
  end

  def attachment
    object.attachment.attachment.blob.signed_id if object.attachment.attached?
  end

end
