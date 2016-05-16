require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AttendancesHelper. For example:
#
# describe AttendancesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AttendancesHelper, :type => :helper do
  let(:attendance) { create :attendance }

  describe "auth_type" do
    it "is none when no attendance" do
      expect(action_type nil).to eq "none"
    end

    it "is create" do
      attendance.state = nil
      expect(action_type attendance).to eq "create"
    end

    it "is update" do
      expect(action_type attendance).to eq "update"
    end
  end
end
