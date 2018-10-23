class PostSerializer < ActiveModel::Serializer
  attributes :id, :published, :title, :permalink, :content, :javascript, :created_at, :updated_at
end
