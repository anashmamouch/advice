class PlayersController < ApplicationController
  before_action :authenticate_user!

  def index
    @players = Player.all

    respond_to do |format|
        format.html
        format.json { @players = Player.all ; render json: @players }
    end
  end

  def create
    @player = Player.new(player_params)
    @player.save
    redirect_to root_url
  end

  def show
    @player = Player.find(params[:id])

    respond_to do |format|
        format.html { @player.destroy ; redirect_to root_url and return}
        format.json { render json: @player }
    end
    #Log.find(params[:id]).destroy
  end

  def destroy
    Player.find(params[:id]).destroy
    redirect_to root_url
  end

  private
	# Use callbacks to share common setup or constraints between actions.
	    def set_player
	      @player = Player.find(params[:id])
	    end

		def player_params
			params.require(:player).permit(:username, :age, :genre)
		end
end
