interface NotificationOptions {
  title?: string;
  priority?: 'default' | 'normal' | 'high' | 'urgent';
  tags?: string[];
}

const NTFY_BASE_URL = 'https://ntfy.sh';

function getPlatform(): string {
  return process.platform;
}

async function sendMacOSNotification(message: string, title: string = 'Notification'): Promise<void> {
  const escapedMessage = message.replace(/\\/g, '\\\\').replace(/"/g, '\\"');
  const escapedTitle = title.replace(/\\/g, '\\\\').replace(/"/g, '\\"');
  
  await Bun.spawn([
    'osascript',
    '-e',
    `display notification "${escapedMessage}" with title "${escapedTitle}"`
  ]).exited;
}

async function sendLinuxNotification(message: string, title: string = 'Notification'): Promise<void> {
  try {
    await Bun.spawn([
      'notify-send',
      title,
      message
    ]).exited;
  } catch {
    console.log(`\x07${title}: ${message}`);
  }
}

async function sendWindowsNotification(message: string, title: string = 'Notification'): Promise<void> {
  try {
    const escapedTitle = title.replace(/'/g, "''");
    const escapedMessage = message.replace(/'/g, "''");
    
    await Bun.spawn([
      'powershell',
      '-Command',
      `[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]::CreateToastNotifier(${process.env.USERDOMAIN ? "'${process.env.USERDOMAIN}\\\\${process.env.USERNAME}'" : "'Bun'"}).Show([Windows.UI.Notifications.ToastNotification]::new(([Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom, ContentType = WindowsRuntime]::new()).LoadXml("<toast><visual><binding template='ToastText02'><text id='1'>${escapedTitle}</text><text id='2'>${escapedMessage}</text></binding></visual></toast>")))`
    ]).exited;
  } catch {
    console.log(`\x07${title}: ${message}`);
  }
}

async function sendGenericNotification(message: string, title: string = 'Notification'): Promise<void> {
  console.log(`\x07${title}: ${message}`);
}

export async function sendSystemNotification(message: string, title: string = 'Notification'): Promise<void> {
  const platform = getPlatform();
  
  switch (platform) {
    case 'darwin':
      await sendMacOSNotification(message, title);
      break;
    case 'linux':
      await sendLinuxNotification(message, title);
      break;
    case 'win32':
      await sendWindowsNotification(message, title);
      break;
    default:
      await sendGenericNotification(message, title);
  }
}

async function sendNtfyNotification(
  message: string,
  title: string = 'Notification',
  options: NotificationOptions = {}
): Promise<boolean> {
  const channel = process.env.NTFY_SH_CHANNEL;
  
  if (!channel) {
    console.warn(`⚠️  NTFY_SH_CHANNEL not set. Phone notification not sent.`);
    console.warn(`   Set NTFY_SH_CHANNEL environment variable to enable phone notifications.`);
    return false;
  }
  
  const url = `${NTFY_BASE_URL}/${channel}`;
  
  const headers: Record<string, string> = {
    'Title': title,
  };
  
  if (options.priority) {
    const priorityMap: Record<string, string> = {
      'default': '3',
      'normal': '3',
      'high': '4',
      'urgent': '5',
    };
    headers['Priority'] = priorityMap[options.priority] || '3';
  }
  
  if (options.tags && options.tags.length > 0) {
    headers['Tags'] = options.tags.join(',');
  }
  
  try {
    const response = await fetch(url, {
      method: 'POST',
      headers,
      body: message,
    });
    
    return response.ok;
  } catch (error) {
    console.warn(`⚠️  Failed to send phone notification: ${error instanceof Error ? error.message : String(error)}`);
    return false;
  }
}

export function canSendToPhone(): boolean {
  const enable = process.env.NTFY_SH_ENABLE;
  if (!enable) return false;
  
  const normalized = enable.toLowerCase().trim();
  return normalized === '1' || normalized === 'true' || normalized === 'yes';
}

export function hasPhoneChannel(): boolean {
  return !!process.env.NTFY_SH_CHANNEL;
}

export async function sendNotification(
  message: string,
  title?: string | NotificationOptions,
  options?: NotificationOptions
): Promise<void> {
  let finalTitle = 'Notification';
  let finalOptions: NotificationOptions = {};
  
  if (typeof title === 'string') {
    finalTitle = title;
    finalOptions = options || {};
  } else if (typeof title === 'object') {
    finalOptions = title;
    finalTitle = title.title || 'Notification';
  } else {
    finalOptions = options || {};
  }
  
  await sendSystemNotification(message, finalTitle);
  
  if (canSendToPhone()) {
    await sendNtfyNotification(message, finalTitle, finalOptions);
  }
}
