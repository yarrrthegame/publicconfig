t = {}

local yc = require( "yarrrconfig" )

function attack( drone, mission_id )
  local ship_data = yc.ship_of_mission_by_id( mission_id )
  local drone_data = objects[ drone:id() ]
  local diff = yc.coordinate_difference( ship_data.coordinate, drone_data.coordinate )

  drone:set_velocity( yc.coordinate_from( yc.coordinate_sum( diff, yc.random_velocity( 30 ) ) ) )

  local distance = yc.distance_between( drone_data.coordinate, ship_data.coordinate )
  local aim_to = math.deg( math.atan2( diff.y / distance, diff.x / distance ) )

  drone:fire( degrees( aim_to ) )
end

function close_in( drone, mission_id )
  local ship_data = yc.ship_of_mission_by_id( mission_id )
  local drone_data = objects[ drone:id() ]
  local diff = yc.coordinate_difference( ship_data.coordinate, drone_data.coordinate )
  diff.x = diff.x / 10
  diff.y = diff.y / 10
  drone:set_velocity( yc.coordinate_from( diff ) )
end

function wander_around( object, mission_id )
  object:set_velocity( yc.coordinate_from( yc.random_velocity( 50 ) ) )
end

function add_drone_ai( object, mission_id )
  local once_in_a_second = 1000000
  object:add_behavior( LuaAgent.new( LuaFunction.new( function( drone )
    local mission = mission_contexts[ mission_id ]
    if mission == nil then
      return
    end

    if mission.drone_ai == nil then
      wander_around( object, mission_id )
      return
    end

    mission.drone_ai( drone, mission_id )
  end ), once_in_a_second ) )
end

function add_mining_drone( mission, around )
  local context = yc.context_of( mission )
  local mission_id = mission:id()
  object_factory.create_object( "drone", function( drone )
    drone:move_to( yc.coordinate_from( yc.random_location_around( around, 100 ) ) )
    yc.bind_to_mission( drone, mission_id )
    add_drone_ai( drone, mission_id )
    drone:add_behavior( ObjectIdentity.new( "Imperial Miner Drone" ) )
  end )
end


function stay_in_position_for( message, mission, coordinate, seconds, done )
  local till = universe_time() + seconds

  yc.add_objective_to( mission, {
    description = message,
    updater = function( mission )
      local ship = yc.ship_of( mission )
      local diff = yc.coordinate_difference( ship.coordinate, coordinate )
      if yc.length_of( diff ) > 2000 then
        return failed
      end

      if universe_time() > till then
        return succeeded
      end

      return ongoing
    end,
    teardown = done
  } )
end

function add_mining_drones( mission )
  local center_of_drones = yc.random_location_around( { x=0, y=0 }, 10000 )
  yc.add_instruction( mission, "Go to the last reported location of a pack of mining drones is." )
  add_mining_drone( mission, center_of_drones )
  add_mining_drone( mission, center_of_drones )
  add_mining_drone( mission, center_of_drones )
  add_mining_drone( mission, center_of_drones )
  add_mining_drone( mission, center_of_drones )
  add_mining_drone( mission, center_of_drones )
  add_mining_drone( mission, center_of_drones )
  add_mining_drone( mission, center_of_drones )
  add_mining_drone( mission, center_of_drones )
  add_mining_drone( mission, center_of_drones )
  yc.go_to( mission, center_of_drones, function( mission )
    yc.add_instruction( mission, "Interesting.  It seems they completely went haywire.  Collect as much data as you can." )
    stay_in_position_for( "Stay in position for 45 seconds,  while the instruments record enough data.", mission, center_of_drones, 15, function( mission )
      yc.context_of( mission ).drone_ai = close_in
      yc.add_instruction( mission, "Hm...  They seem to notice your presence.  Theres definitely something wrong here." )
      stay_in_position_for( "30 more seconds and you are good to go.", mission, center_of_drones, 30, function( mission )
        yc.context_of( mission ).drone_ai = attack
        yc.add_instruction( mission, "Wow!  It seems the mining laser had been modified on the drones.  You better run." )
        yc.run( mission, 1000, function( mission )
          yc.context_of( mission ).drone_ai = wander_around
          yc.add_instruction( mission, "That was close.  It seems they stopped chasing you.  Bring back the collected data for analysis." )
          yc.go_home( mission );
        end)
      end)
    end )

  end )
end


function t.create( mission )
  yc.add_instruction( mission, "Welcome pilot.  Lately many mining companies complained that their drones stopped responding." )
  yc.add_instruction( mission, "It is your duty to fly out and have a look at them." )
  add_mining_drones( mission )
end

mission_factory.register_factory( MissionInfo.new( "drone_1", "What happened to the mining drones?" ), t.create )

return t

