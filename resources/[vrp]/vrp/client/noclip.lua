local noclip = false

function tvRP.toggleNoclip()
	noclip = not noclip
	local ped = PlayerPedId()
	if noclip then
		SetEntityInvincible(ped,false) --mqcy
		SetEntityVisible(ped,false,false)
	else
		SetEntityInvincible(ped,false)
		SetEntityVisible(ped,true,false)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		if noclip then
			local ped = PlayerPedId()
			local x,y,z = tvRP.getPosition()
			local dx,dy,dz = tvRP.getCamDirection()
			local speed = 1.0

			SetEntityVelocity(ped,0.0001,0.0001,0.0001)

			if IsControlPressed(0,21) then
				speed = 5.0
			end

			if IsControlPressed(0,32) then
				x = x+speed*dx
				y = y+speed*dy
				z = z+speed*dz
			end

			if IsControlPressed(0,269) then
				x = x-speed*dx
				y = y-speed*dy
				z = z-speed*dz
			end

			SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
		end
	end
end)

function tvRP.checkDistance(x2,y2,z2,h2)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local bowz,cdz = GetGroundZFor_3dCoord(x2,y2,z2)
	local distance = GetDistanceBetweenCoords(x2,y2,cdz,x,y,z,true)
	if distance <= 1.3 then
		SetEntityHeading(ped,h2)
		return true
	end
	return false
end