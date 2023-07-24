require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context "GET #index" do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  # context 'GET #create_account' do
  #   it 'returns a success response' do
  #     get :create_account, params: {id: user.to_param}
  #     expect(response).to be_successful
  #   end
  # end

  # context 'GET #scoreboard' do
  #   it 'returns a success response' do
  #     user = User.create!(name: 'Pedro', username: 'pedro111', password: 'xakjs354')
  #     get :scoreboard, params: {id: user.to_param}
  #     expect(response).to be_success
  #   end
  # end

  # context 'GET #access_profile' do
  #   it 'returns a success response' do
  #     user = User.create!(name: 'Pedro', username: 'pedro111', password: 'xakjs354')
  #     get :access_profile, params: {id: user.to_param}
  #     expect(response).to be_success
  #   end
  # end

  # context 'GET #new' do
  #   it 'returns a success response' do
  #     user = User.create!(name: 'Pedro', username: 'pedro111', password: 'xakjs354')
  #     get :new, params: {id: user.to_param}
  #     expect(response).to be_success
  #   end
  # end

  # context 'GET #list_players' do
  #   it 'returns a success response' do
  #     user = User.create!(name: 'Pedro', username: 'pedro111', password: 'xakjs354')
  #     get :list_players, params: {id: user.to_param}
  #     expect(response).to be_success
  #   end
  # end

  # context 'GET #create' do
  #   it 'returns a success response' do
  #     user = User.create!(name: 'Pedro', username: 'pedro111', password: 'xakjs354')
  #     get :create, params: {id: user.to_param}
  #     expect(response).to be_success
  #   end
  # end

  # context 'GET #create' do
  #   it 'returns a success response' do
  #     user = User.create!(name: 'Pedro', username: 'pedro111', password: 'xakjs354')
  #     get :create, params: {id: user.to_param}
  #     expect(response).to be_success
  #   end
  # end

  # context 'GET #edit' do
  #   it 'returns a success response' do
  #     user = User.create!(name: 'Pedro', username: 'pedro111', password: 'xakjs354')
  #     get :edit, params: {id: user.to_param}
  #     expect(response).to be_success
  #   end
  # end

end
