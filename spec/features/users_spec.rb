require "rails_helper"

RSpec.describe '/users', type: :feature do
  subject { page }

  describe "/users" do
    let!(:users) { create_list :user, 20 }
    before do
      visit users_path
    end

    it { should have_content users.first.name }
    it { should have_link(users.first.name, user_path(users.first)) }
    it { should have_css("img[alt='#{users.first.name}']") }
    it { should_not have_content users.last.name }
    it { should_not have_link(users.last.name, user_path(users.last)) }
    it { should_not have_css("img[alt='#{users.last.name}']") }

    context 'paginate' do
      it { should have_link('← Previous'), "#" }
      it { should have_link('1'), "#" }
      it { should have_link('2'), "#{users_path}?page=2" }
      it { should have_link('Next →'), "#{users_path}?page=2" }

      context "next page" do
        before do
          click_link 'Next →'
        end
        it { should have_link('← Previous'), "#{users_path}?page=1" }
        it { should have_link('1'), "#{users_path}?page=1" }
        it { should have_link('2'), "#" }
        it { should have_link('Next →'), "#" }
        it { should have_content users.last.name }
        it { should have_link(users.last.name, user_path(users.last)) }
        it { should have_css("img[alt='#{users.last.name}']") }
        it { should_not have_content users.first.name }
        it { should_not have_link(users.first.name, user_path(users.first)) }
        it { should_not have_css("img[alt='#{users.first.name}']") }
      end
    end

    describe "/user" do
      let(:user){ create :user }
      let(:event) { create :event }
      describe '/user/:id' do
        before do
          visit user_path user
        end
        it { should have_content user.name }
        it { should have_content user.nickname }
        it { should have_content user.description }
        it { should have_selector("img[src$='#{user.image}']") }
      end

      context "involved event" do
        before do
          login! user
          visit event_path event
          click_button('Attend')
          visit user_path user
        end
        it { should have_css '#attended' }
        it { should have_css '#waiting' }
        it { should have_css '#absented' }
        it { should have_content event.title }
        it { should have_link('Show', event_path(event)) }

        context "absent involved event" do
          before do
            visit event_path event
            click_button('Absent')
            visit user_path user
          end
          it { should have_content event.title }
          it { should have_link('Show', event_path(event)) }
        end
      end
    end
  end
end
