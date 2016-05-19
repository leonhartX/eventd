require "rails_helper"

RSpec.describe '/comment', type: :feature do
  subject { page }

  let(:event){ create :event }

  describe "not logged-in" do
    before do
      visit event_path event
    end

    it { should_not have_css "#comment_content" }
    it { should_not have_button "Comment" }
  end

  describe 'logged-in' do
    let(:user){ create :user , provider: "twitter" }
    before do
      login! user
      visit event_path event
    end

    it { should have_css "#comment_content" }
    it { should have_button "Comment" }

    context "post comment" do
      before do
        fill_in 'comment_content', with: 'Test Comment'
        click_button "Comment"
      end
      it { current_path.should eq event_path(event) }
      it { should have_link(user.name, user_path(user)) }
      it { should have_content "Test Comment" }
      it { should have_link 'delete', comment_path(Comment.last) }

      context "delete comment" do
        before do
          click_link 'delete'
          click_link 'Log out Twitter'
          visit event_path event
        end
        it { current_path.should eq event_path(event) }
        it { should_not have_link(user.name, user_path(user)) }
        it { should_not have_content "Test Comment" }
      end
    end
  end
end
