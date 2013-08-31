class HomeController < ApplicationController
  def index
  end
	def check
		@number = params[:number]
	  soap_client=Savon.client(wsdl: "https://tt.poczta-polska.pl/Sledzenie/services/Sledzenie?wsdl", \
									 ssl_verify_mode: :none, wsse_auth: ["sledzeniepp", "PPSA"])
		soap_response = soap_client.call(:sprawdz_przesylke, :message=>{:numer=>@number.to_s.upcase})
		@response = soap_response.body.to_h.to_json
		render json: @response
	end
end
