# Elevator
<a href="https://codeship.com/projects/77469"><img src="https://codeship.com/projects/93cda740-d230-0132-495d-16c1124d299d/status?branch=master" /></a>
<a href="https://codeclimate.com/github/shimonm/Elevator"><img src="https://codeclimate.com/github/shimonm/Elevator/badges/gpa.svg" /></a>


## Usage

Start the app with `ruby sim.rb`

## Description

Simulate a `Building` with `Elevators`, `Floors`, and `People`. 

### Simulation

The `Simulation` class runs on repeated iterations we call `clock_ticks`, where in every iteration, the program simulates a `Building` in which `People` want to get to different `Floors` using `Elevators`. `Simulation` creates the `Building` and the agents that comprise it. 

### Building

The `Building` holds a collection of `Floors` and `Elevators`, and it also manages the task of making a call to an `Elevator` from a specific `Floor`. At every iteration of `clock_tick` the `Building` send a `clock_tick` command to all the `elevators`. 

### Floor

The `Floor` holds a queue of `People` that are waiting to board a passing `Elevator`. The `Floor` class makes the elevator calls for the `People` to the `Building` which holds the collection of `Elevators`.

### Elevator

The `Elevator` holds a list of `Passangers` and is travelling :up and :down the `Building`. The `Elevator` can determine what elevator calls it is getting in order to travel to the `Floors` that have `People` queueing in them. 

## Design Decisions

* In order to change the current configuration (1 `Elevator`, 5 `Floors`, 5 `Simulations`) please change them in `sim.rb`. 
* People are created randomly as the `Simulation` continues (at a %50 chance). 
* The `Elevator` class ques the elevator calls and determines which ones it should answer in a first-come-first-served basis, while travelling up and down, stopping once at every floor for every `clock_tick`.

## Limitations

As of the most recent build the `Simulation` class can only simulate one elevator in a building, but as many `floors`, `people`, and `simulations` as you want.  
