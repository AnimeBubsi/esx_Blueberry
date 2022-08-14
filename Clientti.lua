local rinkula = nil
local koko = 100.0

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
end)

function teksti(x, y, z, text, scale)
    SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end

Citizen.CreateThread(function()
    blip = AddBlipForCoord(Config.mesta)
    SetBlipSprite(blip, 78)
    SetBlipColour(blip, 29)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Mustikka')
    EndTextCommandSetBlipName(blip)
    rinkula = AddBlipForRadius(Config.mesta, koko)
    SetBlipSprite(rinkula, 10)
end)

RegisterNetEvent('BubsiMustikka')
AddEventHandler('BubsiMustikka', function(source)
	local Pelaaja = PlayerPedId()
	local pos = GetEntityCoords(Pelaaja)
	local dist = #(pos - Config.mesta)

	if dist < koko then
		if not IsPedInAnyVehicle(Pelaaja) then
			FreezeEntityPosition(Pelaaja, true)
			  TaskStartScenarioInPlace(Pelaaja, 'WORLD_HUMAN_GARDENER_PLANT', 0, true)
				exports['progressBars']:startUI(Config.aika, 'Keräät mustikoita')
				  Citizen.Wait(Config.aika)
				   ClearPedTasksImmediately(Pelaaja)
				    FreezeEntityPosition(Pelaaja, false)
				  	 TriggerServerEvent('Mustikkaa', source)
		else
			ESX.ShowNotification("Et voi marjastaa ajoneuvosta!")
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(5)
			local Pelaaja = PlayerPedId()
			local pos = GetEntityCoords(Pelaaja)
			local dist = #(pos - Config.myynti)

			if dist < 1.3 then
				teksti(Config.myynti.x, Config.myynti.y, Config.myynti.z, '~g~[E] Myydäksesi mustikka sankon')
					if IsControlJustPressed(1, 38) then
					  exports['progressBars']:startUI(Config.myyntiaika, 'Myyt mustikoita')
					    Citizen.Wait(Config.myyntiaika)
						TriggerServerEvent('myynti', source)
					end
				end
		end
end)

Citizen.CreateThread(function()
		local blip = AddBlipForCoord(Config.myynti)
		SetBlipSprite(blip, Config.blipSprite)
		SetBlipScale(blip, Config.blipScale)
                SetBlipColour(blip, Config.blipColour)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.blipinimi)
		EndTextCommandSetBlipName(blip)
end)