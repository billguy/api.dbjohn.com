class AssetSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers

  attributes :id, :url

  def url
    if object.attachment.attached?
      Rails.env.production? ? object.attachment.service_url : rails_blob_path(object.attachment, only_path: true)
    end
  end

  def attachment
    object.attachment.attachment.blob.signed_id if object.attachment.attached?
  end

end
