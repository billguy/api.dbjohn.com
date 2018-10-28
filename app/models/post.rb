class Post < ApplicationRecord

  include Navigatable

  permalink :title, unique: true

  paginates_per 4

  acts_as_taggable

  validates_presence_of :content

  scope :blogs, ->{ includes(:taggings).where(blog: true ) }
  scope :pages, ->{ includes(:taggings).where(blog: false ) }
  scope :published, ->{ where(published: true ) }

  def to_param
    permalink
  end

end
