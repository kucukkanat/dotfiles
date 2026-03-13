---
name: confluence
description: Use the `confluence` CLI to search Confluence pages or retrieve page content. Run the appropriate command based on the user's request.
---

## Commands

**Search pages using CQL:**
```
confluence search "<CQL>" [--json]
```

**Get a page by ID:**
```
confluence page <id> [--json]
```

**Save credentials (one-time setup):**
```
confluence login --server https://<company>.atlassian.net/wiki --token <PAT>
```

## CQL examples
- `title ~ "Meeting Notes"`
- `space = "ENG" AND title ~ "Architecture"`
- `text ~ "deployment" AND space = "OPS" ORDER BY lastmodified DESC`
- `type = page AND ancestor = 12345`
- `creator = currentUser() AND created >= "2026-01-01"`

## Instructions
1. Parse the user's request from: $ARGUMENTS
2. Determine whether this is a search, page retrieval, or setup request
3. Construct the appropriate confluence command and run it using Bash
4. Present the results clearly — for page content, summarize or quote the relevant sections
5. If credentials are missing, tell the user to run `confluence login --server <url> --token <PAT>`
6. If the user wants to follow up on a search result, use the page ID to fetch full content
