require 'rails_helper'

describe "blog_posts", type: :request do

  let!(:published_blog_post){ FactoryBot.create(:post, blog: true, published: true) }
  let!(:unpublished_blog_post){ FactoryBot.create(:post, blog: true, published: false) }

  context 'without current_user' do
    it "index" do
      get "/blog_posts"
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      expect(json[:blog_posts].length).to eq(1)
    end
  end

  context 'with current_user', focus: true do

    let(:current_user) { FactoryBot.create(:user, password: '1234567') }

    before do
      payload = { user_id: current_user.id }
      session = JWTSessions::Session.new(payload: payload)
      @tokens = session.login
      cookies[JWTSessions.access_cookie] = @tokens[:access]
      @access_token = "Bearer #{@tokens[:access]}"
    end

    it "index" do
      get "/blog_posts", headers: { "Authorization" => @access_token }
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:blog_posts].length).to eq(2)
      expect(response.status).to eq(200)
    end
  end

end