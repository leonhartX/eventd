require "rails_helper"

RSpec.describe '/search', type: :feature do
  subject { page }

  describe 'search box' do
    let!(:events) { create_list :event, 10 }
    let!(:tag) { create :tag }
    let!(:property) { create :property }
    before do
      visit root_path
    end

    it { should have_css "input[id='query']" }

    context "search without query" do
      before do
        fill_in 'query', with: ''
        click_button 'Search'
      end

      it { current_path.should eq searchs_path }
      it { should have_content "Found 11 results"}
      it { find('#query').value.should eq ""}
    end

    context "search title without key" do
      before do
        fill_in 'query', with: 'event'
        click_button 'Search'
      end

      it { current_path.should eq searchs_path }
      it { should have_content "Found 11 results"}
      it { find('#query').value.should eq "event"}
    end

    context "search title with key" do
      before do
        events.sample.update_attribute :title, "sampletitle"
        fill_in 'query', with: 'title:sampletitle'
        click_button 'Search'
      end

      it { current_path.should eq searchs_path }
      it { should have_content "Found 1 result"}
      it { find('#query').value.should eq "title:sampletitle"}
    end

    context "search location" do
      before do
        events.first.update_attribute :location, "ginza"
        events.last.update_attribute :location, "ginza"
        fill_in 'query', with: 'location:ginza'
        click_button 'Search'
      end

      it { current_path.should eq searchs_path }
      it { should have_content "Found 2 results"}
      it { find('#query').value.should eq "location:ginza"}
    end

    context "search description" do
      before do
        events.sample.update_attribute :description, "rspectest"
        fill_in 'query', with: 'description:rspectest'
        click_button 'Search'
      end

      it { current_path.should eq searchs_path }
      it { should have_content "Found 1 result"}
      it { find('#query').value.should eq "description:rspectest"}
    end

    context "search owner" do
      before do
        events.sample.update_attribute :owner, "rjb"
        fill_in 'query', with: 'owner:rjb'
        click_button 'Search'
      end

      it { current_path.should eq searchs_path }
      it { should have_content "Found 1 result"}
      it { find('#query').value.should eq "owner:rjb"}
    end

    context "search hold_at" do
      before do
        events.sample.update_attribute :hold_at, 1.day.ago
        fill_in 'query', with: 'hold_at:5-11'
        click_button 'Search'
      end

      it { current_path.should eq searchs_path }
      it { should have_content "Found 10 result"}
      it { find('#query').value.should eq "hold_at:5-11"}
    end

    context "search tag" do
      before do
        fill_in 'query', with: "tag:#{property.tag.name}"
        click_button 'Search'
      end

      it { current_path.should eq searchs_path }
      it { should have_content "Found 1 result"}
      it { find('#query').value.should eq "tag:#{property.tag.name}"}
    end

    context "no match" do
      before do
        fill_in 'query', with: 'title:rails'
        click_button 'Search'
      end

      it { current_path.should eq searchs_path }
      it { should have_content "Found 0 result"}
      it { find('#query').value.should eq "title:rails"}
    end

    context "search with multiple keys" do
      before do
        property.event.update_attribute :description, "rspectest"
        property.event.update_attribute :owner, "cusweb"
        fill_in 'query', with: "owner:cusweb description:rspectest tag:#{property.tag.name}"
        click_button 'Search'
      end

      it { current_path.should eq searchs_path }
      it { should have_content "Found 1 result"}
      it { find('#query').value.should eq "owner:cusweb description:rspectest tag:#{property.tag.name}"}
    end
  end

  describe "tag link" do
    let!(:property) { create :property }
    let(:event) { property.event }

    before do
      visit event_path event
    end

    it { should have_link(property.tag.name, searchs_path) }
    context "click link" do
      before do
        click_link property.tag.name
      end

      it { current_path.should eq searchs_path }
      it { should have_content "Found 1 result"}
      it { find('#query').value.should eq "tag:#{property.tag.name}"}
    end
  end
end
