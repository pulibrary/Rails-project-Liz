require "rails_helper"

RSpec.feature 'User feature testing', type: :feature do
    scenario 'create new account' do
        # should visit or click button?
        click_on 'Create new account'

        fill_in 'Name', with: 'Maria'
        fill_in 'Username', with: 'maria'
        fill_in 'Password', with: '123'
        click_button 'Submit'
        
        expect(flash[:notice]).to match("Account created successfully!") 
    end
end

RSpec.feature 'User feature testing', type: :feature do
    scenario 'access profile and edit account info' do
        click_on 'Profile'

        fill_in 'Username', with: 'Liz16'
        fill_in 'Password', with: '123'
        click_button 'Login'

        expect(flash[:notice]).to match("Login successful!") 

        click_on 'Edit'
        
        fill_in 'Name', with: ''
        fill_in 'Name', with: 'New user'
        
        fill_in 'Username', with: ''
        fill_in 'Username', with: 'New username'

        fill_in 'Password', with: '0'
        click_button 'Submit'
        
        expect(flash[:notice]).to match("Updated account successfully!") 
    end
end