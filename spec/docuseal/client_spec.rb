RSpec.describe Docuseal::Client do
  let(:client) { Docuseal::Client.instance }
  let(:resource) { "submissions" }

  describe ".initialize" do
    it "uses the default configuration" do
      expect(client).to have_attributes(
        api_key: "fake_api_key",
        base_uri: "https://api.docuseal.co/",
        request_timeout: 120,
        global_headers: {}
      )
    end
  end

  describe ".conn" do
    it "sets up the faraday connection" do
      expect(client.send(:conn).options).to have_attributes(
        timeout: 120
      )
    end
  end

  describe "get" do
    let(:response) { client.get(resource) }

    before do
      stub_docuseal(:get, resource)
    end

    it "sends the api key in the headers" do
      expect(response.env.request_headers["X-Auth-Token"]).to eq "fake_api_key"
    end

    it "returns the response" do
      expect(response.body).to eq docuseal_fixture("get_#{resource}")
    end

    it "allows to pass in extra headers" do
      response = client.get(resource, headers: {"X-Extra-Header" => "value"})
      expect(response.env.request_headers["X-Extra-Header"]).to eq "value"
    end

    it "allows to pass in query parameters" do
      stub_docuseal(:get, resource, query: {"status" => "completed"})
      response = client.get(resource, status: "completed")
      expect(response.body).to eq docuseal_fixture("get_#{resource}")
    end
  end

  describe "post" do
    let(:response) { client.post(resource) }

    before do
      stub_docuseal(:post, resource)
    end

    it "sends the api key in the headers" do
      expect(response.env.request_headers["X-Auth-Token"]).to eq "fake_api_key"
    end

    it "returns the response" do
      expect(response.body).to eq docuseal_fixture("post_#{resource}")
    end

    it "allows to pass in extra headers" do
      stub_docuseal(:post, resource, headers: {"X-Extra-Header" => "value"})
      response = client.post(resource, headers: {"X-Extra-Header" => "value"})
      expect(response.env.request_headers["X-Extra-Header"]).to eq "value"
    end

    it "allows to pass in query parameters" do
      stub_docuseal(:post, resource, query: {"status" => "completed"})
      response = client.post(resource, status: "completed")
      expect(response.body).to eq docuseal_fixture("post_#{resource}")
    end

    it "allows to pass in data" do
      stub_docuseal(:post, resource, body: {"status" => "completed"})
      response = client.post(resource, data: {status: "completed"})
      expect(response.body).to eq docuseal_fixture("post_#{resource}")
    end
  end

  describe "put" do
    let(:resource) { "submitters/1" }
    let(:response) { client.put(resource) }

    before do
      stub_docuseal(:put, resource)
    end

    it "sends the api key in the headers" do
      expect(response.env.request_headers["X-Auth-Token"]).to eq "fake_api_key"
    end

    it "returns the response" do
      expect(response.body).to eq docuseal_fixture("put_#{resource}")
    end

    it "allows to pass in extra headers" do
      stub_docuseal(:put, resource, headers: {"X-Extra-Header" => "value"})
      response = client.put(resource, headers: {"X-Extra-Header" => "value"})
      expect(response.env.request_headers["X-Extra-Header"]).to eq "value"
    end

    it "allows to pass in query parameters" do
      stub_docuseal(:put, resource, query: {"status" => "completed"})
      response = client.put(resource, status: "completed")
      expect(response.body).to eq docuseal_fixture("put_#{resource}")
    end

    it "allows to pass in data" do
      stub_docuseal(:put, resource, body: {"status" => "completed"})
      response = client.put(resource, data: {status: "completed"})
      expect(response.body).to eq docuseal_fixture("put_#{resource}")
    end
  end

  describe "delete" do
    let(:resource) { "submissions/1" }
    let(:response) { client.delete(resource) }

    before do
      stub_docuseal(:delete, resource)
    end

    it "sends the api key in the headers" do
      expect(response.env.request_headers["X-Auth-Token"]).to eq "fake_api_key"
    end

    it "returns the response" do
      expect(response.body).to eq docuseal_fixture("delete_#{resource}")
    end

    it "allows to pass in extra headers" do
      response = client.delete(resource, headers: {"X-Extra-Header" => "value"})
      expect(response.env.request_headers["X-Extra-Header"]).to eq "value"
    end

    it "allows to pass in query parameters" do
      stub_docuseal(:delete, resource, query: {"status" => "completed"})
      response = client.delete(resource, status: "completed")
      expect(response.body).to eq docuseal_fixture("delete_#{resource}")
    end
  end
end
