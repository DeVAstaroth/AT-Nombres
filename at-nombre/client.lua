local knownPlayers = {}
local showPlayerIDs = true
local myServerID = GetPlayerServerId(-1)

QBCore = exports['qb-core']:GetCoreObject()

function DrawTextOnScreen(text, x, y, z, color)
    SetTextScale(0.45, 0.45)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextColour(255, 255, 255, 200)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    DrawText(x, y)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local players = GetActivePlayers()

        for _, player in ipairs(players) do
            local ped = GetPlayerPed(player)
            local playerId = GetPlayerServerId(player)
            local playerName = GetPlayerName(player)
            local coords = GetEntityCoords(ped)

            if showPlayerIDs then
                local zOffset = 1.0

                local onScreen, screenX, screenY, screenZ = World3dToScreen2d(coords.x, coords.y, coords.z + zOffset)
                if onScreen then
                    DrawTextOnScreen("🧑‍🦲 | " .. playerName .. " #" .. playerId, screenX, screenY, screenZ, color)
                end
            end
        end
    end
end)

RegisterCommand('conocer', function(source, args)
    local playerPed = PlayerPedId()
    local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
        QBCore.Functions.Notify('¡Estás conociendo a alguien!', 'success')
        Citizen.Wait(30000)
        ClearPedTasks(playerPed)
    else
        QBCore.Functions.Notify('No hay nadie cerca para conocer', 'error')
    end
end)

RegisterCommand('verids', function()
    showPlayerIDs = true
    QBCore.Functions.Notify('Ahora puedes ver los IDs de los jugadores.', 'success')
end)

-- Comando para ocultar los IDs
RegisterCommand('ocultarids', function()
    showPlayerIDs = false
    QBCore.Functions.Notify('Has ocultado los IDs de los jugadores.', 'success')
end)