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
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), yarrrconfig.degrees( 180 ) ),
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), yarrrconfig.degrees( 180 ) ),
      Thruster.new( port_thruster, TileCoordinate.new( 2, 0 ), yarrrconfig.degrees( 90 ) ),
      Thruster.new( starboard_thruster, TileCoordinate.new( 2, 0 ), yarrrconfig.degrees( 270 ) ),
      Canon.new( TileCoordinate.new( 2, 1 ) ),
      Canon.new( TileCoordinate.new( 2, -1 ) ),
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
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), yarrrconfig.degrees( 180 ) ),
      Thruster.new( port_thruster, TileCoordinate.new( 2, 0 ), yarrrconfig.degrees( 90 ) ),
      Thruster.new( starboard_thruster, TileCoordinate.new( 2, 0 ), yarrrconfig.degrees( 270 ) ),
      Canon.new( TileCoordinate.new( 2, 0 ) ),
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
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), yarrrconfig.degrees( 180 ) ),
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), yarrrconfig.degrees( 180 ) ),
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), yarrrconfig.degrees( 180 ) ),
      Thruster.new( main_thruster, TileCoordinate.new( -1, 0 ), yarrrconfig.degrees( 180 ) ),
      Thruster.new( port_thruster, TileCoordinate.new( 4, 0 ), yarrrconfig.degrees( 90 ) ),
      Thruster.new( starboard_thruster, TileCoordinate.new( 4, 0 ), yarrrconfig.degrees( 270 ) ),
      Canon.new( TileCoordinate.new( 1, -1 ) ),
      Canon.new( TileCoordinate.new( 2, 0 ) ),
      Canon.new( TileCoordinate.new( 1, 1 ) ),
    })
end
register_object_factory( "interceptor", create_interceptor )


function create_tremulous_ship( tremulous_ship )
  yarrrconfig.create_ship(
    tremulous_ship,
    {
      Tile.new( TileCoordinate.new( -1, 0 ), TileCoordinate.new( 2, 0 ) ),
      Tile.new( TileCoordinate.new( 1, 1 ), TileCoordinate.new( 1, 1 ) ),
      Tile.new( TileCoordinate.new( 1, -1 ), TileCoordinate.new( 1, -1 ) )
    },
    {
      Thruster.new( main_thruster, TileCoordinate.new( 2, 0 ), yarrrconfig.degrees( 0 ) ),
      Thruster.new( port_thruster, TileCoordinate.new( -1, 0 ), yarrrconfig.degrees( 270 ) ),
      Thruster.new( starboard_thruster, TileCoordinate.new( -1, 0 ), yarrrconfig.degrees( 90 ) ),
      Canon.new( TileCoordinate.new( 2, 0 ) ),
    })
end
register_object_factory( "tremulous", create_tremulous_ship )

