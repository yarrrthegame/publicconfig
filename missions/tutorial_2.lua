t = {}

local yc = require( "yarrrconfig" )

function duck_updater( mission )
  local context = yc.context_of( mission )

  if context.was_duck_killed == true then
    return succeeded
  end

  return ongoing
end

function add_duck( mission )
  local context = yc.context_of( mission )
  context.was_duck_killed = false

  object_factory.create_object( "duck", function( duck )
    duck:add_behavior( CallWhenDestroyed.new( LuaFunction.new( function()
      context.was_duck_killed = true
    end ) ) )

  end )
end

function start( mission )

  yc.add_objective_to( mission, {

    description = "Shoot down the duck!",

    setup = add_duck,

    updater = duck_updater,

    teardown = function( mission )
    end

  } )
end


function t.create( mission )
  yc.add_instruction(
    mission,
    "Welcome to your second tutorial mission.  I will guide you through the basics of space combat this time." )

  yc.add_instruction(
    mission,
    "The basic ship is equiped with a single canon facing the same direction as the ship.  You can activate it by pressing the LEFT CONTROL button." )

  start( mission )
end

mission_factory.register_factory( MissionInfo.new( "tutorial_2", "Second tutorial, space combat." ), t.create )

return t

