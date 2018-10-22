shared_examples_for "crud" do |controller, factory|

  let!(:resource) { factory.call }

  it "index" do
    get "/#{controller}"
    expect(response.status).to eq(200)
  end

  it "show" do
    get "/#{controller}/#{resource.id}"
    expect(response.status).to eq(200)
  end

  it "create" do
    post "/#{controller}", params: {}
    expect(response.status).to eq(401)
  end

  it "update" do
    put "/#{controller}/#{resource.id}", params: {}
    expect(response.status).to eq(401)
  end

  it "delete" do
    delete "/#{controller}/#{resource.id}"
    expect(response.status).to eq(401)
  end

end