local yarrrconfig = require( "yarrrconfig" )

function create_basic_ship()
  return yarrrconfig.create_ship(
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

