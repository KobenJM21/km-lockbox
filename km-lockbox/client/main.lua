local QBCore = exports['qb-core']:GetCoreObject()

local function AddRadialParkingOption()
    local Player = PlayerPedId()
    MenuItemId = exports['qb-radialmenu']:AddOption({
        id = 'open_lock_box',
        title = 'Open Lockbox',
        icon = 'lock',
        type = 'client',
        event = 'km-lockbox:client:getstash',
        shouldClose = true
    }, MenuItemId)
end

local function updateRadial()
    if QBCore.Functions.GetPlayerData().job.name == 'police' then
        AddRadialParkingOption()
    elseif MenuItemId ~= nil then
        exports['qb-radialmenu']:RemoveOption(MenuItemId)
        MenuItemId = nil
    end
end

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    updateRadial()
end)

RegisterNetEvent('km-lockbox:client:getstash', function()
    local Player = PlayerPedId()
    if IsPedInAnyVehicle(Player) then
        if QBCore.Functions.GetPlayerData().job.name == 'police' then
            local Vehicle = GetVehiclePedIsIn(Player, false)
            local id = GetVehicleNumberPlateText(Vehicle)
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "Lock Box " .. id, {
                maxweight = Config.lockbox['weight'],
                slots = Config.lockbox['slots'],
            })
            TriggerEvent("inventory:client:SetCurrentStash", "Lock Box " .. id)
        else
            QBCore.Functions.Notify("Wrong Occupation!")
        end
    else
        QBCore.Functions.Notify("You are not in a Unit!")
    end
end)

