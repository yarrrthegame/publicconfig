t = {}

local yarrrconfig = require( "yarrrconfig" )

function add_random_checkpoint_to( mission )
  local destination = {
    x = math.random( -1000, 1000 ),
    y = math.random( -1000, 1000 ) }

  local till = os.time() + 120;
  mission:add_objective( MissionObjective.new( "Go to position: ".. destination.x .. ", ".. destination.y .. " until " .. till,
    function( mission_id )
      return yarrrconfig.checkpoint( mission_id, destination, 100, till )
    end ) )
end

function add_welcome_message_to( mission, message )
  mission:add_objective( MissionObjective.new(
  "Welcome to you first tutorial mission pilot." ..
  "Follow the instructions below this text.",
    function() return succeeded end ) )
end

function length_of( vector )
  return yarrrconfig.distance_between( { x=0, y=0 }, vector )
end

function add_speed_check( mission )
  mission:add_objective( MissionObjective.new(
    "To accelerate you ship press the UP arrow button.",
    function( mission_id )
      if ( length_of( yarrrconfig.ship_of_mission( mission_id ).velocity ) > 50 ) then
        missions[ mission_id ].was_started = true
        return succeeded
      end

      return ongoing
    end ) )
end

function add_rotation_check( mission )
  mission:add_objective( MissionObjective.new(
    "To rotate your ship press the LEFT and RIGHT arrow buttons.",
    function( mission_id )
      angular_velocity = yarrrconfig.ship_of_mission( mission_id ).angular_velocity
      if ( angular_velocity ~= 0 ) then
        return succeeded
      end

      return ongoing
    end ) )
end

function is_stopped( object )
  local speed = length_of( object.velocity )
  if speed < 10 then
    return true
  end

  return false
end

function add_stop_check( mission )
  mission:add_objective( MissionObjective.new(
    "Now try to stop your vessel.",
    function( mission_id )
      if missions[ mission_id ].was_started and is_stopped( yarrrconfig.ship_of_mission( mission_id ) ) then
         return succeeded
      end

      return ongoing
    end ) )
end

function t.create( mission )
  add_welcome_message_to( mission )
  add_speed_check( mission )
  add_rotation_check( mission )
  add_stop_check( mission )
end

mission_factory.register_factory( MissionInfo.new( "tutorial", "Welcome tutorial to show you the basics." ), t.create )

return t

