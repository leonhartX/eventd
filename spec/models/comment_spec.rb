require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe "validates" do
    let(:comment) { create :comment }
    context "valid" do
      it "is valid" do
        expect(comment).to be_valid
      end
    end

    context "invalid" do
      it "is not valid without user" do
        comment.user_id = nil
        expect(comment).not_to be_valid
      end

      it "is not valid without event" do
        comment.event_id = nil
        expect(comment).not_to be_valid
      end

      it "is not valid without content" do
        comment.content = nil
        expect(comment).not_to be_valid
      end

      it "is not valid with space content" do
        comment.content = ""
        expect(comment).not_to be_valid
      end

      it "is not valid with over 2000 content" do
        comment.content = "a" * 2001
        expect(comment).not_to be_valid
      end
    end
  end
end
