require "spec_helper"

describe Lattice::Header do

  describe "#category" do
    let(:data) { { "category" => "Fire at Will!" } }
    subject { Lattice::Header.new }

    before { subject.stub(:data).and_return(data) }

    it "returns the X-SMTPAPI header category" do
      subject.category.should == "Fire at Will!"
    end
  end

  describe "#category=" do
    subject { Lattice::Header.new }

    before do
      subject.stub(:data).and_return({})
      subject.category = "Fire at Will!"
    end

    it "sets the data category key" do
      subject.data["category"].should == "Fire at Will!"
    end
  end

  describe "#recipients=" do
    subject { Lattice::Header.new }

    before do
      subject.stub(:data).and_return({})
      subject.recipients = "aye@example.com"
    end

    it "sets the data to key" do
      subject.data["to"].should == ["aye@example.com"]
    end
  end

  describe "#substitute" do
    subject { Lattice::Header.new }

    it "is an instance of SubstitutionProxy" do
      subject.substitute("<aye>").should be_a_kind_of(Lattice::SubstitutionProxy)
    end
  end

  describe "#substitutions" do
    let(:data) { { "sub" => { "<token>" => "123" } } }
    subject { Lattice::Header.new }

    before { subject.stub(:data).and_return(data) }

    it "returns the X-SMTPAPI header substitutions" do
      subject.substitutions.should == { "<token>" => "123" }
    end
  end

  describe "#to_json" do
    let(:data) { { "to" => "aye@example.com" } }
    subject { Lattice::Header.new }

    before { subject.stub(:data).and_return(data) }

    it "returns a JSON representation of the data hash" do
      subject.to_json.should == "{\"to\": \"aye@example.com\"}"
    end
  end

  describe "#to_s" do
    let(:data) { { "to" => "aye@example.com" } }
    subject { Lattice::Header.new }

    before { subject.stub(:data).and_return(data) }

    it "returns the X-SMTPAPI string header representation of the data hash" do
      subject.to_s.should == "X-SMTPAPI: {\"to\": \"aye@example.com\"}\\n"
    end
  end
end
