# PX Notifications

A modern, clean notification system for FiveM servers with smooth animations and easy integration. EchoRP Inspired

![PX Notifications Preview](https://media.discordapp.net/attachments/1323053449402777762/1407410109944168608/image.png?ex=68a6004e&is=68a4aece&hm=d88d24a35fc5e702add66bf19f59b33c3e82b6112c2029942e3939e426c314b2&=)

## Features

- **Clean Design**: Dark background with white text and colored accent lines
- **Multiple Types**: Info (yellow), Success (green), Warning (yellow), Error (red)
- **Smooth Animations**: Slide-in and slide-out animations with pop effects
- **Auto-dismiss**: Notifications automatically disappear after a set duration
- **Responsive**: Works on different screen sizes
- **Easy Integration**: Simple API for other resources to use
- **Font Awesome Icons**: Support for custom icons

## Installation

1. Place this resource in your server's resources folder
2. Add `ensure px-notifications` to your server.cfg
3. Restart your server

## Configuration

The `config.lua` file allows you to enable debug mode for testing:

```lua
Config = {}

-- Debug Settings
Config.Debug = {
    enabled = false      -- Enable debug mode for test commands
}
```

## Usage

### From Client Scripts

```lua
-- Basic notification
exports['px-notifications']:ShowNotification('Your message here')

-- With custom type and duration
exports['px-notifications']:ShowNotification('Operation completed!', 'success', 4000)
```

### Available Types

- `'info'` - Yellow accent (default)
- `'success'` - Green accent
- `'warning'` - Yellow accent
- `'error'` - Red accent

### Duration

Duration is specified in milliseconds. Default is 5000ms (5 seconds).

### Testing Commands

The resource includes several test commands (only work when debug mode is enabled):

- `/px-test-info` - Shows an info notification
- `/px-test-success` - Shows a success notification
- `/px-test-warning` - Shows a warning notification
- `/px-test-error` - Shows an error notification
- `/px-test-walkie` - Shows "Cancelling Walkie Talkie" notification
- `/px-test-seatbelt` - Shows seat belt notifications
- `/show-nui` - Shows the NUI frame (for development)

**Note**: Test commands only work when `Config.Debug.enabled = true` in `config.lua`

## API Reference

### ShowNotification(message, type, duration)

**Parameters:**
- `message` (string) - The notification text to display
- `type` (string, optional) - Notification type: 'info', 'success', 'warning', 'error'
- `duration` (number, optional) - Duration in milliseconds (default: 5000)

**Example:**
```lua
-- Basic usage
exports['px-notifications']:ShowNotification('Player joined the server')

-- Advanced usage
exports['px-notifications']:ShowNotification('Vehicle repaired successfully!', 'success', 3000)
```

## Customization

You can customize the notification appearance by modifying the CSS in `web/src/components/App.css`:

- **Colors**: Modify the `::before` pseudo-element background-color for different types
- **Position**: Change the `top` and `left` values in `.notification-container`
- **Size**: Adjust `max-width`, `min-width`, and `padding` in `.notification-item`
- **Font**: Modify font-size and font-family in `.notification-message`
- **Animations**: Modify the keyframe animations for slide-in and slide-out effects

## Integration Examples

### Server-Side Functions

```lua
-- Send to specific player
exports['px-notifications']:SendNotificationToPlayer(playerId, message, notificationType, duration, icon)

-- Send to all players
exports['px-notifications']:SendNotificationToAll(message, notificationType, duration, icon)

-- Send to players within radius
exports['px-notifications']:SendNotificationToRadius(sourcePlayer, radius, message, notificationType, duration, icon)
```

### ESX Integration
```lua
-- In your ESX resource
ESX.ShowNotification = function(message, notificationType, duration)
    exports['px-notifications']:ShowNotification(message, notificationType, duration)
end
```

### QBCore Integration

Replace the `QBCore.Functions.Notify` function in `qb-core/client/functions.lua` with this:

```lua
function QBCore.Functions.Notify(text, texttype, length, icon)
    local typeMap = {
        primary = 'info',
        success = 'success',
        error = 'error',
        warning = 'warning'
    }
    local pxType = typeMap[texttype] or 'info'
    local message = text
    
    if type(text) == 'table' then
        message = text.text or text.caption or 'Placeholder'
    end
    exports['px-notifications']:ShowNotification(message, pxType, length, icon)
end
```

### Qbox Integration Not tested yet [W.I.P]

```lua
function functions.Notify(message, source, text, notifyType, duration, subTitle, notifyPosition, notifyStyle, notifyIcon, notifyIconColor)
    exports['px-notifications']:ShowNotification(message, text, notifyType, duration, subTitle or nil, notifyPosition or nil, notifyStyle or nil, notifyIcon or nil, notifyIconColor or nil, source)
end
```
---

## 📌 Contributing

We welcome contributions from the community! 🎉

* Found a bug? Open an issue
* Have an idea? Submit a pull request
* Want to improve the design? Share your suggestions

Every contribution helps make **PX Notifications** better for everyone 🚀

---

## 🌍 Community & Support

Need help or want to showcase your custom setup?

* Join our Discord *([PX Scripts](https://discord.gg/EvnYVr4S7Y))*
* Open an issue on GitHub
* Share screenshots of how you use PX Notifications in your server!

We’d love to see what the community builds with it 💙

---

## 📜 License

PX Notifications is released under the **MIT License** – free to use, modify, and share. Please give credit to **PX Scripts** when redistributing 🙏

