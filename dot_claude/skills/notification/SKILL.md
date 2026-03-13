---
name: notification
description: Send native system notifications with optional ntfy.sh phone notifications. Use when the user wants to receive notifications for task completion, status updates, or important events.
updated: 2026-03-13
---

# Notification Skill

## Core Philosophy

The notification skill provides a simple, dependency-free way to send native system notifications with optional phone notifications via ntfy.sh. It works seamlessly with both opencode and claude code.

## Features

- **Native system notifications**: Uses platform-specific APIs without external dependencies
- **Phone notifications**: Optional ntfy.sh integration when configured
- **Environment-based configuration**: Simple environment variable controls
- **TypeScript + Bun**: Written for Bun runtime with full type safety

## Environment Variables

### Required for Phone Notifications
- `NTFY_SH_CHANNEL`: Your ntfy.sh topic name (e.g., `my-username-notifications`)
  - If unset, system notification still works with a warning

### Optional for Phone Notifications
- `NTFY_SH_ENABLE`: Enable/disable phone notifications
  - Set to `1`, `true`, or `yes` to enable
  - If unset or set to any other value, phone notifications are disabled
  - This allows you to have the channel configured but choose when to use it

## Usage

### Basic Notification (System Only)

```typescript
import { sendNotification } from "./notification.ts";

sendNotification("Hello World!", "Basic notification");
```

### With Title

```typescript
sendNotification("Task completed successfully!", "Build Complete");
```

### With Phone Notification

Ensure environment variables are set:
```bash
export NTFY_SH_CHANNEL="kucukkanat-notifications"
export NTFY_SH_ENABLE="1"
```

Then:
```typescript
sendNotification("Deployment finished!", "Deploy Success");
```

### Programmatic Control

Check if phone notifications are available:

```typescript
import { sendNotification, canSendToPhone } from "./notification.ts";

if (canSendToPhone()) {
  sendNotification("Sending to both system and phone", "Status");
} else {
  sendNotification("System only - no phone configured", "Warning");
}
```

## When to Use This Skill

Send notifications when:

1. **Long-running operations complete**
   - Builds finishing
   - Database migrations
   - Large file downloads
   - Data processing jobs

2. **Task completion**
   - After completing multiple tasks
   - Complex workflows finishing
   - Automated test results

3. **Important status changes**
   - Deployment success/failure
   - Server status alerts
   - Critical errors

4. **Scheduled operations**
   - Cron job results
   - Backup completion
   - Maintenance windows

## Integration Patterns

### Pattern 1: After Multi-Step Tasks

```typescript
// Perform tasks...
await buildProject();
await runTests();
await createPR();

// Notify completion
sendNotification(
  "Bug fixed: Login timeout issue\nTests: 47/47 passed\nPR: #123",
  "Development Cycle Complete"
);
```

### Pattern 2: With Error Handling

```typescript
try {
  await deploy();
  sendNotification("Version v1.2.3 deployed successfully", "Deploy Success");
} catch (error) {
  sendNotification(`Deployment failed: ${error.message}`, "Deploy Failed");
}
```

### Pattern 3: Conditional Phone Notifications

```typescript
// Enable phone notifications temporarily for important alerts
const originalEnable = process.env.NTFY_SH_ENABLE;
process.env.NTFY_SH_ENABLE = "1";

sendNotification("Critical production issue detected!", "Urgent Alert");

// Restore original setting
process.env.NTFY_SH_ENABLE = originalEnable;
```

## Technical Implementation

### Platform Support

- **macOS**: Uses `osascript` for native notification center
- **Linux**: Uses `notify-send` (if available) or terminal bell
- **Windows**: Uses `powershell` toast notifications (if available) or terminal bell
- **Fallback**: Console output with terminal bell (works everywhere)

### No Dependencies

The implementation uses:
- Native shell commands for system notifications
- `fetch` API for ntfy.sh (built into Bun)
- No external npm packages

### Error Handling

- System notifications always attempt to send
- Phone notifications silently fail if network unavailable
- Warnings printed when `NTFY_SH_CHANNEL` is unset but phone notifications are enabled

## Environment Setup

### For opencode

Add to your shell profile (~/.zshrc or ~/.bashrc):

```bash
# Notification settings
export NTFY_SH_CHANNEL="your-username-notifications"
export NTFY_SH_ENABLE="1"  # Uncomment to enable phone notifications
```

### For Claude Code

Same environment variables apply. Set them in your development environment or project-specific `.env` file.

## ntfy.sh Setup

1. Choose a unique topic name (include your username to avoid conflicts)
2. Set `NTFY_SH_CHANNEL` to your topic name
3. Visit `https://ntfy.sh/your-topic-name` in browser to subscribe
4. Download ntfy mobile app and subscribe to your topic

## Examples

### Example 1: Build and Test Cycle

```typescript
console.log("Building project...");
await build();

console.log("Running tests...");
const results = await runTests();

if (results.passed) {
  sendNotification(
    `Build: Success\nTests: ${results.total}/${results.total} passed\nDuration: ${results.duration}`,
    "Build & Tests Complete"
  );
} else {
  sendNotification(
    `Build: Success\nTests: ${results.failed} failed\nDuration: ${results.duration}`,
    "Build & Tests Failed"
  );
}
```

### Example 2: Long Data Processing

```typescript
const startTime = Date.now();

console.log("Processing data...");
const results = await processData();

const duration = formatDuration(Date.now() - startTime);

sendNotification(
  `Processed: ${results.count.toLocaleString()} records\nReports: ${results.reports}\nDuration: ${duration}`,
  "Data Processing Complete"
);
```

### Example 3: Multi-Service Deployment

```typescript
const services = await deployAllServices();

const summary = services.map(s => 
  `${s.status === 'success' ? '✅' : '❌'} ${s.name}: ${s.message}`
).join('\n');

sendNotification(summary, `Deployment: ${services.filter(s => s.status === 'success').length}/${services.length} succeeded`);
```

## Best Practices

1. **Descriptive messages**: Include key details (counts, durations, status)
2. **Clear titles**: Use concise, action-oriented titles
3. **Appropriate timing**: Notify after meaningful work, not every small step
4. **Sensitive data**: Never include passwords, tokens, or personal information
5. **Topic naming**: Use unique, descriptive topic names (e.g., `username-project`)

## Troubleshooting

### No system notification appearing
- macOS: Ensure notifications are allowed in System Preferences
- Linux: Install `libnotify-bin` for `notify-send` command
- Fallback: Check console output for notification text

### Phone notification not working
- Verify `NTFY_SH_CHANNEL` is set: `echo $NTFY_SH_CHANNEL`
- Verify `NTFY_SH_ENABLE` is set to enable it
- Test connectivity: `curl -d "test" https://ntfy.sh/$NTFY_SH_CHANNEL`
- Check network connection

### Warning about missing NTFY_SH_CHANNEL
- Expected behavior when phone notifications enabled but channel not configured
- System notification still works
- Set `NTFY_SH_CHANNEL` or disable phone notifications by unsetting `NTFY_SH_ENABLE`

## Success Criteria

- [ ] Notification sent after task completion
- [ ] System notification displayed on desktop
- [ ] Phone notification received when configured
- [ ] Appropriate warnings printed when misconfigured
- [ ] No sensitive data in notifications
- [ ] Messages are clear and actionable
