require "rails_helper"

RSpec.describe '/search', type: :feature do
  subject { page }

  describe 'search box' do
    before do
      visit root_path
    end

    it { should have_css "input[id='query']" }
  end
end
