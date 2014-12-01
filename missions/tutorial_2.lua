t = {}

local yc = require( "yarrrconfig" )

function duck_updater( mission )
  local context = yc.context_of( mission )

  if context.number_of_living_ducks == 0 then
    return succeeded
  end

  return ongoing
end

function increment_number_of_living_ducks( context )
  if context.number_of_living_ducks == nil then
    context.number_of_living_ducks = 0
  end

  context.number_of_living_ducks = context.number_of_living_ducks + 1
end

function add_duck_with_decorator( mission, decorator )
  local context = yc.context_of( mission )
  increment_number_of_living_ducks( context )

  object_factory.create_object( "duck", function( duck )
    duck:move_to( yc.coordinate_from( yc.random_location_around( { x=0, y=0 }, 1000 ) ) )
    decorator( duck )
    duck:add_behavior( CallWhenDestroyed.new( LuaFunction.new( function()
      context.number_of_living_ducks = context.number_of_living_ducks - 1
    end ) ) )

  end )
end

function push_duck( duck )
  duck:set_velocity( yc.coordinate_from( yc.random_location_around( { x=0, y=0 }, 500 ) ) )
end

function go_home( mission )
  local till = universe_time() + 300;

  yc.add_objective_to( mission, {

    description = "Go to position 0, 0 until " .. os.date( "!%T", till ) .. " to finish the training.",

    updater = function( mission )
      return yc.checkpoint( mission, { x=0, y=0 }, 1000, till )
    end

  } )

end

function add_final_hunt( mission )
  yc.add_objective_to( mission, {
    description = "Shoot down two more!",

    setup = function( mission )
      add_duck_with_decorator( mission, push_duck )
      add_duck_with_decorator( mission, push_duck )
    end,

    updater = duck_updater,

    teardown = function( mission )
      yc.add_instruction(
      mission,
      "Good job!  Your basic space battle training is over now, but remember: Real pirates shoot back!" )
      go_home( mission );
    end

  } )
end

function add_moving_duck( mission )

  yc.add_objective_to( mission, {

    description = "I have sent you another one, but this one moves.  Shoot it down before it escapes!",

    setup = function( mission )
      add_duck_with_decorator( mission, push_duck )
    end,

    updater = duck_updater,

    teardown = function( mission )
      yc.add_instruction( mission, "Well done!" )
      add_final_hunt( mission )
    end

  } )
end

function add_standing_duck( mission )

  yc.add_objective_to( mission, {
    description = "I have sent an imperial robot duck to shoot at.  Use the radar on the bottom right of your screen to find it. Keep firing at it until it explodes.",
    setup = function( mission )
      add_duck_with_decorator( mission, function( duck ) end )
    end,
    updater = duck_updater,
    teardown = function( mission )
      add_moving_duck( mission )
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

  add_standing_duck( mission )
end

mission_factory.register_factory( MissionInfo.new( "tutorial_2", "Second tutorial, space combat." ), t.create )

return t

