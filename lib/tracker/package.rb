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
	
	def rodzaj_przesylki
	  raise messages[:errors][:method_not_implemented]
	end
	
	def data_nadania
	  raise messages[:errors][:method_not_implemented]
	end
	
	def in_system?
	  raise messages[:errors][:method_not_implemented]
  end
end