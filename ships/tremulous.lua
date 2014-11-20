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
      Canon.new( TileCoordinate.new( -1, 0 ), degrees( 180 ) ),
    })
end

return t

