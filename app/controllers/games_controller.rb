class GamesController < ApplicationController
  #no need for authentication
  #before_action :authenticate_user!

  def index
    @games = Game.all

    respond_to do |format|
        format.html
        format.json { @games = Game.all ; render json: @games }
    end
  end

  def create
    @game = Game.new(game_params)
    @game.save
    redirect_to root_url
  end

  def show
    @game = Game.find(params[:id])

    respond_to do |format|
        format.html { @game.destroy ; redirect_to root_url and return}
        format.json { render json: @game }
    end
    #Log.find(params[:id]).destroy
  end

  def destroy
    Game.find(params[:id]).destroy
    redirect_to root_url
  end

  private
	# Use callbacks to share common setup or constraints between actions.
	    def set_game
	      @game = Game.find(params[:id])
	    end

		def game_params
			params.require(:game).permit(:ball_touched, :total_touches, :first_time, :player_id)
		end

end
