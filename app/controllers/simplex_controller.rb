class SimplexController < ApplicationController

	def index
		@variables = params[:variables].to_i
		@restrictions = params[:restrictions].to_i

	end

	private
	def simplex_params
		params.require(:simplex).permit(:objective, :variables, :restrictions)
	end

end