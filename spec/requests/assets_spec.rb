require 'rails_helper'

describe "Assets", type: :request do

  let(:user) { FactoryBot.create(:user, password: '1234567') }
  let(:asset) { FactoryBot.create(:asset) }

  context 'without current_user' do

    it "index" do
      get "/assets"
      expect(response.status).to eq(401)
    end

    it "show" do
      get "/assets/#{asset.id}"
      expect(response.status).to eq(401)
    end

    it "create" do
      post "/assets", params: {}
      expect(response.status).to eq(401)
    end

    it "delete" do
      delete "/assets/#{asset.id}"
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
      get "/assets"
      expect(response.status).to eq(200)
    end

    it "show" do
      get "/assets/#{asset.id}"
      expect(response.status).to eq(200)
    end

    it "create" do
      post "/assets", params: { asset: { attatchment: File.open(Rails.root.join('spec', 'support', 'assets', 'rails.jpg')) } }, headers: { "Authorization" => @access_token }
      expect(response.status).to eq(201)
    end

    it "delete" do
      delete "/assets/#{asset.id}", headers: { "Authorization" => @access_token }
      expect(response.status).to eq(204)
    end

  end

end