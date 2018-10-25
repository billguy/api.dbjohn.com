require 'rails_helper'

describe "posts", type: :request do

  factory = ->{ FactoryBot.create(:post, blog: false) }
  it_should_behave_like "crud", "posts", factory

end