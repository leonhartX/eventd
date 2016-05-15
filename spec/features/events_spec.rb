require "rails_helper"

RSpec.describe '/events', type: :feature do
  subject { page }

  describe '/events' do
    let!(:events) { create_list :event, 3 }
    before do
      visit events_path
    end

    it { should have_content events.sample.title }
    it { should have_link('Show', event_path(events.sample)) }

    context 'click show link' do
      before do
        find_link('Show', href: event_path(events.first)).click
      end

      it 'should work show link' do
        current_path.should eq event_path(events.first)
      end
    end
  end

  describe '/events/:id' do
    let(:event) { create :event }
    before do
      visit event_path event
    end

    it { should have_content event.title }
    it { should have_content event.hold_at }
    it { should have_content event.capacity }
    it { should have_content event.location }
    it { should have_content event.owner }
    it { should have_content event.description }
    it { should have_css '#attendees' } #出席者リストのID
    it { should have_css '#absentees' } #欠席者リストのID

    context 'not logged-in' do
      before do
        visit event_path event
      end

      it { should_not have_link('Edit', edit_event_path(event)) }
      it { should_not have_link('Destroy', event_path(event)) }
      it { should_not have_button('Absent') }
      it { should_not have_button('Attend') }

      describe 'attendee' do
        let!(:attended) { create_list :attendance, 2, event: event }
        let!(:absented) { create_list :attendance, 2, event: event, state: 'absented' }

        before do
          visit event_path event
        end

        it { should have_content attended.first.user.name }
        it { should have_content attended.last.user.name }
        it { should have_content absented.first.user.name }
        it { should have_content absented.last.user.name }
      end
    end

    context 'logged-in' do
      before do
        login! event.user
        visit event_path event
      end

      it { should have_link('Edit', edit_event_path(event)) }
      it { should have_link('Destroy', event_path(event)) }

      context 'click edit link' do
        before do
          find_link('Edit', href: edit_event_path(event)).click
        end

        it { current_path.should eq edit_event_path(event) }
      end

      context 'click destroy link' do
        before do
          find_link('Destroy', href: event_path(event)).click
        end

        it { current_path.should eq events_path }
        it 'should not have deleted event' do
          should_not have_content event.description
        end
      end

      describe 'attendee' do
        context 'not attend' do
          it { should have_button('Attend') }

          context 'click Attend' do
            before do
              click_button('Attend')
            end

            it { current_path.should eq event_path(event) }
            it { find('#attendees').should have_content event.user.name }
            it { find('#absentees').should_not have_content event.user.name }

            context 'click absent' do
              before do
                click_button('Absent')
              end

              it { current_path.should eq event_path(event) }
              it { find('#attendees').should_not have_content event.user.name }
              it { find('#absentees').should have_content event.user.name }

              context 'click Attend again' do
                before do
                  click_button('Attend')
                end

                it { current_path.should eq event_path(event) }
                it { find('#attendees').should have_content event.user.name }
                it { find('#absentees').should_not have_content event.user.name }
              end
            end
          end
        end

        context 'already attended' do
          let!(:attended) { create :attendance, event: event, user: event.user }

          before do
            visit event_path event
          end

          it { should have_button('Absent') }
        end
      end
    end
  end

  describe '/events/new' do
    context 'not logged-in' do
      before do
        visit new_event_path
      end

      it 'should redirect events_path' do
        current_path.should eq events_path
      end
      it { should have_content 'Please login first.' }
    end

    context 'logged-in' do
      let(:user) { create :user }
      let(:title) { 'test title' }
      before do
        login! user
        visit new_event_path
        fill_in 'event_title', with: title
        fill_in 'event_capacity', with: 10
        fill_in 'event_location', with: 'test location'
        fill_in 'event_hold_at', with: '2026-05-12 17:21:14'
        fill_in 'event_owner', with: 'test owner'
        fill_in 'event_description', with: 'test description'
        click_button 'Create Event'
      end

      it { current_path.should eq event_path(Event.last) }
      it { should have_content title }
    end
  end

  describe '/events/edit' do
    let(:event) { create :event }

    context 'not logged-in' do
      before do
        visit edit_event_path event
      end

      it 'should redirect events_path' do
        current_path.should eq events_path
      end
      it { should have_content 'Please login first.' }
    end

    context 'logged-in' do
      let(:title) { 'test title' }
      before do
        login! event.user
        visit edit_event_path event
        fill_in 'event_title', with: title
        click_button 'Update Event'
      end

      it { current_path.should eq event_path(event) }
      it { should have_content title }
    end
  end
end
