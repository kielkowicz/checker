require_dependency "lib/tracker/poczta_polska.rb"

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
