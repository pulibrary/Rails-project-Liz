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

    def begin_round
        
    end

    # def setScore
        
    # end
   
    private 

    def score_params
        params.require(:score).permit(:score, :datetime)
    end
end
