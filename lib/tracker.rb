#Abstract class
class Carrier
	def find number
		raise "Carrier abstract calss error! Find methond not implemented!"
	end
end

#Implementing Carrier class
class PocztaPolska < Carrier
	def initialize(others, wsdl = "https://tt.poczta-polska.pl/Sledzenie/services/Sledzenie?wsdl",
								 default_auth = ["sledzeniepp", "PPSA"])
	  @soap_client=Savon.client({wsdl: wsdl, wsse_auth: default_auth}.merge others)
	end

	def find number
		@soap_response = @soap_client.call(:sprawdz_przesylke, :message=>{:numer=>number.to_s.upcase})
	end
end

class Tracker
	def self.find_using carrier
		Tracker.new carrier
	end

	def initialize carrier
		@carrier = carrier
	end

	def find_carriage number
		@carriage = @carrier.find number
	end

	alias :carriage :find_carriage
end
