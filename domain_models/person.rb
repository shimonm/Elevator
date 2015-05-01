class Person

	attr_reader :destination_floor

  # The person cares for their destination floor, the rest of her functionality is in Elevator and Floor.
	def initialize(args)
		@destination_floor = args[:destination_floor]
	end

  def to_s
    "#{@destination_floor}"
  end

end