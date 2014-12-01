# Introduction

This is the public configuration of the yarrr server. After cloning the repository or updating your
working copy, make sure to update submodules to the latest version by executing the following commands.

~~~ bash
git submodule init
git submodule update
~~~

# Ships

## Create your own ship

Each ship design is stored in a separate file under the ships folder. The name of the file defines the
ship name using the following pattern: *ship_type.lua*.  The easiest way to start a new ship is to
make a copy of *ships/ship.lua* . This file defines the default ship that you start with in the game.
Have a look at it.

~~~ lua

t = {}
local yarrrconfig = require( "yarrrconfig" )

function t.create( ship )
  yarrrconfig.create_ship(
    ship,
    {
      Tile.new( TileCoordinate.new( -1, 0 ), TileCoordinate.new( 2, 0 ) ),
      Tile.new( TileCoordinate.new( 0, 1 ), TileCoordinate.new( 0, 1 ) ),
      Tile.new( TileCoordinate.new( 0, -1 ), TileCoordinate.new( 0, -1 ) )
    },
    {
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), degrees( 180 ) ),
      Thruster.new( port_thruster, TileCoordinate.new( 2, 0 ), degrees( 90 ) ),
      Thruster.new( starboard_thruster, TileCoordinate.new( 2, 0 ), degrees( 270 ) ),
      Canon.new( TileCoordinate.new( 2, 0 ), degrees( 0 ) ),
    })
end

return t

~~~

## Shape
The first table passed to *create_ship* defines the shape of your ship.  Objects in yarrr consist
of tiles defined by their top left and bottom right coordinate.  Imagine the coordinate system as a grid.
A single cell in it is a 5 by 5 metres rectangle.

Some examples:

~~~ lua
  -- a single cell
  Tile.new( TileCoordinate.new( 0, 0 ), TileCoordinate.new( 0, 0 ) )

  -- a 10 by 5 metres tile
  Tile.new( TileCoordinate.new( -1, 0 ), TileCoordinate.new( 0, 0 ) )
~~~

## Items
The second table describes the items attached to your ship.  The same grid system is used to place
your items.  Your ship is facing 0 degrees on the scratch area.

Item types:

 * thruster( activation key, place on ship, orientation )
 * canon( place on ship, orientation )

## Registering your ship to the object factory

~~~ lua
ship.register( { "duck", "ship", .... } )
~~~
Just add the name of your ship to the line above in *config.lua*.

## Trying out your ship
Add your design to *config.lua* and send me a pull request. When I merge your modifications it is deployed
to the server and you can try it out by typing the following command in the terminal of a running client.

~~~ yarrr
/ship list
/ship request <ship type>
~~~

# Missions

As with ships,  you are allowed to create missions in lua.  Current missions are stored under the missions
folder.

## How to start

Create a file under the missions folder with the following content.

~~~lua
t = {}

local yc = require( "yarrrconfig" )

function t.create( mission )
--mission definition
--....
end

mission_factory.register_factory( MissionInfo.new(
"mission_name", "This is a bit longer mission description." ), t.create )

return t
~~~

Enable it in config.lua.

~~~lua

--....
mission.register( { "tutorial", "your mission filename without extension" } )
--....

~~~

The code above registers the factory method for mission: *mission_name*. When someone asks for this
mission, the *t.create* function gets called.  The only parameter of the create function is the mission
object.  Your job is to add the first objective to it in the *create* function.

## Objectives

Missions are essentially a collection of objectives.  Each objective is mandatory.  An objective
has a description and a function defined in lua called the *updater*.  The state of an objective depends
on the return value of the updater function.

Objective states:

 * ongoing
 * failed
 * succeeded

As long as the updater returns *ongoing* state, it gets called once every second.  Once it returns
succeeded or failed, it stops being updated.

Let's see how it works in practice.

~~~lua
--... rest of mission file
function t.create( mission )
  yc.add_objective( mission,
  {

    description = "objective description",

    setup = function( mission )
      --called once before the first updater call
    end,

    updater = function( mission )
      --the updater function
    end,

    teardown = function( mission )
      --called once after the updater function returns succeeded
    end

  } )

end
--... rest of mission file
~~~

The code above adds an objective to mission.  The objective is described with a lua table.  I said
that an objective has only an updater function, but it seems there are three here.  Actually the
*setup*, *updater* and *teardown* functions are glued together to one updater function in yarrrconfig,
but you don't need to do anything with that.  Let's see what are they.

 * setup: Called once before the first updater call.  Great place to initialize anything for the objective.
 * updater: The updater function I have already talked about.
 * teardown: Called once after the updater returns succeeded.  Great place to add your next objective to
 the mission.

Let's see a few silly examples.

~~~lua
--... the never ending mission
function t.create( mission )
  yc.add_objective( mission,
  {
    description = "You can not do anything.",

    updater = function( mission )
      return ongoing
    end,
  } )

end

--... the patience mission
function t.create( mission )
  yc.add_objective( mission,
  {
    description = "Wait for it...",

    setup = function( mission )
      local context = yc.context_of( mission )
      context.started_at = universe_time()
    end,

    updater = function( mission )
      local context = yc.context_of( mission )
      local five_minutes = 500

      if ( universe_time() - context.started_at > five_minutes ) then
        return succeeded
      end

      return ongoing
    end,

    teardown = function( mission )
      yc.add_instruction( mission, "You are patiente." )
    end
  } )

end
~~~

The best place to improve your knowledge is to read some existing mission code.

## Mission context

A lua table called *context* is created for each mission.  You can store state information in it.
The context table is created after the *create* function but accessible during any updater, setup or
teardown call.

~~~lua
function t.create( mission )
  yc.context_of( mission ) --invalid, the context is not created yet

  yc.add_objective( mission,
  {

    something = yc.context_of( mission ), --still invalid, the context is not created yet

    description = "objective description",

    setup = function( m )
      yc.context_of( m ) --valid
    end,

    updater = function( m )
      yc.context_of( m ) --valid
    end,

    teardown = function( m )
      yc.context_of( m ) --valid
    end

  } )

end
--... rest of mission file
~~~

# The lua environment

The number of things accessible from lua is increasing every day.  I've collected a subset of the
engine interface here.  To have a full picture of what is possible at the moment read existing mission code.

## Creating objects from lua

You can create every object listed under the ships folder.

~~~lua
  function random_vector()
    return yc.coordinate_from( yc.random_location_around( { x=0, y=0 }, 1000 ) )
  end

  function object_decorator( duck )
    duck:move_to( random_vector() )
    duck:set_velocity( random_vector() )
    duck:add_behavior( CallWhenDestroyed.new( LuaFunction.new( function()
      print( "Oh noooo!" )
    end ) ) )
  end

  object_factory.create_object( "duck", object_decorator )
~~~

The code above asks the object factory to create an object of type duck, and pass it to the
*object_decorator* function.  In the decorator function you can play with your duck as it pleases you.

## List of existing objects and object properties

~~~lua
for id, object in ipairs( objects ) do
  print( id, object.coordinate, object.velocity, object.orientation, object.angular_velocity )
end
~~~

## List of existing missions

~~~lua
for id, mission in ipairs( mission_contexts ) do
  print( id, mission.character.object_id )
end
~~~

