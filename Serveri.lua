ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('Poimuri', function(source)
    local Pelaaja = ESX.GetPlayerFromId(source)
    local max = Pelaaja.getInventoryItem('Mustikka').count

    if max > 200 then
        Pelaaja.showNotification('Sinulla on liikaa mustikoita repussa')
    else
        TriggerClientEvent('BubsiMustikka', source)
    end
end)

ESX.RegisterUsableItem('sankko', function(source)
    local Pelaaja = ESX.GetPlayerFromId(source)
    local mustikka = Pelaaja.getInventoryItem('Mustikka').count

    if mustikka > 150 then
        Pelaaja.removeInventoryItem('Mustikka', 150)
        Pelaaja.removeInventoryItem('sankko', 1)
        Pelaaja.addInventoryItem('tsankko', 1)
        Pelaaja.showNotification('Laitoit mustikat sankkoon')
    else 
        Pelaaja.showNotification('Sinulla ei ole tarpeeksi mustikoita')
    end
end)

ESX.RegisterUsableItem('tsankko', function(source)
    local Pelaaja = ESX.GetPlayerFromId(source)

        Pelaaja.addInventoryItem('Mustikka', 150)
        Pelaaja.addInventoryItem('sankko', 1)
        Pelaaja.removeInventoryItem('tsankko', 1)
        Pelaaja.showNotification('tyhjensit sankon')
end)

RegisterServerEvent('Mustikkaa')
AddEventHandler('Mustikkaa', function()
     local Pelaaja = ESX.GetPlayerFromId(source)
     local maara = math.random(Config.min, Config.max)
     
     Pelaaja.addInventoryItem('Mustikka', maara)
end)

RegisterServerEvent('myynti')
AddEventHandler('myynti', function()
    local Pelaaja = ESX.GetPlayerFromId(source)
    local sankko = Pelaaja.getInventoryItem('tsankko').count

    if sankko == 0 then
        Pelaaja.showNotification('Sinulla ei ole myytäviä mustikka sankkoja')
    else
        Pelaaja.addMoney(Config.raha)
        Pelaaja.removeInventoryItem('tsankko', 1)
    end
end)