class PostSerializer < ActiveModel::Serializer
  attributes :id, :published, :title, :content, :javascript, :created_at, :updated_at
end
