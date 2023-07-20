class ScoresController < ApplicationController
    private 

    def score_params
        params.require(:score).permit(:score, :datetime)
    end
end
