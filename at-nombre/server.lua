-- Archivo: server.lua
QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("conocer", "Conocer a un jugador", {}, false, function(source, args)
    local playerId = tonumber(args[1])
    local player = QBCore.Functions.GetPlayer(playerId)

    if player then
        TriggerClientEvent("qb-conocer:conocerJugador", source, player.PlayerData.source)
    else
        TriggerClientEvent("QBCore:Notify", source, "El jugador no está en línea.", "error")
    end
end)

RegisterServerEvent("qb-conocer:conocerJugador")
AddEventHandler("qb-conocer:conocerJugador", function(playerId)
    local sourcePlayerId = source
    local player = QBCore.Functions.GetPlayer(playerId)

    if player then
        TriggerClientEvent("qb-conocer:jugadorConocido", playerId, sourcePlayerId)
    end
end)