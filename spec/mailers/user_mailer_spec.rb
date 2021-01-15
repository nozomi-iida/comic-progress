require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:user) { build(:user, activation_token: User.new_token) }
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Account activation")
      expect(mail.to).to eq([user.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match user.first_name
      expect(mail.body.encoded).to match user.activation_token
      expect(mail.body.encoded).to match CGI.escape(user.email)
    end
  end

  describe "password_reset", :skip => true do
    let(:mail) { UserMailer.password_reset }

    it "renders the headers" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
