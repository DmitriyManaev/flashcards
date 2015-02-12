require "rails_helper"
describe Pack do
  let(:pack) { FactoryGirl.create(:pack, title: "Новая колода") }

  it "created with right title" do
    expect(pack.title).to eq("Новая колода")
  end
end
