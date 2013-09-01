#Carrier abstract class
class Carrier
	def find number
		raise messages[:errors][:method_not_implemented]
	end
end