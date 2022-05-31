local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("lockbox", "Open Secure Lock Box (Police Only)", {}, false, function(source)
    TriggerClientEvent('km-lockbox:client:getstash', source)
end)
