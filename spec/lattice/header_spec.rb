require "spec_helper"

describe Lattice::Header do
  subject { Lattice::Header.new }

  describe "#category" do
    let(:data) { { "category" => "Fire at Will!" } }

    before { subject.stub(:data).and_return(data) }

    it "returns the X-SMTPAPI header category" do
      subject.category.should == "Fire at Will!"
    end
  end

  describe "#category=" do
    before do
      subject.stub(:data).and_return({})
      subject.category = "Fire at Will!"
    end

    it "sets the data category key" do
      subject.data["category"].should == "Fire at Will!"
    end
  end

  describe "#recipients=" do
    before do
      subject.stub(:data).and_return({})
      subject.recipients = "aye@example.com"
    end

    it "sets the data to key" do
      subject.data["to"].should == ["aye@example.com"]
    end
  end

  describe "#substitution_marker=" do
    subject { Lattice::Header.new }

    context "-" do
      before { subject.substitution_marker = "-" }
      its(:substitution_marker) { should == "-" }
    end

    context "<" do
      before { subject.substitution_marker = "<" }
      its(:substitution_marker) { should == "<" }
    end
  end

  describe "#substitute" do
    it "is an instance of SubstitutionProxy" do
      subject.substitute(:aye).should be_a_kind_of(Lattice::SubstitutionProxy)
    end
  end

  describe "#substitutions" do
    let(:data) { { "sub" => { "-token-" => "123" } } }

    before { subject.stub(:data).and_return(data) }

    it "returns the X-SMTPAPI header substitutions" do
      subject.substitutions.should == { "-token-" => "123" }
    end
  end

  describe "#to_json" do
    let(:data) { { "to" => "aye@example.com" } }

    before { subject.stub(:data).and_return(data) }

    it "returns a JSON representation of the data hash" do
      subject.to_json.should == "{\"to\": \"aye@example.com\"}"
    end
  end

  describe "#to_s" do
    let(:data) { { "to" => "aye@example.com" } }

    before { subject.stub(:data).and_return(data) }

    it "returns the X-SMTPAPI string header representation of the data hash" do
      subject.to_s.should == "X-SMTPAPI: {\"to\": \"aye@example.com\"}\\n"
    end
  end

  describe "#valid_ordinal?" do

    context "a number in range" do
      it { should be_true }
    end

    context "a number out of range" do
      it { should be_true }
    end
  end
end
