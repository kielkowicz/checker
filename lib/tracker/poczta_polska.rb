require_dependency "lib/tracker/carrier.rb"
require_dependency "lib/tracker/poczta_polska_package.rb"

#Implementing Carrier class
class PocztaPolska < Carrier
	def initialize(others, wsdl = "https://tt.poczta-polska.pl/Sledzenie/services/Sledzenie?wsdl",
								 default_auth = ["sledzeniepp", "PPSA"])
		begin
	  	@soap_client=Savon.client({wsdl: wsdl, wsse_auth: default_auth}.merge others)
		rescue
			raise messages[:errors][:connection_with_service]
		end
	end

	def find number
		@soap_response = @soap_client.call(:sprawdz_przesylke_pl, :message=>{:numer=>number.to_s.upcase})
		PP_Package.new(@soap_response)
	end
end