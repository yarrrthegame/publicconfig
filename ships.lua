ships = {}
local helpers = require( "helpers" )
helpers.append_package_path( "ships" )

function register_ship( ship_name )
  local t = require( ship_name )
  object_factory.register_factory( ship_name, t.create )
end

function ships.register( ship_list )
  for i, ship in ipairs( ship_list ) do
    register_ship( ship )
  end
end

return ships

