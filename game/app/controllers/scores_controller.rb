class ScoresController < ApplicationController
    def access_game
        render "connect4"
    end
   
    private 

    def score_params
        params.require(:score).permit(:score, :datetime)
    end
end
