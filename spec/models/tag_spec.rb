require 'rails_helper'

RSpec.describe Tag, :type => :model do
  describe "validates" do
    let(:tag) { create :tag }
    context "valid" do
      it "is valid" do
        expect(tag).to be_valid
      end
    end

    context "invalid" do
      it "is not valid without name" do
      	tag.name = nil
      	expect(tag).not_to be_valid
      end
    end
  end
end
