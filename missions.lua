t = {}
local helpers = require( "helpers" )
helpers.append_package_path( "missions" )

function t.register( mission_list )
  for i, mission in ipairs( mission_list ) do
    require( mission )
  end
end

return t

