class ScoresController < ApplicationController
    # TODO after javascript training:
    # Include adding new score to user after playing game.
    private 

    def score_params
        params.require(:score).permit(:score, :datetime)
    end
end
