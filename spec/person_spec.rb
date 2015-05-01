require_relative './spec_helper'

describe 'person' do

  before do
    @person = Person.new(destination_floor: 3)

  end

  it 'only cares about destination floor' do
    @person.destination_floor.must_equal 3
  end

  it 'prints its attributes' do
    @person.to_s.must_equal @person.destination_floor.to_s
  end

end
