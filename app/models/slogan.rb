class Slogan < ApplicationRecord

  validates :title, presence: true, uniqueness: true

end
