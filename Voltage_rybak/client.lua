ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtestaredObjtestect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local fishingkurwaplanet = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0
local stop = false
local bait = "przyneta"
local JuzBlip = false
local JuzBlip2 = false
local inarea = false
--Tworzenie blipa pracy
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not JuzBlip then
			if PlayerData.job and PlayerData.job.name ~= 'fisher' then
				local blip = AddBlipForCoord(Config.SellFish.x, Config.SellFish.y, Config.SellFish.z)

				SetBlipSprite (blip, 356)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 0.7)
				SetBlipColour (blip, 17)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("Sprzedaż Ryb")
				EndTextCommandSetBlipName(blip)
				JuzBlip = true
			else
				Citizen.Wait(4000)
			end
		end		
	end			
end)			
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not JuzBlip2 then
			if PlayerData.job and PlayerData.job.name ~= 'fisher' then			
				for _, info in pairs(Config.MarkerZones) do
					info.blip = AddBlipForCoord(info.x, info.y, info.z)
					SetBlipSprite(info.blip, 455)
					SetBlipDisplay(info.blip, 4)
					SetBlipScale(info.blip, 0.7)
					SetBlipColour(info.blip, 0)
					SetBlipAsShortRange(info.blip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString("Pobór Wędki oraz Przynęty")
					EndTextCommandSetBlipName(info.blip)
					JuzBlip2 = true	
				end
			else
				Citizen.Wait(4000)
			end
		end		
	end			
end)	
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if PlayerData.job and PlayerData.job.name ~= 'fisher' then
			for k in pairs(Config.MarkerZones) do
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, true) <= 12 then
					DrawMarker(1, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 150, 150, 100, 0, 0, 0, 0)	
				else
					Citizen.Wait(1000)				
				end
			end
		else
			Citizen.Wait(4000)
		end
    end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	while true do
		Wait(400)
		if pause and fishingkurwaplanet then
			pausetimer = pausetimer + 1
		end
	end
end)
local antyspam = false


Citizen.CreateThread(function()
while true do
	Wait(5000)
	local playerPed = PlayerPedId()
	  if IsEntityInArea(playerPed, -1860.53,-1230.306,4.8,-1826.08,-1272.0,12.0) then
		inarea = true
		else
		inarea = false
	  end
	end
end)

Citizen.CreateThread(function() 
	while true do
		InvalidateIdleCam()
		N_0x9e4cfff989258472() --Disable the vehicle idle camera
		Wait(1000) --The idle camera activates after 30 second so we don't need to call this per frame
	end 
end)

Citizen.CreateThread(function()
	while true do
	Wait(0)
		if PlayerData.job and PlayerData.job.name ~= 'fisher' then
			if fishingkurwaplanet then
				if (IsControlJustPressed(0, 38) and pausetimer <= 4) then
					input = 99		
				end
			else
				Citizen.Wait(1000)			
			end	
		else
			Citizen.Wait(4000)
		end	
	end
end)
--[[
Citizen.CreateThread(function()
while true do
	Wait(0)
		if IsControlPressed(0, Keys['LEFTSHIFT']) and IsControlJustPressed(0, Keys['N']) and fishingkurwaplanet == false and not antyspam then
		antyspam = true
		TriggerServerEvent('fishingkurwaplanet:start')	
		Citizen.Wait(300)
		antyspam = false
		end
	end
end)]]
Citizen.CreateThread(function()
	while true do
		Wait(3)
		if PlayerData.job and PlayerData.job.name ~= 'fisher' then
			if fishingkurwaplanet then
				if IsControlJustPressed(0, 73) then
					fishingkurwaplanet = false
					ESX.ShowNotification("~r~Koniec łowienia")
				end
			else
				Citizen.Wait(500)					
			end
		else
			Citizen.Wait(3000)	
		end
	end
end)	
Citizen.CreateThread(function()
	while true do
		Wait(3)
		if PlayerData.job and PlayerData.job.name ~= 'fisher' then
			if fishingkurwaplanet then
				if IsControlJustPressed(0, 38) and pausetimer > 4 and pausetimer < 9 then
						input = 1
				elseif pausetimer > 9 then		
						input = 99
				end
			else
				Citizen.Wait(500)					
			end	
		else
			Citizen.Wait(3000)	
		end
	end		
end)

