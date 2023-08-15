class ScoresController < ApplicationController
    def access_game
        render "connect4"
    end

    def validate_username
        username = params[:username]
        user = User.find_by(username: username)
        if user
            render json: { valid: true, message: "exists" }
        else
            render json: { valid: false, message: "does not exist." }
        end
    end

    def start_new_game
        render "connect4" # displays html
    end
    
    def update 
        username = params[:username]
        user = User.find_by(username: username)
        currentDate = Date.today.to_s
        score = Score.find_by(user_id: user.id, updated_at: currentDate)
        
        if score
            score.update(score: score.score + 1)
            p `score + 1 = #{score.score + 1}`
        else
            # if score does not exist for user and given date, create one
            Score.create!(score: 1, user_id: user.id, updated_at: currentDate)
        end

        head :no_content # since we do not want to redirect or render to a page
    end
   
    private 

    def score_params
        params.require(:score).permit(:score, :datetime)
    end
end
