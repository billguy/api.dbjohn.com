class PostSerializer < ActiveModel::Serializer
  attributes :id, :published, :blog, :title, :permalink, :content, :tags, :tag_list, :created_at, :updated_at
end
