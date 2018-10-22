require 'rails_helper'

describe "Users", type: :request do

  let(:user) { FactoryBot.create(:user, password: '1234567') }

  context 'without current_user' do

    it "index" do
      get "/users"
      expect(response.status).to eq(401)
    end

    it "show" do
      get "/users/#{user.id}"
      expect(response.status).to eq(401)
    end

    it "create" do
      post "/users", params: {}
      expect(response.status).to eq(401)
    end

    it "update" do
      put "/users/#{user.id}", params: {}
      expect(response.status).to eq(401)
    end

    it "delete" do
      delete "/users/#{user.id}"
      expect(response.status).to eq(401)
    end

  end

  context 'with current_user' do

    before { allow_any_instance_of(UsersController).to receive(:current_user){ user } }

    it "index" do
      get "/users"
      expect(response.status).to eq(200)
    end

    it "show" do
      get "/users/#{user.id}"
      expect(response.status).to eq(200)
    end

    it "create" do
      post "/users", params: { user: { name: 'test123', email: 'test2@test.com', password: '1234567' } }
      expect(response.status).to eq(201)
    end

    it "update" do
      put "/users/#{user.id}", params: { user: { name: 'test' } }
      expect(response.status).to eq(200)
    end

    it "delete" do
      delete "/users/#{user.id}"
      expect(response.status).to eq(204)
    end

  end

end