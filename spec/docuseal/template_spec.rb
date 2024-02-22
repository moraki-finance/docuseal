RSpec.describe Docuseal::Template do
  describe "#list" do
    before do
      stub_docuseal(:get, "templates")
    end

    let(:data) { Docuseal::Template.list }

    it "returns the right response" do
      expect(data.first.to_json).to eq(docuseal_fixture("get_templates")["data"].first.to_json)
    end
  end

  describe "#find" do
    before do
      stub_docuseal(:get, "templates/1")
    end

    let(:data) { Docuseal::Template.find(1) }

    it "returns the right response" do
      expect(data.to_json).to eq(docuseal_fixture("get_templates/1").to_json)
    end
  end

  describe "#create" do
    describe "from docx" do
      before do
        stub_docuseal(:post, "templates/docx", body: {some_data: "true"})
      end

      let(:data) { Docuseal::Template.create(from: :docx, some_data: "true") }

      it "returns the right response" do
        expect(data.to_json).to eq(docuseal_fixture("post_templates/docx").to_json)
      end
    end

    describe "from pdf" do
      before do
        stub_docuseal(:post, "templates/pdf", body: {some_data: "true"})
      end

      let(:data) { Docuseal::Template.create(from: :pdf, some_data: "true") }

      it "returns the right response" do
        expect(data.to_json).to eq(docuseal_fixture("post_templates/pdf").to_json)
      end
    end

    describe "from html" do
      before do
        stub_docuseal(:post, "templates/html", body: {some_data: "true"})
      end

      let(:data) { Docuseal::Template.create(from: :html, some_data: "true") }

      it "returns the right response" do
        expect(data.to_json).to eq(docuseal_fixture("post_templates/html").to_json)
      end
    end
  end

  describe "#archive" do
    before do
      stub_docuseal(:delete, "templates/1")
    end

    let(:data) { Docuseal::Template.archive(1) }

    it "returns the right response" do
      expect(data.to_json).to eq(docuseal_fixture("delete_templates/1").to_json)
    end
  end

  describe "#update" do
    before do
      stub_docuseal(:put, "templates/1", body: {some_data: 1})
    end

    let(:data) { Docuseal::Template.update(1, some_data: 1) }

    it "returns the right response" do
      expect(data.to_json).to eq(docuseal_fixture("put_templates/1").to_json)
    end
  end

  describe "#update_documents" do
    before do
      stub_docuseal(:put, "templates/1/documents", body: {documents: [{name: "Demo Template"}]})
    end

    let(:data) { Docuseal::Template.update_documents(1, documents: [{name: "Demo Template"}]) }

    it "returns the right response" do
      expect(data.to_json).to eq(docuseal_fixture("put_templates/1/documents").to_json)
    end
  end

  describe "#clone" do
    before do
      stub_docuseal(:post, "templates/1/clone", body: {name: "Demo Template"})
    end

    let(:data) { Docuseal::Template.clone(1, name: "Demo Template") }

    it "returns the right response" do
      expect(data.to_json).to eq(docuseal_fixture("post_templates/1/clone").to_json)
    end
  end
end
