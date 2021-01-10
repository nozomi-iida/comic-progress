require 'rails_helper'

RSpec.describe Comic, type: :model do
  it "should valid with name, volume" do
    comic = build(:comic)
    expect(comic).to be_valid
  end

  it "should invalid without name" do
    comic = build(:comic, name: nil)
    expect(comic.valid?).to be_falsey
  end

  it "should invalid without volume" do
    comic = build(:comic, volume: nil)
    expect(comic.valid?).to be_falsey
  end
end
