


ESX = nil
TriggerEvent('esx:getShtestaredObjtestect', function(obj) ESX = obj end)



ESX.RegisterUsableItem('przyneta', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('wedka').count > 0 then
		TriggerClientEvent('fishingkurwaplanet:setbait', _source, "przyneta")		
		
		TriggerClientEvent('fishingkurwaplanet:message', _source, "~g~Zaczepiłeś przynętę na wędkę")		
	else
		TriggerClientEvent('fishingkurwaplanet:message', _source, "~r~Nie masz wędki")
	end
	
end)

RegisterNetEvent('fishingkurwaplanet:start')
AddEventHandler('fishingkurwaplanet:start', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
if xPlayer.getInventoryItem('wedka').count > 0 and xPlayer.getInventoryItem('przyneta').count > 0 then
TriggerClientEvent('fishingkurwaplanet:setbait', _source, "przyneta")
TriggerClientEvent('fishingkurwaplanet:fishstarted', _source)		
end
end)

function DiscordHook(hook,message,color)
    local embeds = {
                {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
				["text"] = 'CoCoRP'
                    },
                }
            }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(WebHook.sprzedaz, function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
-- biala perla
function DiscordHookb(hook,message,color)
    local embeds = {
                {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
				["text"] = 'CoCoRP'
                    },
                }
            }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(WebHook.biala, function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

-- niebieska perla perla
function DiscordHookn(hook,message,color)
    local embeds = {
                {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
				["text"] = 'CoCoRP'
                    },
                }
            }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(Webhook.niebieska, function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

-- krwawa perla
function DiscordHookk(hook,message,color)
    local embeds = {
                {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
				["text"] = 'CoCoRP'
                    },
                }
            }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(Webhook.krwawa, function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


RegisterNetEvent('fishingkurwaplanet:sprzedawanielogi')
AddEventHandler('fishingkurwaplanet:sprzedawanielogi', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
local ilosc = xPlayer.getInventoryItem('fish').count
local nazwa = xPlayer.getName()
local cena = modelPrice
local konto = xPlayer.getAccount('bank').money
local steamid = xPlayer.identifier
local name = GetPlayerName(source)	
wiadomosc = nazwa.." Sprzedaje "..ilosc.." ryb \n[ID: "..source.." | Nazwa: "..name.." | SteamID: "..steamid.." ]\n W banku"..konto..""  
DiscordHook('Sprzedaż Ryb', wiadomosc, 11750815)
end)



ESX.RegisterUsableItem('wedka', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('przyneta').count > 0 then
		TriggerClientEvent('fishingkurwaplanet:setbait', _source, "przyneta")
		TriggerClientEvent('fishingkurwaplanet:fishstart', _source)		
	end	
end)

RegisterNetEvent('fishingkurwaplanet:msg')
AddEventHandler('fishingkurwaplanet:msg', function()
TriggerClientEvent('fishingkurwaplanet:triggerDisplay', -1, source)
end)


		
RegisterNetEvent('fishing:odbierzzestaw')
AddEventHandler('fishing:odbierzzestaw', function(item)
	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if item == 'wedka' then
		if xPlayer.getInventoryItem(item).count > 0 then
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~r~ Masz już wędkę!")	
		else
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~g~ Odebrałeś wędkę")			
			xPlayer.addInventoryItem(item, 1)
		end	
	elseif item == 'przyneta' then
		if xPlayer.getInventoryItem(item).count > 0 then
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~r~ Masz już przynętę, musisz się jej pozbyć, aby odebrać nową paczkę!")	
		else
			TriggerClientEvent('fishingkurwaplanet:message', _source, "~g~ Odebrałeś paczkę przynęty")	
			xPlayer.addInventoryItem(item, 100)
		end			
	end	
end)
--items
--[[
sledz 30
fladra 25
dorsz 15
mintaj 10
sardynka 9
halibut 5
jesiotr 5 
malza 1

kamien
bialaperla
niebieskaperla
krwawaperla
]]


RegisterServerEvent('fishingkurwaplanet:bait')
AddEventHandler('fishingkurwaplanet:bait', function(cnt)

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local baitcount = xPlayer.getInventoryItem('przyneta').count	
	if baitcount > 0 then
		xPlayer.removeInventoryItem('przyneta', cnt)	
	else
		TriggerClientEvent('fishingkurwaplanet:stopit',_source)
		TriggerClientEvent('fishingkurwaplanet:message', _source, "~r~Nie masz już więcej przynęty")				
	end
end)

RegisterServerEvent("fishingkurwaplanet:lowmoney")
AddEventHandler("fishingkurwaplanet:lowmoney", function(money)
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(money)
end)

RegisterServerEvent('fishingkurwaplanet:startSelling')
AddEventHandler('fishingkurwaplanet:startSelling', function()
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
		for k,v in pairs(Config.Fishes) do
			local itemname = v.name
			local FishQuantity = xPlayer.getInventoryItem(itemname)
			if FishQuantity.count > 0 then
				local ilosc = xPlayer.getInventoryItem(itemname).count
				local nazwa = xPlayer.getName()
				local konto = xPlayer.getAccount('bank').money
				local steamid = xPlayer.identifier
				local name = GetPlayerName(source)	
				xPlayer.removeInventoryItem(v.name, ilosc)
				local payment = v.price*ilosc
				TriggerClientEvent('fishingkurwaplanet:message', _source, "Sprzedałeś "..v.name.." za $"..payment)
				wiadomosc = nazwa.." Sprzedaje "..itemname.." Za "..payment.."$!\n[ID: "..source.." | Nazwa: "..name.." | SteamID: "..steamid.." ]\n W banku"..konto..""  					
				DiscordHook('Ryby', wiadomosc, 11750815)
				TriggerClientEvent('fishingkurwaplanet:message', _source, "Sprzedałeś "..v.name.." za $"..payment)
				xPlayer.addMoney(payment)	
			end	
		end
end)

