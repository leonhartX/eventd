require "rails_helper"

RSpec.describe '/share', type: :feature do
  subject { page }

  let(:event){ create :event }

  describe 'twitter' do
    let(:user){ create :user , provider: "twitter" }
    before do
      login! user
      visit event_path event
    end

    it { should have_content "Join #{event.title}: #{event_url(event)}" }
    it { should have_button "Share to twitter" }

    context "send twitter" do
      before do
        login! user
        user.instance_variable_set(:@client, StubClient.new(user))
        click_button "Share to twitter"
      end
      it { should have_content "Message shared." }
      it "should redirect back" do
        current_path.should eq event_path(event)
      end
    end
  end

  describe '/share/facebook' do
    let(:user){ create :user , provider: "facebook" }
    before do
      login! user
      visit event_path event
    end

    it { should have_content "Join #{event.title}: #{event_url(event)}" }
    it { should have_button "Share to facebook" }

    context "send facebook" do
      before do
        login! user
        user.instance_variable_set(:@client, StubClient.new(user))
        click_button "Share to facebook"
      end
      it { should have_content "Message shared." }
      it "should redirect back" do
        current_path.should eq event_path(event)
      end
    end
  end

  describe 'can not share github' do
    let(:user){ create :user , provider: "github", sharable: false }
    before do
      login! user
      visit event_path event
    end

    it { should_not have_content "Join #{event.title}: #{event_url(event)}" }
    it { should_not have_button "Share to github" }
  end
end
