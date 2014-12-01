t = {}

local yc = require( "yarrrconfig" )

function add_random_checkpoint( mission )
  local destination = yc.random_location_around( { x=0, y=0 }, 1000 )
  local till = universe_time() + 300;

  yc.add_objective_to( mission, {

    description = "Your last objective is to navigate the ship to position ".. destination.x .. ", ".. destination.y .. " until " .. os.date( "!%T", till ),

    updater = function( m )
      return yc.checkpoint( m, destination, 100, till )
    end } )

end


function add_speed_check( mission )
  yc.add_objective_to( mission, {

    description = [===[You can see your ship in the middle of the screen.  To activate your main engine press the UP arrow button.]===],

    updater = function( m )
      if ( not yc.is_slower_than( 50, yc.ship_of( m ) ) ) then
        return succeeded
      end
      return ongoing
    end,

    teardown = function( m )
      yc.add_instruction( m, "Great! As you can see after an impulse your ship is drifting in a straight line." )
      yc.add_instruction( m, "\"An object either remains at rest or continues to move at a constant velocity, unless acted upon by an external force.\", Newton" )
      add_rotation_check( m )
    end } )

end

function add_rotation_check( mission )
  yc.add_objective_to( mission, {

    description = [===[Now try to spin the ship by using eighter the port ( LEFT ) or the starboard ( RIGHT ) engine.]===],

    updater = function( m )
      angular_velocity = yc.ship_of( m ).angular_velocity
      if ( angular_velocity ~= 0 ) then
        return succeeded
      end
      return ongoing
    end,

    teardown = function( m )
      yc.add_instruction( m, "Fabulous! The next step might be a bit challenging, but don't give up.")
      add_stop_check( m )
    end } )

end

function add_stop_check( mission )
  yc.add_objective_to( mission, {

    description = "Try to stop your vessel.",

    updater = function( m )
      if yc.is_slower_than( 10, yc.ship_of( m ) ) then
        return succeeded
      end
      return ongoing
    end,

    teardown = function( m )
      yc.add_instruction( m, "Congratulations! You know everything about moving around in yarrr space." )
      add_random_checkpoint( m )
    end } )

end

function t.create( mission )
  yc.add_instruction(
    mission,
    "Welcome to you first tutorial mission.  I will guide you through the basics of ship movement." )

  add_speed_check( mission )
end

mission_factory.register_factory( MissionInfo.new( "tutorial", "First tutorial to show you the basics." ), t.create )

return t

