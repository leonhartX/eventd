require 'rails_helper'

RSpec.describe Property, :type => :model do
  describe "validates" do
    let(:property) { create :property }
    context "valid" do
      it "is valid" do
        expect(property).to be_valid
      end
    end

    context "invalid" do
      it "is not valid without tag" do
      	property.tag_id = nil
      	expect(property).not_to be_valid  
      end

      it "is not valid without event" do
      	property.event_id = nil
      	expect(property).not_to be_valid 
      end
    end
  end
end
