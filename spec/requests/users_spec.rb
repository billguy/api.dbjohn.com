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

    let(:current_user) { FactoryBot.create(:user, password: '1234567') }

    before do
      payload = { user_id: current_user.id }
      session = JWTSessions::Session.new(payload: payload)
      @tokens = session.login
      cookies[JWTSessions.access_cookie] = @tokens[:access]
      @access_token = "Bearer #{@tokens[:access]}"
    end

    it "index" do
      get "/users"
      expect(response.status).to eq(200)
    end

    it "show" do
      get "/users/#{user.id}"
      expect(response.status).to eq(200)
    end

    it "create" do
      post "/users", params: { user: { name: 'test123', email: 'test2@test.com', password: '1234567' } }, headers: { "Authorization" => @access_token }
      expect(response.status).to eq(201)
    end

    it "update" do
      put "/users/#{user.id}", params: { user: { name: 'test' } }, headers: { "Authorization" => @access_token }
      expect(response.status).to eq(200)
    end

    it "delete" do
      delete "/users/#{user.id}", headers: { "Authorization" => @access_token }
      expect(response.status).to eq(204)
    end

  end

end