RSpec.describe Docuseal::Submitter do
  describe "#list" do
    before do
      stub_docuseal(:get, "submitters")
    end

    let(:data) { Docuseal::Submitter.list }

    it "returns the right response" do
      expect(data.first.to_json).to eq(docuseal_fixture("get_submitters")["data"].first.to_json)
    end
  end

  describe "#find" do
    before do
      stub_docuseal(:get, "submitters/1")
    end

    let(:data) { Docuseal::Submitter.find(1) }

    it "returns the right response" do
      expect(data.to_json).to eq(docuseal_fixture("get_submitters/1").to_json)
    end
  end

  describe "#create" do
    it "is not allowed" do
      expect { Docuseal::Submitter.create(some_data: "true") }.to raise_error(Docuseal::Error, "Method not allowed")
    end
  end

  describe "#archive" do
    it "is not allowed" do
      expect { Docuseal::Submitter.archive(1) }.to raise_error(Docuseal::Error, "Method not allowed")
    end
  end

  describe "#update" do
    before do
      stub_docuseal(:put, "submitters/1", body: {some_data: 1})
    end

    let(:data) { Docuseal::Submitter.update(1, some_data: 1) }

    it "returns the right response" do
      expect(data.to_json).to eq(docuseal_fixture("put_submitters/1").to_json)
    end
  end
end
