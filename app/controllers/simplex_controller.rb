class SimplexController < ApplicationController

	def index
		@variables = params[:variables].to_i
		@restrictions = params[:restrictions].to_i

		#raise @variables.inspect
	end

	def solution
		@to_solve = []

		@variables = params[:variables].to_i
		@restrictions = params[:restrictions].to_i

		@objectives = []

		(1..@variables).each do |x|
			@objectives.push params["objectives_"+"#{x}"].to_i
		end

		@values = []

		(1..@restrictions).each do |x|
			(1..@variables).each do |i|
				@values.push params["values_"+"#{x}_#{i}"].to_i
			end
		end

		@values = @values.each_slice(@variables).to_a

		@results = []

		(1..@restrictions).each do |x|
			@results.push params["results_"+"#{x}"].to_i
		end

		@to_solve.push @objectives
		@to_solve.push @values
		@to_solve.push @results

		#@simplex = Simplex.new([1, 1, 1], [[ 2,  1, 1], [ 1,  2, 1], [ 2,  1, 2], [ 7,  2, 4]],[4, 3, 7, 5])
		@simplex = Simplex.new(@objectives, @values, @results)

		#raise @simplex.solution.inspect
	end

	private
	def simplex_params
		params.require(:simplex).permit(:objectives, :variables, :restrictions, :values, :results)
	end

end