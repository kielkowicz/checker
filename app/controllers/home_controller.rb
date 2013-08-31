class HomeController < ApplicationController
	require_dependency "tracker.rb"
  
	def index
  end

	def check
		@number = params[:number]

		carrier = PocztaPolska.new({ssl_verify_mode: :none}) # PP for some reasone do not use SSL
		render json: Tracker.find_using(carrier).carriage(@number).body.to_h.to_json 

	end
end
