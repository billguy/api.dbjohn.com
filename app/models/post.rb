class Post < ApplicationRecord

  include Navigatable

  permalink :title, unique: true

  paginates_per 4

  validates_presence_of :content

  scope :blogs, ->{ where(blog: true ) }
  scope :pages, ->{ where(blog: false ) }
  scope :published, ->{ where(published: true ) }

  def to_param
    permalink
  end

end
