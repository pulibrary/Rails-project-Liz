require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  user = FactoryBot.create(:user)

  context 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  context 'POST #create' do
    it 'returns a success response' do
      post :create, params: {username: user.username, password: user.password}
      expect(response).to be_redirect
    end
  end

end
