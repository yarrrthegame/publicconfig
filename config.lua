local yarrrconfig = require( "yarrrconfig" )

function create_duck( duck )
  yarrrconfig.create_ship(
    duck,
    {
      Tile.new( TileCoordinate.new( -2, 1 ), TileCoordinate.new( 1, -2 ) ),
      Tile.new( TileCoordinate.new( 2, 0 ), TileCoordinate.new( 3, 0 ) ),
      Tile.new( TileCoordinate.new( 0, -3 ), TileCoordinate.new( 0, -3 ) ),
      Tile.new( TileCoordinate.new( 0, -4 ), TileCoordinate.new( 1, -4 ) ),
    },
    {
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), degrees( 180 ) ),
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), degrees( 180 ) ),
      Thruster.new( port_thruster, TileCoordinate.new( 2, 0 ), degrees( 90 ) ),
      Thruster.new( starboard_thruster, TileCoordinate.new( 2, 0 ), degrees( 270 ) ),
      Canon.new( TileCoordinate.new( 2, 1 ), degrees( 0 ) ),
      Canon.new( TileCoordinate.new( 2, -1 ), degrees( 0 ) ),
    })
end

register_object_factory( "duck", create_duck )

function create_basic_ship( ship )
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
register_object_factory( "ship", create_basic_ship )

function create_interceptor( interceptor )
  yarrrconfig.create_ship(
    interceptor,
    {
      Tile.new( TileCoordinate.new( -1, 0 ), TileCoordinate.new( 4, 0 ) ),

      Tile.new( TileCoordinate.new( 0, 2 ), TileCoordinate.new( 0, 1 ) ),
      Tile.new( TileCoordinate.new( 1, 1 ), TileCoordinate.new( 1, 1 ) ),

      Tile.new( TileCoordinate.new( 0, -1 ), TileCoordinate.new( 0, -2 ) ),
      Tile.new( TileCoordinate.new( 1, -1 ), TileCoordinate.new( 1, -1 ) ),
    },
    {
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), degrees( 180 ) ),
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), degrees( 180 ) ),
      Thruster.new( main_thruster, TileCoordinate.new( 0, 1 ), degrees( 180 ) ),
      Thruster.new( main_thruster, TileCoordinate.new( 0, -1 ), degrees( 180 ) ),

      Thruster.new( port_thruster, TileCoordinate.new( 4, 0 ), degrees( 90 ) ),
      Thruster.new( port_thruster, TileCoordinate.new( 4, 0 ), degrees( 90 ) ),
      Thruster.new( port_thruster, TileCoordinate.new( 3, 0 ), degrees( 90 ) ),

      Thruster.new( starboard_thruster, TileCoordinate.new( 4, 0 ), degrees( 270 ) ),
      Thruster.new( starboard_thruster, TileCoordinate.new( 4, 0 ), degrees( 270 ) ),
      Thruster.new( starboard_thruster, TileCoordinate.new( 3, 0 ), degrees( 270 ) ),

      Canon.new( TileCoordinate.new( 1, -1 ), degrees( 0 ) ),
      Canon.new( TileCoordinate.new( 2, 0 ), degrees( 0 ) ),
      Canon.new( TileCoordinate.new( 1, 1 ), degrees( 0 ) ),
    })
end
register_object_factory( "interceptor", create_interceptor )


function create_tremulous_ship( tremulous_ship )
  yarrrconfig.create_ship(
    tremulous_ship,
    {
      Tile.new( TileCoordinate.new( -1, 0 ), TileCoordinate.new( 2, 0 ) ),
      Tile.new( TileCoordinate.new( 0, 1 ), TileCoordinate.new( 0, 1 ) ),
      Tile.new( TileCoordinate.new( 0, -1 ), TileCoordinate.new( 0, -1 ) )
    },
    {
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), degrees( 180 ) ),
      Thruster.new( port_thruster, TileCoordinate.new( 2, 0 ), degrees( 90 ) ),
      Thruster.new( starboard_thruster, TileCoordinate.new( 2, 0 ), degrees( 270 ) ),
      Canon.new( TileCoordinate.new( -1, 0 ), degrees( 180 ) ),
    })
end
register_object_factory( "tremulous", create_tremulous_ship )

function create_bike( bike )
  yarrrconfig.create_ship(
    bike,
    {
      -- left tire
      Tile.new( TileCoordinate.new( 0, 0 ), TileCoordinate.new( 0, -1 ) ),
      Tile.new( TileCoordinate.new( 1, 1 ), TileCoordinate.new( 2, 1 ) ),
      Tile.new( TileCoordinate.new( 3, 0 ), TileCoordinate.new( 3, -1 ) ),
      Tile.new( TileCoordinate.new( 1, -2 ), TileCoordinate.new( 2, -2 ) ),
      -- right tire
      Tile.new( TileCoordinate.new( 6, 0 ), TileCoordinate.new( 6, -1 ) ),
      Tile.new( TileCoordinate.new( 7, 1 ), TileCoordinate.new( 8, 1 ) ),
      Tile.new( TileCoordinate.new( 9, 0 ), TileCoordinate.new( 9, -1 ) ),
      Tile.new( TileCoordinate.new( 7, -2 ), TileCoordinate.new( 8, -2 ) ),
      -- stem, seat and tubes from left to right
      Tile.new( TileCoordinate.new( 3, 2 ), TileCoordinate.new( 3, 2 ) ),
      Tile.new( TileCoordinate.new( 3, 4 ), TileCoordinate.new( 3, 4) ),
      Tile.new( TileCoordinate.new( 4, 3 ), TileCoordinate.new( 4, 3) ),
      Tile.new( TileCoordinate.new( 5, 2 ), TileCoordinate.new( 5, 2 ) ),
      Tile.new( TileCoordinate.new( 6, 3 ), TileCoordinate.new( 6, 3) ),
      Tile.new( TileCoordinate.new( 6, 4 ), TileCoordinate.new( 7, 4) ),
    },
    {
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), yarrrconfig.degrees( 180 ) ),
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), yarrrconfig.degrees( 180 ) ),
      Canon.new( TileCoordinate.new( 2, 1 ), yarrrconfig.degrees( 0 ) ),
    })
end

register_object_factory( "bike", create_bike )

