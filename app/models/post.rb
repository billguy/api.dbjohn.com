class Post < ApplicationRecord

  include Navigatable

  permalink :title, unique: true

  paginates_per 4

  validates_presence_of :content

  def to_param
    permalink
  end

end
