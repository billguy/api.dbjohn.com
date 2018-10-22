class Post < ApplicationRecord

  include Navigatable

  paginates_per 4

  validates_presence_of :content

end
