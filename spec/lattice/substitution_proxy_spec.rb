require "spec_helper"

describe Lattice::SubstitutionProxy do
  let(:header) { Lattice::Header.new }
  let(:data) { {} }
  let(:substitutions) { data["sub"] = { "-token-" => [1, 2, 3] } }
  let(:proxy) { Lattice::SubstitutionProxy.new("-token-", header) }

  before do
    header.stub(:data).and_return(data)
    header.stub(:substitutions).and_return(substitutions)
  end

  describe "#with" do
    subject { header.substitute(:token).with(1, 2, 3) }

    it "returns itself" do
      subject.with([1, 2, 3]).should == subject
    end
  end

  describe "#and" do
    subject { proxy.and(:id) }
    it { should be_a_kind_of(Lattice::SubstitutionProxy) }
  end

  describe "#original" do
    before { header.substitution_marker = "-" }

    it "surrounds the token with the specified character" do
      proxy.original.should == "-token-"      
    end
  end
end
