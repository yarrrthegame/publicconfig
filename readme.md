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

