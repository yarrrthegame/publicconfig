t = {}
local yarrrconfig = require( "yarrrconfig" )

function t.create( ship )
  yarrrconfig.create_ship(
    ship,
    {
      Tile.new( TileCoordinate.new( -1, 0 ), TileCoordinate.new( 1, 0 ) ),
      Tile.new( TileCoordinate.new( 0, 1 ), TileCoordinate.new( 0, -1 ) )
    },
    {
      Canon.new( TileCoordinate.new( 0, 0 ), degrees( 0 ) ),
    })
end

return t

