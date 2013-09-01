require_dependency 'lib/tracker/package.rb'

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
