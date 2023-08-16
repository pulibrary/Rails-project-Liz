class ScoresController < ApplicationController
    
    def show_game
        render "/scores/connect4"
    end

    def setup_game
        @isRoundsValid = true
        @isUsername1Valid = true
        @isUsername2Valid = true
        render :setup_game
    end

    # for post requests, must "redirect" if going to a "different" page
    def access_game
        @rounds = params[:rounds].to_i
        p "rounds = #{@rounds}"
        @usernameRedPlayer = params[:username1]
        p "username1 = #{@usernameRedPlayer}"
        @usernameYellowPlayer = params[:username2]
        p "username2 = #{@usernameYellowPlayer}"

        @isRoundsValid  = isRoundsValid(@rounds)
        @isUsername1Valid = isUsernameValid(@usernameRedPlayer)
        @isUsername2Valid = isUsernameValid(@usernameYellowPlayer)

        if @isRoundsValid && @isUsername1Valid && @isUsername2Valid 
            redirect_to show_game_path(rounds: @rounds, usernameRedPlayer: @usernameRedPlayer, usernameYellowPlayer: @usernameYellowPlayer), turbolinks: "reload"
        else
            # 422 Unprocessable Entity: request was understood but contains invalid data.
            render :setup_game, status: :unprocessable_entity
        end
    end


    def isRoundsValid(rounds)
        p "inside isRoundsValid"
        if rounds != 0 && rounds.integer? && 1 <= rounds && rounds <= 10 && rounds.odd?
            p "return true"
            return true
        else
            p "return false"
            return false
        end
    end

    def isUsernameValid(username)
        user = User.find_by(username: username)
        p "user = #{user}"
        if user
            return true
        else
            return false
        end
    end
    
    def update 
        # no need to check if username is nil since we already do that before this
        username = params[:username]
        user = User.find_by(username: username)
        currentDate = Date.today.to_s
        score = Score.find_by(user_id: user.id, updated_at: currentDate)
        
        if score
            score.update(score: score.score + 1)
        else
            # if score does not exist for user and given date, create one
            Score.create!(score: 1, user_id: user.id, updated_at: currentDate)
        end

        # head :no_content # since we do not want to redirect or render to a page
    end
   
    private 

    def score_params
        params.require(:score).permit(:score, :datetime)
    end
end
