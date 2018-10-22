require 'rails_helper'

describe "Signins", type: :request do

  describe "POST /signins" do

    before { FactoryBot.create :user, email: 'test@test.com', password: 'test123' }

    it "can signin an authenticated user" do
      post signins_path, params: { email: 'test@test.com', password: 'test123' }
      expect(response).to have_http_status(200)
    end

    it "does not signin an unauthenticated user" do
      post signins_path, params: { email: 'test@test.com', token: 'wrong' }
      expect(response).to have_http_status(403)
    end

  end
end
