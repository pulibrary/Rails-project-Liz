require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  user = FactoryBot.create(:user)
  user_id = user.id

  context "GET #index" do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  context 'GET #create_account' do
    it 'returns a success response' do
      get :create_account
      expect(response).to be_successful
    end
  end

  context 'GET #scoreboard' do
    it 'returns a success response' do
      get :scoreboard
      expect(response).to be_successful
    end
  end

  context 'GET #access_profile' do
    it 'returns a success response' do
      get :access_profile, params: {user_id: user_id}
      expect(response).to be_successful
    end
  end

  context 'GET #list_players' do
    it 'returns a success response' do
      get :list_players
      expect(response).to be_successful
    end
  end

# Note: The status code 302 represents a redirection.
# In the create action, when a user is successfully created,
# we're redirecting to root_path with redirect_to root_path.
# In RSpec, when you check if the response was successful using expect(response).to
#  be_successful, it checks if the status code is between 200 and 299.
# A 302 status code does not fall into this range, hence the failure.
# SO: use be_redirect instead of be_successful for this test.
  context 'POST #create' do
    it 'returns a success response' do
      # user_params = {user: {name: "A#{user.name}", username: "A#{user.username}", password: user.password}}
      # p "user params = #{user_params}"
      user_params = {
        user: {
          name: user.name,
          username: "new_username_#{user.username}",
          password: "new_password"
        }
      }
      post :create, params: user_params
      expect(response).to be_redirect
    end
  end

  context 'POST #edit' do
    it 'returns a success response' do
      get :edit, params: {id: user_id}
      expect(response).to be_successful
    end
  end
end
