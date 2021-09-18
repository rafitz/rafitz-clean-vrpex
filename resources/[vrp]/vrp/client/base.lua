local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

tvRP = {}
local players = {}
Tunnel.bindInterface("vRP",tvRP)
vRPserver = Tunnel.getInterface("vRP")
Proxy.addInterface("vRP",tvRP)

local user_id
function tvRP.setUserId(_user_id)
	user_id = _user_id
end

function tvRP.getUserId()
	return user_id
end

function tvRP.getUserHeading()
	return GetEntityHeading(PlayerPedId())
end

function tvRP.teleport(x,y,z)
	SetEntityCoords(PlayerPedId(),x+0.0001,y+0.0001,z+0.0001,1,0,0,1)
	vRPserver._updatePos(x,y,z)
end

function tvRP.clearWeapons()
    RemoveAllPedWeapons(PlayerPedId(),true)
end

function tvRP.getPosition()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
	return x,y,z
end

function tvRP.isInside()
	local x,y,z = tvRP.getPosition()
	return not (GetInteriorAtCoords(x,y,z) == 0)
end

function tvRP.getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)
	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
		x = x/len
		y = y/len
		z = z/len
	end
	return x,y,z
end

function tvRP.addPlayer(player)
	players[player] = true
end

function tvRP.removePlayer(player)
	players[player] = nil
end

function tvRP.getNearestPlayers(radius)
	local r = {}
	local ped = GetPlayerPed(i)
	local pid = PlayerId()
	local px,py,pz = tvRP.getPosition()

	for k,v in pairs(players) do
		local player = GetPlayerFromServerId(k)
		if player ~= pid and NetworkIsPlayerConnected(player) then
			local oped = GetPlayerPed(player)
			local x,y,z = table.unpack(GetEntityCoords(oped,true))
			local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
			if distance <= radius then
				r[GetPlayerServerId(player)] = distance
			end
		end
	end
	return r
end

function tvRP.getNearestPlayer(radius)
	local p = nil
	local players = tvRP.getNearestPlayers(radius)
	local min = radius+0.0001
	for k,v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
end


function tvRP.playSound(dict,name)
	PlaySoundFrontend(-1,dict,name,false)
end

AddEventHandler("playerSpawned",function()
	TriggerServerEvent("vRPcli:playerSpawned")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if NetworkIsSessionStarted() then
			TriggerServerEvent("Queue:playerActivated")
			return
		end
	end
end)