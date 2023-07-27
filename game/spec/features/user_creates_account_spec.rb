feature 'User creates account' do
    scenario 'they see the profile button on the homepage' do
        visit authenticate_new_path

        fill_in 'Name', with: 'New user'
        click_button 'Create account'
end