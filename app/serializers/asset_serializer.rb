class AssetSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers

  attributes :id, :url, :thumb, :link, :attachment

  def url
    rails_blob_url(object.attachment) if object.attachment.attached?
  end

  def link
    url
  end

  def thumb
    if object.attachment.attached?
      rails_representation_url(object.attachment.variant(resize: "200x133").processed)
    end
  end

  def attachment
    object.attachment.attachment.blob.signed_id if object.attachment.attached?
  end

end
