require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context 'GET #new' do
    it 'successfully renders login page' do
      get :new
      expect(response).to be_successful
    end
  end

  context 'POST #create' do
    user = FactoryBot.create(:user)
    user_id = user.id
    it 'successfully grants authorization to access profile page' do
      post :create, params: {username: user.username, password: user.password}
      expect(response).to be_redirect
    end

    it 'redirects to the profile page' do
      post :create, params: {username: user.username, password: user.password}
      expect(response).to redirect_to access_profile_path(user_id: user_id)
    end

  end

end
