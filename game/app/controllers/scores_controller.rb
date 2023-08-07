class ScoresController < ApplicationController
    # TODO after javascript training: https://github.com/pulibrary/Rails-project-Liz/issues/13
   
    private 

    def score_params
        params.require(:score).permit(:score, :datetime)
    end
end
