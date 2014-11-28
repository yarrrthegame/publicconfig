t = {}

local yc = require( "yarrrconfig" )

function add_random_checkpoint( mission )
  local destination = {
    x = math.random( -1000, 1000 ),
    y = math.random( -1000, 1000 ) }

  local till = universe_time() + 300;

  mission:add_objective( MissionObjective.new(
    "Your last objective is to navigate the ship to position ".. destination.x .. ", ".. destination.y .. " until " .. os.date( "!%T", till ),
    function( m )
      return yc.checkpoint( m:id(), destination, 100, till )
    end ) )
end


function add_speed_check( mission )
  mission:add_objective( MissionObjective.new(
    [===[You can see your ship in the middle of the screen.  To activate your main engine press the UP arrow button.]===],
    yc.wrap_updater(
      function() end,
      function( m )
        if ( not yc.is_slower_than( 50, yc.ship_of_mission( m:id() ) ) ) then
          return succeeded
        end
        return ongoing
      end,
      function( m )
        yc.add_instruction( m, "Great! As you can see after an impulse your ship is drifting in a straight line." )
        yc.add_instruction( m, "\"An object either remains at rest or continues to move at a constant velocity, unless acted upon by an external force.\", Newton" )
        add_rotation_check( m )
      end
    ) ) )
end

function add_rotation_check( mission )
  mission:add_objective( MissionObjective.new(
    [===[Now try to spin the ship by using eighter the port ( LEFT ) or the starboard ( RIGHT ) engine.]===],
    yc.wrap_updater(
      function() end,
      function( m )
        angular_velocity = yc.ship_of_mission( m:id() ).angular_velocity
        if ( angular_velocity ~= 0 ) then
          return succeeded
        end
        return ongoing
      end,
      function( m )
        yc.add_instruction( m, "Fabulous! The next step might be a bit challenging, but don't give up.")
        add_stop_check( m )
      end
    ) ) )
end

function add_stop_check( mission )
  mission:add_objective( MissionObjective.new(
    "Try to stop your vessel.",
    yc.wrap_updater(
      function() end,
      function( m )
        if yc.is_slower_than( 10, yc.ship_of_mission( m:id() ) ) then
          return succeeded
        end
        return ongoing
      end,
      function( m )
        yc.add_instruction( m, "Congratulations! You know everything about moving around in yarrr space." )
        add_random_checkpoint( m )
      end
    ) ) )
end

function t.create( mission )
  yc.add_instruction(
    mission,
    "Welcome to you first tutorial mission.  I will guide you through the basics of ship movement." )

  add_speed_check( mission )
end

mission_factory.register_factory( MissionInfo.new( "tutorial", "First tutorial to show you the basics." ), t.create )

return t

