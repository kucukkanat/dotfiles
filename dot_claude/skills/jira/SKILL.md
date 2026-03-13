---
name: jira
description: Use the `jira` CLI to search Jira issues or find users. Run the appropriate command based on the user's request.
---

## Commands

**Search issues by JQL:**
```
jira search --jql "<JQL>" [--fields summary,status,assignee,description] [--max-results <n>] [--json]
```

**Find users:**
```
jira search-user <name-or-email>
```

**Save credentials (one-time setup):**
```
jira login --server https://<company>.atlassian.net --token <PAT>
```

## Field options
Common fields: `summary`, `status`, `assignee`, `reporter`, `description`, `priority`, `labels`, `created`, `updated`

## JQL examples
- `project = MYPROJECT AND status = "In Progress"`
- `assignee = currentUser() AND status != Done ORDER BY updated DESC`
- `text ~ "authentication bug" AND created >= -7d`
- `sprint in openSprints() AND assignee = currentUser()`

## Instructions
1. Parse the user's request from: $ARGUMENTS
2. Determine whether this is a search, user lookup, or setup request
3. Construct the appropriate jira command and run it using Bash
4. Present the results clearly
5. If credentials are missing, tell the user to run `jira login --server <url> --token <PAT>`
