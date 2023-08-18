require "rails_helper"

RSpec.feature 'Score feature testing', type: :feature, js: true do
    it 'accesses scoreboard' do
        score_and_user = FactoryBot.create(:score)
        visit root_path
        click_on 'Scoreboard'

        expect(page).to have_text("Scoreboard")
        expect(page).to have_text(score_and_user.user.name)
        expect(page).to have_text(score_and_user.user.username)
        expect(page).to have_text(score_and_user.score)
        click_on 'Back'
        expect(page).to have_text('Welcome to Liz\'s Connect4 Game!')
    end

    it 'accesses connect4 game' do
        bot1 = FactoryBot.create(:score)
        bot2 = FactoryBot.create(:score)
        visit root_path

        new_window = window_opened_by { click_on 'Connect4' }

        within_window new_window do
            expect(page).to have_text("To access game, please fill out the following:")
        
            fill_in :rounds, with: (rand(1..6) * 2) - 1
            fill_in :username1, with: bot1.user.username
            fill_in :username2, with: bot2.user.username
            click_button "Submit"

            expect(page).to have_text("Connect4")
            expect(page).to have_text("Red Player: #{bot1.user.username}")
            expect(page).to have_text("Yellow Player: #{bot2.user.username}")
            expect(page).to have_text("#{bot1.user.username}'s Score: 0")
            expect(page).to have_text("#{bot2.user.username}'s Score: 0")
            expect(page).to have_text("Round")
            expect(page).to have_text("turn to play!")
        end

        # use jest for playing the game and getting the correct buttons dynamically
        # for next round and starting new game.
    end
end
