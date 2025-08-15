-- PX Notifications Client Side
-- Client-side functions for the notification system



local function toggleNuiFrame(shouldShow)
  SetNuiFocus(shouldShow, shouldShow)
  SendReactMessage('setVisible', shouldShow)
end

-- Function to show notifications (client-side)
function ShowNotification(message, notificationType, duration, icon)
  notificationType = notificationType or 'info'
  duration = duration or 5000
  icon = icon or nil
  
  if Config and Config.Debug and Config.Debug.enabled then
    print('^2[PX Notifications]^0 Showing notification: ' .. message .. ' (Type: ' .. notificationType .. ', Duration: ' .. duration .. ')')
  end
  
  -- Make NUI visible
  SendReactMessage('setVisible', true)
  
  SendReactMessage('showNotification', {
    message = message,
    type = notificationType,
    duration = duration,
    icon = icon
  })
end

-- Export the function for other resources to use
exports('ShowNotification', ShowNotification)



-- Listen for server-side notifications
RegisterNetEvent('px-notifications:showNotification')
AddEventHandler('px-notifications:showNotification', function(data)
  ShowNotification(data.message, data.type, data.duration, data.icon)
end)

-- Command to show NUI frame (for development)
RegisterCommand('show-nui', function()
  if Config.Debug.enabled then
    toggleNuiFrame(true)
    debugPrint('Show NUI frame')
  end
end)

-- Test commands for different notification types (development only)
RegisterCommand('px-test-info', function()
  if Config.Debug.enabled then
    ShowNotification('This is an info notification', 'info', 3000, 'fas fa-info-circle')
  end
end)

RegisterCommand('px-test-success', function()
  if Config.Debug.enabled then
    ShowNotification('This is a success notification', 'success', 3000, 'fas fa-check-circle')
  end
end)

RegisterCommand('px-test-warning', function()
  if Config.Debug.enabled then
    ShowNotification('This is a warning notification', 'warning', 3000, 'fas fa-exclamation-triangle')
  end
end)

RegisterCommand('px-test-error', function()
  if Config.Debug.enabled then
    ShowNotification('This is an error notification', 'error', 3000, 'fas fa-times-circle')
  end
end)

-- Test command for walkie talkie notification (like in the image)
RegisterCommand('px-test-walkie', function()
  if Config.Debug.enabled then
    ShowNotification('Cancelling Walkie Talkie', 'info', 3000, 'fas fa-microphone-slash')
  end
end)

-- Test command for seat belt notifications
RegisterCommand('px-test-seatbelt', function()
  if Config.Debug.enabled then
    ShowNotification('Seat Belt Enabled', 'success', 0, 'fas fa-shield-alt')
    Wait(1000)
    ShowNotification('Seat Belt Disabled', 'warning', 0, 'fas fa-exclamation-triangle')
  end
end)

RegisterNUICallback('hideFrame', function(_, cb)
  toggleNuiFrame(false)
  debugPrint('Hide NUI frame')
  cb({})
end)

RegisterNUICallback('getClientData', function(data, cb)
  debugPrint('Data sent by React', json.encode(data))

-- Lets send back client coords to the React frame for use
  local curCoords = GetEntityCoords(PlayerPedId())

  local retData <const> = { x = curCoords.x, y = curCoords.y, z = curCoords.z }
  cb(retData)
end)

