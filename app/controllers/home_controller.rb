class HomeController < ApplicationController
	require_dependency "tracker.rb"
  
	def index
  end

	def check
		@number = params[:number]
		# soap_response = soap_client.call(:sprawdz_przesylke, :message=>{:numer=>@number.to_s.upcase})
		# @response = soap_response.body.to_h.to_json

		carrier = PocztaPolska.new({ssl_verify_mode: :none}) # PP for some reasone do not use SSL
		render json: Tracker.find_using(carrier).carriage(@number).body.to_h.to_json 

		# render json: @response
	end
end
