t = {}
local yarrrconfig = require( "yarrrconfig" )

function t.create( ship )
  yarrrconfig.create_ship(
    ship,
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
      Thruster.new( main_thruster, TileCoordinate.new( 10, 0 ), degrees( 0 ) ),
      Thruster.new( main_thruster, TileCoordinate.new( 10, 1 ), degrees( 0 ) ),

      Thruster.new( port_thruster, TileCoordinate.new( 2, 0 ), degrees( 90 ) ),
      Thruster.new( starboard_thruster, TileCoordinate.new( 2, 0 ), degrees( 270 ) ),
      Canon.new( TileCoordinate.new( 2, -1 ), degrees( 184 ) ),
      Canon.new( TileCoordinate.new( 2, -1 ), degrees( 183 ) ),
      Canon.new( TileCoordinate.new( 2, -1 ), degrees( 182 ) ),
      Canon.new( TileCoordinate.new( 2, 0 ), degrees( 181 ) ),
      Canon.new( TileCoordinate.new( 2, 1 ), degrees( 180 ) ),
      Canon.new( TileCoordinate.new( 2, 2 ), degrees( 179 ) ),
      Canon.new( TileCoordinate.new( 2, 3 ), degrees( 178 ) ),
      Canon.new( TileCoordinate.new( 2, 3 ), degrees( 177 ) ),
      Canon.new( TileCoordinate.new( 2, 3 ), degrees( 176 ) ),

    })
end

return t

