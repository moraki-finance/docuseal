RSpec.describe Docuseal::Model do
  it "parses array of strings" do
    model = described_class.new({
      prop: ["1", "2", "3"]
    })
    expect(model.prop).to eq ["1", "2", "3"]
  end
end
