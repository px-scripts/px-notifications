-- PX Notifications Server Side
-- Server-side functions for sending notifications to players

-- Function to send notification to a specific player
function SendNotificationToPlayer(playerId, message, notificationType, duration, icon)
    if not playerId or not message then return false end
    
    notificationType = notificationType or 'info'
    duration = duration or 5000
    icon = icon or nil
    
    TriggerClientEvent('px-notifications:showNotification', playerId, {
        message = message,
        type = notificationType,
        duration = duration,
        icon = icon
    })
    
    return true
end

-- Function to send notification to all players
function SendNotificationToAll(message, notificationType, duration, icon)
    if not message then return false end
    
    notificationType = notificationType or 'info'
    duration = duration or 5000
    icon = icon or nil
    
    TriggerClientEvent('px-notifications:showNotification', -1, {
        message = message,
        type = notificationType,
        duration = duration,
        icon = icon
    })
    
    return true
end

-- Function to send notification to players within a radius
function SendNotificationToRadius(sourcePlayer, radius, message, notificationType, duration, icon)
    if not sourcePlayer or not radius or not message then return false end
    
    notificationType = notificationType or 'info'
    duration = duration or 5000
    icon = icon or nil
    
    local sourceCoords = GetEntityCoords(GetPlayerPed(sourcePlayer))
    
    for _, playerId in ipairs(GetPlayers()) do
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(sourceCoords - playerCoords)
        
        if distance <= radius then
            TriggerClientEvent('px-notifications:showNotification', playerId, {
                message = message,
                type = notificationType,
                duration = duration,
                icon = icon
            })
        end
    end
    
    return true
end

-- Export the functions for other resources to use
exports('SendNotificationToPlayer', SendNotificationToPlayer)
exports('SendNotificationToAll', SendNotificationToAll)
exports('SendNotificationToRadius', SendNotificationToRadius)


