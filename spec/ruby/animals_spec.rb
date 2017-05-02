require "spec_helper"

RSpec.describe Ruby::Animals do
  it "has a version number" do
    expect(Ruby::Animals::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
