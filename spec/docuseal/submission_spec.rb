RSpec.describe Docuseal::Submission do
  describe "#list" do
    before do
      stub_docuseal(:get, "submissions")
    end

    let(:data) { Docuseal::Submission.list }

    it "returns the right response" do
      expect(data.first.to_json).to eq(docuseal_fixture("get_submissions")["data"].first.to_json)
    end
  end

  describe "#find" do
    before do
      stub_docuseal(:get, "submissions/1")
    end

    let(:data) { Docuseal::Submission.find(1) }

    it "returns the right response" do
      expect(data.to_json).to eq(docuseal_fixture("get_submissions/1").to_json)
    end
  end

  describe "#create" do
    before do
      stub_docuseal(:post, "submissions", body: {some_data: "true"})
    end

    let(:data) { Docuseal::Submission.create(some_data: "true") }

    it "returns the right response" do
      expect(data.first.to_json).to eq(docuseal_fixture("post_submissions").first.to_json)
    end

    it "from emails" do
      stub_docuseal(:post, "submissions/emails", body: {template_id: 10001, emails: "hi@docuseal.co, example@docuseal.co"})
      data = Docuseal::Submission.create(from: :emails, template_id: 10001, emails: "hi@docuseal.co, example@docuseal.co")
      expect(data.first.to_json).to eq(docuseal_fixture("post_submissions/emails").first.to_json)
    end
  end

  describe "#archive" do
    before do
      stub_docuseal(:delete, "submissions/1")
    end

    let(:data) { Docuseal::Submission.archive(1) }

    it "returns the right response" do
      expect(data.to_json).to eq(docuseal_fixture("delete_submissions/1").to_json)
    end
  end

  describe "#update" do
    it "is not allowed" do
      expect { Docuseal::Submission.update(1, some_data: "true") }.to raise_error(Docuseal::Error, "Method not allowed")
    end
  end
end
