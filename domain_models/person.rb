class Person

	attr_reader :destination_floor

	def initialize(args)
		@destination_floor = args[:destination_floor]
	end

  def to_s
    "#{@destination_floor}"
  end

end