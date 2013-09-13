class HomeController < ApplicationController
	require_dependency "tracker/tracker.rb"
  
  #Just to serve fromt page
	def index
  end

	def check
		@number = params[:number]
		carrier = PocztaPolska.new({ssl_verify_mode: :none}) # PP for some reasone do not use SSL
		@package = Tracker.find_using(carrier).carriage(@number)
	#	render json: {from: package.from, to: package.to, type: package.rodzaj_przesylki, date: package.data_nadania, status: package.in_system? }
	end
end
