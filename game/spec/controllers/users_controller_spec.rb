require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  user = FactoryBot.create(:user)
  user_id = user.id


  context "GET #index" do
    it 'successfully renders index page' do
      get :index
      expect(response).to be_successful
    end
  end

  context 'GET #create_account' do
    it 'successfully renders create account page' do
      get :create_account
      expect(response).to be_successful
    end
  end

  context 'GET #scoreboard' do
    it 'successfully renders scoreboard page' do
      get :scoreboard
      expect(response).to be_successful
    end
  end

  context 'GET #access_profile' do
<<<<<<< HEAD
<<<<<<< HEAD
    it 'successfully renders profile page' do
=======
    it 'successfully renders login page' do
>>>>>>> 45de828 (Finalize user controller spec; each action method has a test now and all tests pass.)
=======
    it 'successfully renders login page' do
>>>>>>> 9ba7aa7 (Finalize user controller spec; each action method has a test now and all tests pass.)
      get :access_profile, params: {user_id: user_id}
      expect(response).to be_successful
    end
  end

  context 'GET #list_players' do
    it 'successfully renders list of players page' do
      get :list_players
      expect(response).to be_successful
    end
  end

  context 'GET #edit' do
    it 'successfully renders edit profile page' do
      get :edit, params: {id: user_id}
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
    user_params = {
      user: {
        name: user.name,
        username: "new_username_#{user.username}",
        password: "new_password"
      }
    }
    it 'successfully creates new account' do
      post :create, params: user_params
      expect(response).to be_redirect
    end

    it 'successfully redirects to home page' do
      post :create, params: user_params
      expect(response).to redirect_to root_path
    end
  end

  context 'PATCH #update' do
    user_params = {
      id: user_id,
      user: {
        name: "updated name",
        username: "updated username",
        password: "updated_password"
      }
    }

    it 'successfully updates account information' do
      patch :update, params: user_params
      # Fetch latest data from database
      user.reload
      expect(user.name).to eq("updated name")
      expect(user.username).to eq("updated username")
      expect(user.authenticate("updated_password")).to be_truthy
    end

    it 'redirects to the home page' do
      patch :update, params: user_params
      expect(response).to redirect_to "/users"
    end
  end

  context 'DELETE #destroy' do
    it 'successfully deletes account' do
      expect {
        delete :destroy, params: {id: user_id}
      }.to change(User, :count).by(-1)
    end
  
    it 'redirects to the home page' do
      delete :destroy, params: {id: user_id}
      expect(response).to redirect_to root_path
    end
  end

end
