require "spec_helper"
include Lattice

describe Lattice do
  let(:header) { sendgrid_header }

  before { header.stub(:data).and_return({}) }

  describe "#sendgrid_recipients" do
    it "delegates to Lattice::Header#recipients" do
      header.should_receive(:recipients=)
      sendgrid_recipients("aye@example.com", "arr@example.com")
    end
  end

  describe "#sendgrid_substitute" do
    it "delegates to Lattice::Header#substitute" do
      header.should_receive(:substitute)
      sendgrid_substitute(:token)
    end
  end

  describe "#sendgrid_category" do
    it "delegates to Lattice::Header#category" do
      header.should_receive(:category=)
      sendgrid_category("Fire at Will!")
    end
  end

  describe "#x_smtp_api_headers" do
    it "delegates to Lattice::Header#to_json" do
      header.should_receive(:to_json)
      x_smtp_api_headers
    end
  end

  describe "#sendgrid_header" do
    subject { header }
    it { should be_a_kind_of(Lattice::Header) }
  end

end
