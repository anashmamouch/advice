class PlayersController < ApplicationController
  #no need for authentication
  #before_action :authenticate_user!

  def index
    @players = Player.all.order('created_at DESC').page(params[:page])
    @count = @players.count
    respond_to do |format|
        format.html
        format.json { @players = Player.all ; render json: @players }
        format.csv  { @players = Player.all ; send_data @players.to_csv }
        format.pdf  do
          @players = Player.all
          pdf = Prawn::Document.new

          pdf.text "Statistiques WakeUpPilot"
          pdf.move_down 10
          #pdf.table
          data = @players.map do |player|
            [
                  player.username,
                  player.age,
                  player.genre
            ]
          end
          pdf.table [["Username", "Age", "Genre"]] + data
          send_data pdf.render, filename: "wakeuppilot.pdf", type: "application/pdf", disposition: ""
        end
    end
  end

  def create
    #don't record array if empty
    #bad dirty code!! :( 
    if !player_params[:player].empty?
      Player.create(player_params[:player])
    end

    respond_to do |format|
       format.html {redirect_to players.json_url }
       format.json {  @players = Player.all ; render json: @players }
    end
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
			params.permit(player: [:username, :age, :genre])
		end
end
