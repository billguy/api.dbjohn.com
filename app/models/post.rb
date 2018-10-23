class Post < ApplicationRecord

  include Navigatable

  permalink :title

  paginates_per 4

  validates_presence_of :content

end
