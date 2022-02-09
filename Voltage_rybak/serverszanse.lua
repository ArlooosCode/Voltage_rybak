ESX = nil
TriggerEvent('esx:getShtestaredObjtestect', function(obj) ESX = obj end)

RegisterNetEvent('fishingkurwaplanet:catch')
AddEventHandler('fishingkurwaplanet:catch', function(bait)
	
	local _source = source
	local weight = 1
	local rnd = math.random(1,10000)
	local xPlayer = ESX.GetPlayerFromId(_source)

	if bait == "przyneta" then		
		if rnd >= 7000 then
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~g~Złapałeś śledzia")
			xPlayer.addInventoryItem('sledz', 1)
		elseif rnd >= 4500 then
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~g~Złapałeś flądrę")
			xPlayer.addInventoryItem('fladra', 1)			
		elseif rnd >= 3000 then
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~g~Złapałeś dorsza")
			xPlayer.addInventoryItem('dorsz', 1)	
		elseif rnd >= 2300 then
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~g~Złapałeś mintaja")
			xPlayer.addInventoryItem('mintaj', 1)	
		elseif rnd >= 1400 then
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~g~Złapałeś sardynkę")
			xPlayer.addInventoryItem('sardynka', 1)			
		elseif rnd >= 700 then
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~g~Złapałeś halibuta")
			xPlayer.addInventoryItem('halibut', 1)	
		elseif rnd >= 200 then
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~g~Złapałeś jesiotra")
			xPlayer.addInventoryItem('jesiotr', 1)	
		else
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~y~Wyłowiłeś małżę")
			xPlayer.addInventoryItem('malza', 1)			
		end
	end
end)

ESX.RegisterUsableItem('malza', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('malza').count > 0 then
		xPlayer.removeInventoryItem('malza', 1)
		local rnd = math.random(1,10000)
		local nazwa = xPlayer.getName()
		local konto = xPlayer.getAccount('bank').money
		local steamid = xPlayer.identifier
		local name = GetPlayerName(source)		
		if rnd > 2000 then
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~y~W małży był ~u~kamień")
			xPlayer.addInventoryItem('kamien', 1)			
		elseif rnd > 500 then
			wiadomosc = nazwa.." znalazł w małży białą perłę \n[ID: "..source.." | Nazwa: "..name.." | SteamID: "..steamid.." ]\n W banku"..konto..""  
			DiscordHookb('Biała Perła', wiadomosc, 11750815)			
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~y~W małży była ~w~Biała Perła")
			xPlayer.addInventoryItem('bialaperla', 1)			
		elseif rnd > 100 then
			wiadomosc = nazwa.." znalazł w małży niebieską perłę \n[ID: "..source.." | Nazwa: "..name.." | SteamID: "..steamid.." ]\n W banku"..konto..""  
			DiscordHookn('Niebieska Perła', wiadomosc, 11750815)			
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~y~W małży była ~b~Niebieska Perła")
			xPlayer.addInventoryItem('niebieskaperla', 1)			
		else
			wiadomosc = nazwa.." znalazł w małży krwawą perłę \n[ID: "..source.." | Nazwa: "..name.." | SteamID: "..steamid.." ]\n W banku"..konto..""  
			DiscordHookk('Krwawa Perła', wiadomosc, 11750815)			
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~y~W małży była ~r~Krwawa Perła")
			xPlayer.addInventoryItem('krwawaperla', 1)			
		end
	end	
end)


