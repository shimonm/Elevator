require_relative './spec_helper'

describe 'floor' do

  before do
    @building = Building.new
    @floor = Floor.new(floor_number: 3,
                          building: @building,
                          call_buttons: @number_of_elevators)
    @building.add_floors(@floor)
    @person = Person.new(destination_floor:2)
  end

  it 'it can access the building from the floor' do
    @building.must_equal @floor.building
  end

  it 'creates a correct floor number' do
    @floor.floor_number.must_equal 3
  end

  it 'can add people to a queue' do
    @floor.person_queue.must_be_empty
    @floor.add_people(@person)
  end

  it 'deletes a person from the queue after they enter an elevator' do
    @floor.add_people(@person)
    @floor.enter_elevator(@person)
    @floor.person_queue.must_be_empty
  end

  it 'adds a person to exiting_people array after they get out of the elevator' do
    @floor.exiting_people.must_be_empty
    @floor.exit_elevator(@person)
    @floor.exiting_people.size.must_equal 1
  end

  it 'calls an elevator' do
    @floor.call_elevator
    @building.get_elevator_calls.size.must_equal 1
  end

end
