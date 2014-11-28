t = {}

local yc = require( "yarrrconfig" )

function add_random_checkpoint( mission )
  local destination = {
    x = math.random( -1000, 1000 ),
    y = math.random( -1000, 1000 ) }

  local till = universe_time() + 300;
  mission:add_objective( MissionObjective.new( "Go to position: ".. destination.x .. ", ".. destination.y .. " until " .. os.date( "!%T", till ),
    function( mission )
      return yc.checkpoint( mission:id(), destination, 100, till )
    end ) )
end


function add_speed_check( mission )
  mission:add_objective( MissionObjective.new(
    "To accelerate you ship press the UP arrow button.",
    function( mission )
      if ( not yc.is_slower_than( 50, yc.ship_of_mission( mission:id() ) ) ) then
        missions[ mission:id() ].was_accelerated = true
        return succeeded
      end

      return ongoing
    end ) )
end

function add_rotation_check( mission )
  mission:add_objective( MissionObjective.new(
    "To spin your ship press the LEFT and RIGHT arrow buttons.",
    function( mission )
      angular_velocity = yc.ship_of_mission( mission:id() ).angular_velocity
      if ( angular_velocity ~= 0 ) then
        return succeeded
      end

      return ongoing
    end ) )
end

function add_stop_check( mission )
  mission:add_objective( MissionObjective.new(
    "Now try to stop your vessel.",
    function( mission )
      if not missions[ mission:id() ].was_accelerated then
        return ongoing
      end

      if yc.is_slower_than( 10, yc.ship_of_mission( mission:id() ) ) then
         return succeeded
      end

      return ongoing
    end ) )
end

function t.create( mission )
  yc.add_instruction(
    mission,
    "Welcome to you first tutorial mission.  Follow the instructions below this text." )

  add_speed_check( mission )
  add_rotation_check( mission )
  add_stop_check( mission )
  add_random_checkpoint( mission )
end

mission_factory.register_factory( MissionInfo.new( "tutorial", "First tutorial to show you the basics." ), t.create )

return t

