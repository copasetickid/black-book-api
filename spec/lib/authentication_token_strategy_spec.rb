require 'rails_helper'

RSpec.describe AuthenticationTokenStrategy, type: :model do
  let!(:user) { create(:user) }

  let(:env) {
    { "HTTP_X_USER_EMAIL" => user.email,
      "HTTP_X_AUTH_TOKEN" => user.authentication_token.body } }

  let(:subject) { described_class.new(nil) }

  describe "#valid?" do

    context "with valid credentials" do
      before { allow(subject).to receive(:env).and_return(env) }

      it { is_expected.to be_valid }
    end

    context "with invalid credentials" do
      before { allow(subject).to receive(:env).and_return({}) }

      it { is_expected.not_to be_valid }
    end

  end

  describe "#authenticate!" do

    context "with valid credentials" do
      before { allow(subject).to receive(:env).and_return(env) }

      it "returns success" do
        expect(User).to receive(:find_by)
          .with(email: user.email)
          .and_return(user)
        expect(TokenIssuer).to receive_message_chain(:build, :find_token)
          .with(user, user.authentication_token.body)
          .and_return(user.authentication_token)
        expect(subject).to receive(:success!).with(user)
        subject.authenticate!
      end

      it "touches the token" do
        expect(subject).to receive(:touch_token)
          .with(authentication_token)
        subject.authenticate!
      end
    end

    context "with invalid user" do
      before { allow(subject).to receive(:env)
        .and_return({ "HTTP_X_USER_EMAIL" => "invalid@email",
                      "HTTP_X_AUTH_TOKEN" => "invalid-token" }) }

      it "fails" do
        expect(User).to receive(:find_by)
          .with(email: "invalid@email")
          .and_return(nil)
        expect(TokenIssuer).not_to receive(:build)
        expect(subject).not_to receive(:success!)
        expect(subject).to receive(:fail!)
        subject.authenticate!
      end
    end

    context "with invalid token" do
      before { allow(subject).to receive(:env)
        .and_return({ "HTTP_X_USER_EMAIL" => user.email,
                      "HTTP_X_AUTH_TOKEN" => "invalid-token" }) }

      it "fails" do
        expect(User).to receive(:find_by)
          .with(email: user.email)
          .and_return(user)
        expect(TokenIssuer).to receive_message_chain(:build, :find_token)
          .with(user, "invalid-token")
          .and_return(nil)
        expect(subject).not_to receive(:success!)
        expect(subject).to receive(:fail!)
        subject.authenticate!
      end
    end
  end

end