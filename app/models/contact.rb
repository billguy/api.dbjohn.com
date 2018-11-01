class Contact

  include ActiveModel::Model

  attr_accessor :id, :name, :email, :message, :response

  validates :name, presence: true
  validates :email, presence: true, email: true
  validates :message, presence: true

end