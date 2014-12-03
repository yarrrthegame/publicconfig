t = {}
local yarrrconfig = require( "yarrrconfig" )

function t.create( ship )
  yarrrconfig.create_ship(
    ship,
    {
      -- Voyager - big, sluggish starship with deadly firepower

      -- two warp nacelles
      Tile.new(TileCoordinate.new(-6, 4), TileCoordinate.new(-2, 4)),
      Tile.new(TileCoordinate.new(-6, -4), TileCoordinate.new(-2, -4)),

      -- join nacelles to body
      Tile.new(TileCoordinate.new(-4, 2), TileCoordinate.new(-4, 3)),
      Tile.new(TileCoordinate.new(-4, -3), TileCoordinate.new(-4, -2)),

      -- main body - central part
      Tile.new(TileCoordinate.new(-5, 1), TileCoordinate.new(10, -1)),
      Tile.new(TileCoordinate.new(-4, 0), TileCoordinate.new(9, 0)),

      -- main body  - side parts
      Tile.new(TileCoordinate.new(1, -2), TileCoordinate.new(9, -2)),
      Tile.new(TileCoordinate.new(1, 2), TileCoordinate.new(9, 2)),

      Tile.new(TileCoordinate.new(2, -3), TileCoordinate.new(8, -3)),
      Tile.new(TileCoordinate.new(2, 3), TileCoordinate.new(8, 3)),

      Tile.new(TileCoordinate.new(3, -4), TileCoordinate.new(6, -4)),
      Tile.new(TileCoordinate.new(3, 4), TileCoordinate.new(6, 4)),
    },
    {
      -- a lot of thruster to move this monster: for each "tile-pixel" of the nacelles, there is a forward thruster
      Thruster.new(main_thruster, TileCoordinate.new(-6, 4), degrees(180)),
      Thruster.new(main_thruster, TileCoordinate.new(-5, 4), degrees(180)),
      Thruster.new(main_thruster, TileCoordinate.new(-4, 4), degrees(180)),
      Thruster.new(main_thruster, TileCoordinate.new(-3, 4), degrees(180)),
      Thruster.new(main_thruster, TileCoordinate.new(-2, 4), degrees(180)),

      Thruster.new(main_thruster, TileCoordinate.new(-6, -4), degrees(180)),
      Thruster.new(main_thruster, TileCoordinate.new(-5, -4), degrees(180)),
      Thruster.new(main_thruster, TileCoordinate.new(-4, -4), degrees(180)),
      Thruster.new(main_thruster, TileCoordinate.new(-3, -4), degrees(180)),
      Thruster.new(main_thruster, TileCoordinate.new(-2, -4), degrees(180)),

      Thruster.new(starboard_thruster, TileCoordinate.new(-5, 4), degrees(90)),
      Thruster.new(starboard_thruster, TileCoordinate.new(-6, 4), degrees(90)),

      Thruster.new(port_thruster, TileCoordinate.new(-5, -4), degrees(270)),
      Thruster.new(port_thruster, TileCoordinate.new(-6, -4), degrees(270)),

      -- phaser
      Canon.new(TileCoordinate.new(6, -4), degrees(345)),
      Canon.new(TileCoordinate.new(8, -3), degrees(350)),
      Canon.new(TileCoordinate.new(9, -2), degrees(355)),

      Canon.new(TileCoordinate.new(10, -1), degrees(0)),
      Canon.new(TileCoordinate.new(10, 0), degrees(0)),
      Canon.new(TileCoordinate.new(10, 1), degrees(0)),

      Canon.new(TileCoordinate.new(9, 2), degrees(5)),
      Canon.new(TileCoordinate.new(8, 3), degrees(10)),
      Canon.new(TileCoordinate.new(6, 4), degrees(15)),
    })
end

return t