local selling= false
Citizen.CreateThread(function()
	while true do
		Wait(3)
		if PlayerData.job and PlayerData.job.name ~= 'fisher' then
				if fishingkurwaplanet then
					if fishingkurwaplanet then
				
						playerPed = GetPlayerPed(-1)
						local pos = GetEntityCoords(GetPlayerPed(-1))
						if inarea then
							
						else
							fishingkurwaplanet = false
							ESX.ShowNotification("~r~Musisz łowić na dolnej części mola. Jest to oznaczone blipem.")
						end
						if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
							ESX.ShowNotification("~r~Nie możesz być w wodzie lub na BW")
						end
					end
				if pause and input ~= 0 then
					pause = false
					if input == correct then
						TriggerServerEvent('fishingkurwaplanet:catch', "przyneta")
						lowienie()
						input = 0
					else
						ESX.ShowNotification("~r~Nie udało się złowić ryby, zarzucono wędkę kolejny raz")
						lowienie()
						input = 0
					end
				end
			else
				Citizen.Wait(200)					
			end

			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 5 then
				TriggerServerEvent('fishingkurwaplanet:startSelling', "fish")
				if selling == false then
					TriggerServerEvent('')
					TriggerEvent('fishingkurwaplanet:sprzedawanielogi')
				end
				Citizen.Wait(4000)
			end
		else
			Citizen.Wait(3000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(500)
		if PlayerData.job and PlayerData.job.name ~= 'fisher' then
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 5 then
				TriggerServerEvent('fishingkurwaplanet:startSelling', "fish")
				Citizen.Wait(5000)
			end
		end
	end
end)	

RegisterNetEvent('fishingkurwaplanet:sprzedawanielogi')
AddEventHandler('fishingkurwaplanet:sprzedawanielogi', function()
selling = true
Citizen.Wait(60000)
selling = false
end)

RegisterNetEvent('fishingkurwaplanet:stopit')
AddEventHandler('fishingkurwaplanet:stopit', function()
fishingkurwaplanet = false
bait = nil
end)
				
Citizen.CreateThread(function()
	while true do
		Wait(7)
		if PlayerData.job and PlayerData.job.name ~= 'fisher' then
			DrawMarker(1, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
			for k in pairs(Config.MarkerZones) do
			DrawMarker(1, Config.MarkerZones[k].xs, Config.MarkerZones[k].ys, Config.MarkerZones[k].zs , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 7.0, 7.0, 3.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
			end
		else
			Citizen.Wait(3000)
		end
	end
end)



RegisterNetEvent('fishingkurwaplanet:triggerDisplay')
AddEventHandler('fishingkurwaplanet:triggerDisplay', function(source)
    local pid = GetPlayerFromServerId(source)
	if pid ~= -1 then
		Display(GetPlayerFromServerId(source))
	end
end)

function Display(mePlayer)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(3000)
        displaying = false
    end)
    Citizen.CreateThread(function()
            Citizen.Wait(0)
        while displaying do
            Citizen.Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = GetDistanceBetweenCoords(coordsMe['x'], coordsMe['y'], coordsMe['z'], coords['x'], coords['y'], coords['z'], true)
            if dist < 50 then
	               ESX.Game.Utils.DrawText3D(vector3(coordsMe['x'], coordsMe['y'], coordsMe['z']+1.2), "🎣", 1.2)			
            end
        end

    end)
end

local emote = false
function lowienie()
	if fishingkurwaplanet then
	TriggerServerEvent('fishingkurwaplanet:bait' ,1)
		local wait = math.random(Config.FishTime.a , Config.FishTime.b)
		Wait(wait)
		if fishingkurwaplanet then	
			TriggerServerEvent('fishingkurwaplanet:msg')		
		end	
			Wait(3000)	
		if fishingkurwaplanet then
			pause = true
			correct = 1
			input = 0
			pausetimer = 0
		end
	end
end

RegisterNetEvent('fishingkurwaplanet:message')
AddEventHandler('fishingkurwaplanet:message', function(message)
	ESX.ShowNotification(message)
end)
RegisterNetEvent('fishingkurwaplanet:break')
AddEventHandler('fishingkurwaplanet:break', function()
	fishingkurwaplanet = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('fishingkurwaplanet:setbait')
AddEventHandler('fishingkurwaplanet:setbait', function(bool)
	bait = bool
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('fishingkurwaplanet:fishstarted')
AddEventHandler('fishingkurwaplanet:fishstarted', function()
local playerPed = GetPlayerPed(-1)
local pos = GetEntityCoords(GetPlayerPed(-1))
if IsPedInAnyVehicle(playerPed) then
	ESX.ShowNotification("~y~Nie możesz łowić z łódki")
else
	if bait == "przyneta" then
		--if pos.y >= 2700 or pos.y <= -800 or pos.x <= -2200 or pos.x >= 3300 then
			ESX.ShowNotification("~g~Zaczęto łowienie")					
			fishingkurwaplanet = true
			lowienie()
		--else
		--	ESX.ShowNotification("~y~Musisz popłynąć dalej w ocean")
		--end
	else
		ESX.ShowNotification("~y~Nie masz już przynęty")
	end	
end
	
end, false)

RegisterNetEvent('fishingkurwaplanet:fishstart')
AddEventHandler('fishingkurwaplanet:fishstart', function()
playerPed = GetPlayerPed(-1)
local pos = GetEntityCoords(GetPlayerPed(-1))
if IsPedInAnyVehicle(playerPed) then
	ESX.ShowNotification("~y~Nie możesz łowić z łódki")
else
	if bait == "przyneta" then
		--if pos.y >= 2700 or pos.y <= -800 or pos.x <= -2200 or pos.x >= 3300 then
			ESX.ShowNotification("~g~Zaczęto łowienie")					
			ClearPedTasks(GetPlayerPed(-1))
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
			fishingkurwaplanet = true
			lowienie()
		--else
		--	ESX.ShowNotification("~y~Musisz popłynąć dalej w ocean")
		--end
	else
		ESX.ShowNotification("~y~Nie masz już przynęty")
	end	
end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local letsleep = true
		if PlayerData.job and PlayerData.job.name ~= 'fisher' then
			for k in pairs(Config.MarkerZones) do
				local ped = PlayerPedId()
				local pedcoords = GetEntityCoords(ped, false)
				local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z)
				if distance < 8.0 then
					letsleep = false
					if distance <= 1.40 then

							DisplayHelpText('Wciśnij E aby pobrać potrzebne rzeczy')
							
							if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(ped) then
								OpenBoatsMenu(Config.MarkerZones[k].xs, Config.MarkerZones[k].ys, Config.MarkerZones[k].zs,Config.MarkerZones[k].h)
							end 
					elseif distance < 1.45 then
						ESX.UI.Menu.CloseAll()
					end
				end
			end
		else
			Citizen.Wait(4000)
		end
		if letsleep then
			Citizen.Wait(1000)
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local letsleep = true
		if PlayerData.job and PlayerData.job.name ~= 'fisher' then
			for k in pairs(Config.MarkerZones) do
				
				local ped = PlayerPedId()
				local pedcoords = GetEntityCoords(ped, false)
				local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.MarkerZones[k].xs, Config.MarkerZones[k].ys, Config.MarkerZones[k].zs)
				if distance <= 7.40 then
						letsleep = false
						DisplayHelpText('Wciśnij E schować łódkę')
						
						if IsControlJustPressed(0, Keys['E']) then
						local playerPed = PlayerPedId()
						local coords	= GetEntityCoords(playerPed)

						if IsPedInAnyVehicle(playerPed, false) then
							local vehicle, distance = ESX.Game.GetClosestVehicle({
								x = coords.x,
								y = coords.y,
								z = coords.z
							})

							if distance ~= -1 and distance <= 7.5 then
								ESX.Game.DeleteVehicle(vehicle)
							end
						end					
							
						end 				
				end
			end
		else
			Citizen.Wait(4000)
		end
		if letsleep then
			Citizen.Wait(1000)
		end
    end
end)

-- pomoc dla debili
RegisterCommand("rybak", function(source, args, raw)
                  rybakhelp()
end, false)

function rybakhelp()
		ESX.Scaleform.ShowPopupWarning("Rybak", "Musisz udać się na sam koniec mola, zejść schodami w dół, tam możesz zarzucić swoją wędkę do wody. Aby złowić rybę musisz poczekać, aż nad twoją głową pojawi się znaczek ryby i 3 sekundy po jego zniknięciu kliknąć przycisk 'E'", bottom, 8)
end

function OpenBoatsMenu(x, y , z,h)
	local ped = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
	local elements = {}
	
	
		table.insert(elements, {label = 'Odbierz przynętę', value = 'przyneta'})
		table.insert(elements, {label = 'Odbierz wędkę', value = 'wedka'})		
		table.insert(elements, {label = 'Jak łowić ryby?', value = 'jak'})		
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'client',
    {
		title    = 'Rybak',
		align    = 'left',
		elements = elements,
    },
	
	
	function(data, menu)



	if data.current.value == 'przyneta' or data.current.value == 'wedka' then
		TriggerServerEvent('fishing:odbierzzestaw', data.current.value)		
	elseif data.current.value == 'jak' then
	rybakhelp()
	end

	ESX.UI.Menu.CloseAll()
	

    end,
	function(data, menu)
		menu.close()
		end
	)
end
