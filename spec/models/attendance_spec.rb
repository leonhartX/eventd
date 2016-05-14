require 'rails_helper'

RSpec.describe Attendance, :type => :model do
  describe "validates" do
    let(:attendance) { create :attendance }
    context "valid" do
      it "is valid" do
        expect(attendance).to be_valid
      end
    end

    context "invalid" do
      it "is not valid without user" do
      	attendance.user_id = nil
      	expect(attendance).not_to be_valid  
      end

      it "is not valid whitout event" do
      	attendance.event_id = nil
      	expect(attendance).not_to be_valid 
      end

      it "is not valid without state" do
      	attendance.state = nil
      	expect(attendance).not_to be_valid 
      end

      it "is not valid when state is not supported" do
      	attendance.state = "unknown"
      	expect(attendance).not_to be_valid 
      end
    end
  end
end
