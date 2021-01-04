require "rails_helper"

RSpec.describe User, type: :model do
  it "should valid with first_name, last_name, email" do
    user = build(:user)
    expect(user).to be_valid
  end
  it "should invalid without first_name" do
    user = build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end
  it "should invalid duplicate email" do
    user1 = create(:user, email: "test@test.com")
    user2 = build(:user, email: "test@test.com")

    expect(user2.valid?).to be_falsey
  end
  it "should invalid wrong email" do
    user = build(:user, email: "test.com")
    expect(user.valid?).to be_falsey
  end
end
