t = {}
local yarrrconfig = require( "yarrrconfig" )

function t.create( ship )
  yarrrconfig.create_ship(
    ship,
    {
      Tile.new( TileCoordinate.new( 0, 0 ), TileCoordinate.new( 8, -8 ) ),

      Tile.new( TileCoordinate.new( 4, 1 ), TileCoordinate.new( 4, 11 ) ),
      Tile.new( TileCoordinate.new( 0, 20 ), TileCoordinate.new( 8, 12 ) ),

      Tile.new( TileCoordinate.new( 4, -9 ), TileCoordinate.new( 4, -19 ) ),
      Tile.new( TileCoordinate.new( 0, -20 ), TileCoordinate.new( 8, -28 ) ),

      Tile.new( TileCoordinate.new( -11, -4 ), TileCoordinate.new( -1, -4 ) ),
      Tile.new( TileCoordinate.new( -20, 0 ), TileCoordinate.new( -12, -8 ) ),

      Tile.new( TileCoordinate.new( 9, -4 ), TileCoordinate.new( 19, -4 ) ),
      Tile.new( TileCoordinate.new( 20, 0 ), TileCoordinate.new( 28, -8 ) ),
    },
    {
      Thruster.new(port_thruster, TileCoordinate.new(24, 1), degrees( 90 )),
      Thruster.new(port_thruster, TileCoordinate.new(-16, -9), degrees( 270 )),

      Thruster.new(starboard_thruster, TileCoordinate.new(24, -9), degrees(270)),
      Thruster.new(starboard_thruster, TileCoordinate.new(-16, 1), degrees(90)),
    })
end

return t

