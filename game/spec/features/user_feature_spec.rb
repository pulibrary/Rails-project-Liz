require "rails_helper"

RSpec.feature 'User feature testing', type: :feature do
    it 'create new account' do
        visit root_path
        click_on 'create an account'

        fill_in 'Name', with: 'Maria'
        fill_in 'Username', with: 'maria'
        fill_in 'Password', with: '123'
        click_button 'Submit'
        
        expect(page).to have_text('Account created successfully!') 
    end
 
    it 'accesses profile and edits account info' do
        user = FactoryBot.create(:user)
        visit root_path
        click_on 'Profile'

        fill_in 'Username', with: user.username
        fill_in 'Password', with: user.password
        click_button 'Login'

        expect(page).to have_text('Login successful!') 

        click_on 'Edit'

        expect(page).to have_current_path("/users/#{user.id}/edit")
        
        # fill_in('Name', with: 'New User', fill_options: { clear: :backspace })
        fill_in 'Name', with: ''
        fill_in 'Name', with: 'New user'
        
        fill_in 'Username', with: ''
        fill_in 'Username', with: 'New username'

        fill_in 'Password', with: '0'
        click_button 'Submit'
        
        expect(page).to have_text('Updated account successfully!') 
    end

    # scenario 'see newly updated account in list of players and then return to home page' do
    #     click_on 'list of all players'

    #     expect(page).to have_text('New username')

    #     click_on 'Back'

    #     expect(page).to have_text('Welcome to Liz\'s Connect4 Game!')
    # end
end

# Currently, I do  not have functionalities for scoreboard.