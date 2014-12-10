package.path = package.path .. ";" .. lua_configuration_path .. "/?.lua"

local ship = require( "ships" )
ship.register( { "duck", "ship", "interceptor", "tremulous", "bike", "airtou", "voyager", "drone" } )

local mission = require( "missions" )
mission.register( { "tutorial", "tutorial_2", "drone_1" } )

