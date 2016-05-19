require 'rails_helper'

RSpec.describe Event, :type => :model do
  describe "validates" do
    let(:event) { create :event }
    context "valid" do
      it "is valid" do
        expect(event).to be_valid
      end
    end

    context "invalid" do
      context "presence" do
        it "is not valid without title" do
          event.title = nil
          expect(event).not_to be_valid
        end

        it "is not valid without hold_at" do
          event.hold_at = nil
          expect(event).not_to be_valid
        end

        it "is not valid without capacity" do
          event.capacity = nil
          expect(event).not_to be_valid
        end

        it "is not valid without location" do
          event.location = nil
          expect(event).not_to be_valid
        end

        it "is not valid without owner" do
          event.owner = nil
          expect(event).not_to be_valid
        end
      end

      context "format" do
        it "is not valid when capacity is not number" do
          event.capacity = "ten"
          expect(event).not_to be_valid
        end

        it "is not valid when capacity is less than 1" do
          event.capacity = 0
          expect(event).not_to be_valid
        end

        it "is not valid when hold_at is not datetime" do
          event.hold_at = "today"
          expect(event).not_to be_valid
        end

        it "is not valid when hold_at is before now" do
          event.hold_at = 1.day.ago
          expect(event).not_to be_valid
        end

        it "is not valid when title is over 255" do
          event.title = "a" * 256
          expect(event).not_to be_valid
        end

        it "is not valid when location is over 255" do
          event.location = "a" * 256
          expect(event).not_to be_valid
        end

        it "is not valid when owner is over 255" do
          event.owner = "a" * 256
          expect(event).not_to be_valid
        end

        it "is not valid when description is over 10000" do
          event.description = "a" * 10001
          expect(event).not_to be_valid
        end
      end
    end
  end

  describe "capacity check" do
    let(:user) { create :user }
    let(:otheruser) { create :user }
    let(:event) { create :event, capacity: 1 }

    it "is not over when less than capacity" do
      expect(event.over_capacity?).to be_falsey
    end

    it "is over when equal to capacity" do
      user.attend event
      expect(event.over_capacity?).to be_truthy
    end

    it "is over when greater than capacity" do
      user.attend event
      otheruser.attend event
      expect(event.over_capacity?).to be_truthy
    end
  end

    describe "available check" do
    let(:user) { create :user }
    let(:event) { create :event, capacity: 1 }

    it "is available when hold_at is future" do
      expect(event.available?).to be_truthy
    end

    it "is not available when hold_at is past" do
      event.update_attribute :hold_at, 1.day.ago
      expect(event.available?).to be_falsey
    end
  end

  describe "update attendees" do
    let(:user) { create :user }
    let(:otheruser) { create :user }
    let(:event) { create :event, capacity: 1 }

    before do
      user.attend event
      otheruser.attend event
    end

    it "will do nothing when over capacity" do
      event.update_participant
      expect(event.attendees.count).to eq 1
      expect(event.waiters.count).to eq 1
    end

    it "will do nothing when no waiters" do
      event.attendances.update_all state: "absented"
      expect(event.absented.count).to eq 2
      event.update_participant
      expect(event.absented.count).to eq 2
    end

    it "will update waiters when available" do
    	event.attendances.update_all state: "waiting"
    	expect(event.attended.count).to eq 0
    	event.update_participant
    	expect(event.waiting.count).to eq 1
    	expect(event.attended.count).to eq 1
    end
  end
end
