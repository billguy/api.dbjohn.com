class Post < ApplicationRecord

  include Navigatable
  include SharedScopes

  permalink :title, unique: true

  paginates_per 4

  acts_as_taggable

  validates_presence_of :title, :content

  scope :blogs, ->{ with_tags.where(blog: true ).order(id: :desc) }
  scope :pages, ->{ with_tags.where(blog: false ).order(id: :desc) }

  def to_param
    permalink
  end

end
