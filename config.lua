package.path = package.path .. ";" .. lua_configuration_path .. "/?.lua"
local ships = require( "ships" )

ships.register( { "duck", "ship", "interceptor", "tremulous", "bike", "airtou" } )

