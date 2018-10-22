require 'rails_helper'

describe "pics", type: :request do

  factory = ->{ FactoryBot.create(:pic) }
  it_should_behave_like "crud", "pics", factory

end