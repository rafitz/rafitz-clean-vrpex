local client_areas = {}
AddEventHandler("vRP:playerLeave",function(user_id,source)
	local areas = client_areas[source]
	if areas then
		for k,area in pairs(areas) do
			if area.inside and area.leave then
				area.leave(source,k)
			end
		end
	end
	client_areas[source] = nil
end)

function vRP.setArea(source,name,x,y,z,radius,height,cb_enter,cb_leave)
	local areas = client_areas[source] or {}
	client_areas[source] = areas
	areas[name] = { enter = cb_enter, leave = cb_leave }
	vRPclient._setArea(source,name,x,y,z,radius,height)
end

function vRP.removeArea(source,name)
	vRPclient._removeArea(source,name)
	local areas = client_areas[source]
	if areas then
		local area = areas[name] 
		if area then
			if area.inside and area.leave then
				area.leave(source,name)
			end
			areas[name] = nil
		end
	end
end

function tvRP.enterArea(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local areas = client_areas[source]
	if not vRP.searchReturn(source,user_id) then
		if areas then
			local area = areas[name] 
			if area and not area.inside then
				area.inside = true
				if area.enter then
					area.enter(source,name)
				end
			end
		end
	end
end

function tvRP.leaveArea(name)
	local areas = client_areas[source]
	if areas then
		local area = areas[name] 
		if area and area.inside then
			area.inside = false
			if area.leave then
				area.leave(source,name)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
local search = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(search) do
			if v > 0 and vRP.getUserSource(k) then
				search[k] = v - 1
				if v == 0 then
					search[k] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.searchReturn(source,user_id)
	if search[user_id] == 0 or not search[user_id] then
		return false
	else
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.searchTimer(user_id,timer)
	if search[user_id] == 0 or not search[user_id] then
		search[user_id] = parseInt(timer)
	else
		search[user_id] = search[user_id] + parseInt(timer)
	end
end