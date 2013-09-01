messages = {:errors=>{:cennection_with_service => "There were some error conneting to service provider!", 
									   :method_not_implemented => "Carrier abstract calss error! Find methond not implemented!"} }

#Carrier abstract class
class Carrier
	def find number
		raise messages[:errors][:method_not_implemented]
	end
end

#Package virtual  class
class Package
	def	from
		raise messages[:errors][:method_not_implemented]
	end
	
	def 
	
	def to
		raise messages[:errors][:method_not_implemented]
	end

	def raw
		@response
	end
end

#Implemeting Package abstract class
class PP_Package < Package
 attr_accessor :resp
	def initialize response
		@response = response.body.to_h
		@resp = @response[:sprawdz_przesylke_pl_response][:return]
	end	
	
	def from
		if in_system?
			"#{@resp[:dane_przesylki][:urzad_nadania][:nazwa]}, #{@resp[:dane_przesylki][:urzad_nadania][:dane_szczegolowe][:ulica]}"
		else
			""
		end
	end

	def to
		if in_system?
			#@resp[:dane_przesylki][:urzad_przezn][:nazwa]	
			"#{@resp[:dane_przesylki][:urzad_przezn][:nazwa]}, #{@resp[:dane_przesylki][:urzad_przezn][:dane_szczegolowe][:ulica]}"
		else
			""
		end
	end

	def rodzaj_przesylki
		if in_system?
			@resp[:dane_przesylki][:rodz_przes]
		end
	end

	def data_nadania
		if in_system?
			@resp[:dane_przesylki][:data_nadania]
		else
			""
		end
	end

	def in_system?
		@resp[:status] == "0"
	end
end

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
