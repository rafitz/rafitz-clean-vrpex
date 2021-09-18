RegisterServerEvent("vrp-personagem:finishedIntro")
RegisterServerEvent("vrp-personagem:finishedCharacter")

-- DEFAULT --
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local userlogin = {}

async(function()
	vRP.prepare("vRP/update_user_first_spawn","UPDATE vrp_user_identities SET name = @name, firstname = @firstname, age = @age WHERE user_id = @user_id")
end)
--[[ Spawn Controller ]]
-- 1 - Intro
-- 2 - Create Character
-- 3 - Normal Spawn

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		local data = vRP.getUData(user_id,"vRP:spawnController")
		local spawnStatus = json.decode(data) or 0
		SetTimeout(5000, function() -- tunnel/proxy delay
			processSpawnController(source, spawnStatus, user_id)
		end)
	end
end)

function processSpawnController(source,statusSent,user_id)
	local source = source
	if statusSent == 2 then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			doSpawnPlayer(source,user_id,false)
		else
			doSpawnPlayer(source,user_id,true)
		end
	elseif statusSent == 1 or statusSent == 0 then
		userlogin[user_id] = true
		TriggerClientEvent("vrp-personagem:characterCreate",source)
	end
end

AddEventHandler("vrp-personagem:finishedIntro", function()
	--print("finishedIntro")
	-- setUData spawnController = 1
	TriggerClientEvent("vrp-personagem:characterCreate", source)
end)

AddEventHandler("vrp-personagem:finishedCharacter", function(characterNome, characterSobrenome, characterAge, currentCharacterMode)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local player = vRP.getUserSource(user_id)

		vRP.setUData(user_id,"currentCharacterMode", json.encode(currentCharacterMode))
		vRP.setUData(user_id,"vRP:spawnController", json.encode(2))
		vRP.execute("vRP/update_user_first_spawn", {
			user_id = user_id,
			name = characterNome,
			firstname = characterSobrenome,
			age = characterAge
		})
		--print("finishedCharacter")
		doSpawnPlayer(source,user_id,true)
	end
end)

function doSpawnPlayer(source,user_id,firstspawn)
	TriggerClientEvent("vrp-personagem:normalSpawn",source,firstspawn)
	TriggerEvent("vrp-barbershop:init",user_id)
end