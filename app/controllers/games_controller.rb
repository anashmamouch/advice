class GamesController < ApplicationController
  #no need for authentication
  #before_action :authenticate_user!

  def index
    @games = Game.all.order('created_at DESC').page(params[:page])
    @count = @games.count

    respond_to do |format|
        format.html
        format.json { @games = Game.all ; render json: @games }
        format.csv  { @games = Game.all ; send_data @games.to_csv }
        format.pdf  do
          @games = Game.all
          pdf = Prawn::Document.new

          pdf.text "Statistiques WakeUpPilot"
          pdf.move_down 10
          #pdf.table
          data = @games.map do |game|
            if game.first_time
              first = "OUI"
            else
              first = "NON"
            end
            [
                  game.player_name,
                  game.player_age,
                  game.player_genre,
                  game.total_touches,
                  game.ball_touched,
                  first,
                  game.created_at.strftime("%d/%m/%Y  %H:%M")
            ]
          end
          pdf.table [["Nom", "Age", "Genre", "Total", "Ball touche", "Reference", "Crée le"]] + data
          send_data pdf.render, filename: "wakeuppilot.pdf", type: "application/pdf", disposition: ""
        end
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
			params.require(:game).permit(:ball_touched, :total_touches, :first_time, :player_id, :player_name, :player_age, :player_genre )
		end

end
