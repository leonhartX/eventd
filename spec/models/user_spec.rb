require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "validates" do
    context "valid" do
      it "is valid with provider and uid" do
        user = User.new
        user.provider = "twitter"
        user.uid = "123456789"
        expect(user).to be_valid
      end
    end

    context "invalid" do
      let(:user){ create :user }

      it "is not valid without provider" do
        user.provider = nil
        expect(user).not_to be_valid
      end

      it "is not valid without uid" do
        user.uid = nil
        expect(user).not_to be_valid
      end
    end
  end

  describe "attend event" do
    let(:user) { create :user }
    let(:otheruser) { create :user }
    let(:event) { create :event, capacity: 1 }

    context "available" do
      it "is able to attend event" do
        count = user.attendances.count
        user.attend event
        expect(user.attendances.count).to eq count+1
      end
    end

    context "over capacity" do
      it "will be waiting when over capacity" do
        user.attend event
        otheruser.attend event
        state = otheruser.attendances.find_by(event_id: event.id).state
        expect(state).to eq "waiting"
      end
    end
  end

  describe "update event" do
    let(:user) { create :user }
    let(:seconduser) { create :user }
    let(:thirduser) { create :user }
    let(:event) { create :event, capacity: 1 }

    before do
      user.attend event
    end

    context "available" do
      it "is able to update state" do
        state = user.attendances.find_by(event_id: event.id).state
        expect(state).to eq "attended"

        user.update_attend event, "absented"
        state = user.attendances.find_by(event_id: event.id).state
        expect(state).to eq "absented"
      end
    end

    context "over capacity" do
      before do
        seconduser.attend event
      end

      it "will be waiting when over capacity" do
        state = seconduser.attendances.find_by(event_id: event.id).state
        expect(state).to eq "waiting"
      end

      it "will be attended from waiting when someone absented" do
        user.update_attend event, "absented"
        state = seconduser.attendances.find_by(event_id: event.id).state
        expect(state).to eq "attended"
      end

      it "will not be attended from waiting if is not the first" do
        sleep 1
        thirduser.attend event
        thirduser_state = thirduser.attendances.find_by(event_id: event.id).state
        expect(thirduser_state).to eq "waiting"

        user.update_attend event, "absented"
        seconduser_state = seconduser.attendances.find_by(event_id: event.id).state
        thirduser_state = thirduser.attendances.find_by(event_id: event.id).state
        expect(seconduser_state).to eq "attended"
        expect(thirduser_state).to eq "waiting"
      end
    end
  end

  describe "share" do
    context "provider client" do
      let(:user) { create :user, provider: :stub }

      it "has client " do
        user.share_event "join this event"
        expect(user.instance_variable_get(:@client)).not_to be_nil          
      end
    end
  end
end
