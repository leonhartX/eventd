require "rails_helper"

RSpec.describe '/auth', type: :feature do
  subject { page }

  describe '/auth/twitter' do
    let(:user){ create :user }

    context 'success' do
      before do
        OmniAuth.config.mock_auth[:twitter] =
        OmniAuth::AuthHash.new({
                                 provider: 'twitter',
                                 uid: user.uid,
                                 info: {
                                   name: user.name,
                                   nickname: user.nickname,
                                   image: user.image,
                                   description: user.description
                                 },
                                 credentials: {
                                   token: user.token,
                                   secret: user.secret
                                 }
        })
        visit user_path id: user.id
        click_link 'Log in with Twitter'
      end

      it { current_path.should eq events_path }
      it { should have_content "login as #{user.name}" }
      it { should_not have_content 'login failure' }
    end

    context 'failure' do
      before do
        OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
        visit user_path id: user.id
        click_link 'Log in with Twitter'
      end

      it { current_path.should eq events_path }
      it { should have_content 'login failure' }
    end
  end

  describe '/auth/facebook' do
    let(:user){ create :user }

    context 'success' do
      before do
        OmniAuth.config.mock_auth[:facebook] =
        OmniAuth::AuthHash.new({
                                 provider: 'facebook',
                                 uid: user.uid,
                                 info: {
                                   name: user.name,
                                   image: user.image,
                                 },
                                 credentials: {
                                   token: user.token,
                                 }
        })
        visit user_path id: user.id
        click_link 'Log in with Facebook'
      end

      it { current_path.should eq events_path }
      it { should have_content "login as #{user.name}" }
      it { should_not have_content 'login failure' }
    end

    context 'failure' do
      before do
        OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
        visit user_path id: user.id
        click_link 'Log in with Facebook'
      end

      it { current_path.should eq events_path }
      it { should have_content 'login failure' }
    end
  end

  describe '/auth/google' do
    let(:user){ create :user }

    context 'success' do
      before do
        OmniAuth.config.mock_auth[:google_oauth2] =
        OmniAuth::AuthHash.new({
                                 provider: 'google_oauth2',
                                 uid: user.uid,
                                 info: {
                                   name: user.name,
                                   image: user.image,
                                 },
                                 credentials: {
                                   token: user.token,
                                 }
        })
        visit user_path id: user.id
        click_link 'Log in with Google'
      end

      it { current_path.should eq events_path }
      it { should have_content "login as #{user.name}" }
      it { should_not have_content 'login failure' }
    end

    context 'failure' do
      before do
        OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
        visit user_path id: user.id
        click_link 'Log in with Google'
      end

      it { current_path.should eq events_path }
      it { should have_content 'login failure' }
    end
  end

  describe '/auth/github' do
    let(:user){ create :user }

    context 'success' do
      before do
        OmniAuth.config.mock_auth[:github] =
        OmniAuth::AuthHash.new({
                                 provider: 'github',
                                 uid: user.uid,
                                 info: {
                                   name: user.name,
                                   nickname: user.nickname,
                                   image: user.image,
                                   description: user.description
                                 },
                                 credentials: {
                                   token: user.token,
                                   secret: user.secret
                                 }
        })
        visit user_path id: user.id
        click_link 'Log in with Github'
      end

      it { current_path.should eq events_path }
      it { should have_content "login as #{user.name}" }
      it { should_not have_content 'login failure' }
    end

    context 'failure' do
      before do
        OmniAuth.config.mock_auth[:github] = :invalid_credentials
        visit user_path id: user.id
        click_link 'Log in with Github'
      end

      it { current_path.should eq events_path }
      it { should have_content 'login failure' }
    end
  end

  describe '/auth/qiita' do
    let(:user){ create :user }

    context 'success' do
      before do
        OmniAuth.config.mock_auth[:qiita] =
        OmniAuth::AuthHash.new({
                                 provider: 'qiita',
                                 uid: user.uid,
                                 info: {
                                   name: "",
                                   nickname: user.nickname,
                                   image: user.image,
                                 },
                                 credentials: {
                                   token: user.token,
                                   secret: user.secret
                                 }
        })
        visit user_path id: user.id
        click_link 'Log in with Qiita'
      end

      it { current_path.should eq events_path }
      it { should have_content "login as #{user.nickname}" }
      it { should_not have_content 'login failure' }
    end

    context 'failure' do
      before do
        OmniAuth.config.mock_auth[:qiita] = :invalid_credentials
        visit user_path id: user.id
        click_link 'Log in with Qiita'
      end

      it { current_path.should eq events_path }
      it { should have_content 'login failure' }
    end
  end

  describe '/auth/amazon' do
    let(:user){ create :user }

    context 'success' do
      before do
        OmniAuth.config.mock_auth[:amazon] =
        OmniAuth::AuthHash.new({
                                 provider: 'amazon',
                                 uid: user.uid,
                                 info: {
                                   name: user.name,
                                 },
                                 credentials: {
                                   token: user.token
                                 }
        })
        visit user_path id: user.id
        click_link 'Log in with Amazon'
      end

      it { current_path.should eq events_path }
      it { should have_content "login as #{user.name}" }
      it { should_not have_content 'login failure' }
    end

    context 'failure' do
      before do
        OmniAuth.config.mock_auth[:amazon] = :invalid_credentials
        visit user_path id: user.id
        click_link 'Log in with Amazon'
      end

      it { current_path.should eq events_path }
      it { should have_content 'login failure' }
    end
  end

  describe '/auth/yahoojp' do
    let(:user){ create :user }

    context 'success' do
      before do
        OmniAuth.config.mock_auth[:yahoojp] =
        OmniAuth::AuthHash.new({
                                 provider: 'yahoojp',
                                 uid: user.uid,
                                 info: {
                                   name: user.name,
                                 },
                                 credentials: {
                                   token: user.token
                                 }
        })
        visit user_path id: user.id
        click_link 'Log in with Yahoo'
      end

      it { current_path.should eq events_path }
      it { should have_content "login as #{user.name}" }
      it { should_not have_content 'login failure' }
    end

    context 'failure' do
      before do
        OmniAuth.config.mock_auth[:yahoojp] = :invalid_credentials
        visit user_path id: user.id
        click_link 'Log in with Yahoo'
      end

      it { current_path.should eq events_path }
      it { should have_content 'login failure' }
    end
  end

  describe 'layout' do
    context 'not logged-in' do
      let(:user){ create :user }

      before do
        visit user_path id: user.id
      end

      it { current_path.should eq user_path id: user.id }
      it { should have_content 'Log in with Twitter' }
      it { should_not have_content 'Log out' }
    end

    context 'logged-in' do
      let(:user){ create :user }

      before do
        login! user
        visit user_path id: user.id
      end

      it { current_path.should eq user_path id: user.id }
      it { should have_content 'Log out' }
      it { should_not have_content 'Log in with Twitter' }

      context 'exec Log out' do
        before do
          click_link 'Log out'
        end

        it { current_path.should eq events_path }
        it { should have_content 'Log in with Twitter' }
        it { should_not have_content 'Log out' }
      end
    end
  end
end
