import React, { useState, useEffect } from "react";
import "./App.css";
import { debugData } from "../utils/debugData";
import { fetchNui } from "../utils/fetchNui";



// This will set the NUI to visible if we are
// developing in browser
debugData([
  {
    action: "setVisible",
    data: true,
  },
]);

interface Notification {
  id: string;
  message: string;
  type?: 'info' | 'success' | 'warning' | 'error';
  duration?: number;
  icon?: string;
}

interface NotificationProps {
  notification: Notification;
  onRemove: (id: string) => void;
}

const NotificationItem: React.FC<NotificationProps> = ({ notification, onRemove }) => {
  const [isRemoving, setIsRemoving] = useState(false);

  useEffect(() => {
    if (notification.duration && notification.duration > 0) {
      const timer = setTimeout(() => {
        setIsRemoving(true);
        setTimeout(() => {
          onRemove(notification.id);
        }, 300); // Wait for animation to complete
      }, notification.duration);
      
      return () => clearTimeout(timer);
    }
  }, [notification.id, notification.duration, onRemove]);

  const handleRemove = () => {
    setIsRemoving(true);
    setTimeout(() => {
      onRemove(notification.id);
    }, 300); // Wait for animation to complete
  };

  return (
    <div className={`notification-item ${notification.type || 'info'} ${isRemoving ? 'slide-out' : ''}`}>
      <div className="notification-content">
        {notification.icon && (
          <i className={`notification-icon ${notification.icon}`}></i>
        )}
        <span className="notification-message">{notification.message}</span>
      </div>
    </div>
  );
};

const App: React.FC = () => {
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [isVisible, setIsVisible] = useState(false);

  // Listen for notification events from the game
  useEffect(() => {
    const handleNotification = (event: MessageEvent) => {
      const { action, data } = event.data;
      
      if (action === 'setVisible') {
        setIsVisible(data);
      }
      
      if (action === 'showNotification') {
        const newNotification: Notification = {
          id: Date.now().toString(),
          message: data.message,
          type: data.type || 'info',
          duration: data.duration || 5000,
          icon: data.icon || undefined,
        };
        
        setNotifications(prev => [...prev, newNotification]);
        setIsVisible(true);
      }
    };

    window.addEventListener('message', handleNotification);

    return () => window.removeEventListener('message', handleNotification);
  }, []);

  const removeNotification = (id: string) => {
    setNotifications(prev => prev.filter(notification => notification.id !== id));
  };

  return (
    <div className="notification-container" style={{ display: isVisible ? 'block' : 'none' }}>
      {notifications.map((notification) => (
        <NotificationItem
          key={notification.id}
          notification={notification}
          onRemove={removeNotification}
        />
      ))}
    </div>
  );
};

export default App;
