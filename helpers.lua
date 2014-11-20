helpers = {}

function helpers.append_package_path( new_path )
  package.path = package.path .. ";" .. lua_configuration_path .. "/" .. new_path .. "/?.lua"
end

helpers.append_package_path( "yarrrconfig/src" )

return helpers

