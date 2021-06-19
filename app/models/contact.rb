class Contact

  include ActiveModel::Model

  attr_accessor :id, :name, :email, :message, :response

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A(.+)@(.+)\z/, message: "Email invalid"  }
  validates :message, presence: true

end