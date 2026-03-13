---
name: d2lang
description: Creates diagrams using D2 declarative diagramming language. Use when the user needs to create visual diagrams from text descriptions, flowcharts, architecture diagrams, or any kind of visual representation. Checks for d2 installation and prompts user to install if needed.
allowed-tools: Bash(d2:*)
---

# D2 Diagram Creation

D2 is a declarative diagramming language that turns text into diagrams. Create beautiful diagrams in minutes with simple syntax.

**Important:** All diagram files (both `.d2` source files and `.svg` rendered files) must be created in the `./docs/diagrams/` directory to avoid cluttering the repository with diagram artifacts.

## Installation

First, check if d2 is installed on the system. If not, prompt the user to install it.

### Check installation

```bash
d2 version
```

If d2 is not installed, guide the user to install it using the recommended method:

```bash
curl -fsSL https://d2lang.com/install.sh | sh -s --
```

After installation, verify:

```bash
d2 version
```

### Alternative installation methods

**macOS (Homebrew):**
```bash
brew install d2
```

**Linux (various):**
Visit https://github.com/terrastruct/d2/blob/master/docs/INSTALL.md for detailed instructions.

**Windows (Winget):**
```bash
winget install d2lang.d2
```

**Download binaries:**
Precompiled binaries are available at: https://github.com/terrastruct/d2/releases

## D2 Syntax Basics

### Shapes

Shapes are the building blocks of diagrams. Declare them by name:

```d2
shape1
shape2
my-database
api-server
```

Multiple shapes on one line (using semicolons):
```d2
shape1; shape2; shape3
```

Custom labels:
```d2
shape1: My Custom Label
```

Shape types:
```d2
circle-shape: Circle {
  shape: circle
}
database-shape: Database {
  shape: cylinder
}
cloud-shape: Cloud {
  shape: cloud
}
```

Available shapes:
- `rectangle` (default)
- `square`
- `circle`
- `oval`
- `diamond`
- `hexagon`
- `parallelogram`
- `cylinder`
- `queue`
- `document`
- `package`
- `step`
- `callout`
- `stored_data`
- `person` (C4 model)
- `cloud`

### Connections

Define relationships between shapes:

```d2
shape1 -> shape2
shape3 -> shape4: connection label
shape1 -- shape2: no arrow
```

Connection operators:
- `->` arrow
- `<-` reverse arrow
- `<->` bidirectional arrow
- `--` line without arrow

Connection chaining:
```d2
a -> b -> c -> d
```

### Containers

Group related shapes:

```d2
container: Backend {
  database: PostgreSQL {
    shape: cylinder
  }
  api: API Server
}
```

Nested containers:
```d2
app: Application {
  backend: Backend Services {
    api: API
    auth: Auth
  }
  frontend: Frontend {
    ui: User Interface
  }
}
```

### Styles and Attributes

Set attributes on shapes:

```d2
important-shape: Critical {
  style: {
    fill: "#ff6b6b"
    stroke: "#c92a2a"
    stroke-width: 2
  }
}

database: Production DB {
  shape: cylinder
  icon: "https://icons.iconarchive.com/icons/paomedia/small-n-flat/1024/database-2-icon.png"
}
```

Common style attributes:
- `fill`: background color
- `stroke`: border color
- `stroke-width`: border thickness
- `stroke-dash`: dashed pattern (array of numbers)
- `font-size`: text size
- `font-color`: text color
- `opacity`: transparency (0-1)
- `multiple`: true/false for multiple connections between same shapes

### Arrowheads

Customize connection arrows:

```d2
a -> b {
  source-arrowhead: {
    label: "start"
  }
  target-arrowhead: {
    shape: diamond
    label: "end"
    style: {
      fill: true
    }
  }
}
```

Arrowhead shapes:
- `triangle` (default)
- `arrow`
- `diamond`
- `circle`
- `box`
- `cf-one`, `cf-one-required`
- `cf-many`, `cf-many-required`
- `cross`

## Workflow

### Step 1: Ensure diagram directory exists

Always ensure the `./docs/diagrams` directory exists before creating diagram files:

```bash
mkdir -p ./docs/diagrams
```

### Step 2: Check for d2 installation

Always check if d2 is installed before proceeding:

```bash
d2 version
```

If not installed, prompt the user:
```
d2 is not installed on your system. Would you like to install it now?
Run: curl -fsSL https://d2lang.com/install.sh | sh -s --
```

### Step 3: Create the .d2 file

Create a .d2 file in `./docs/diagrams/` with appropriate name (e.g., `architecture.d2`, `flowchart.d2`) based on what the diagram represents.

**Important:** Always use the `./docs/diagrams/` directory to avoid littering the repository with diagram files.

Use the Write tool to create the file with D2 syntax at path like `./docs/diagrams/diagram-name.d2`.

### Step 4: Render to SVG

Render the diagram to SVG format in the same directory:

```bash
d2 ./docs/diagrams/diagram-name.d2 ./docs/diagrams/diagram-name.svg
```

Both `.d2` source files and `.svg` rendered files should be in `./docs/diagrams/`.

### Step 5: Watch mode (optional)

For iterative editing, use watch mode:

```bash
d2 -w ./docs/diagrams/diagram-name.d2 ./docs/diagrams/diagram-name.svg
```

This will automatically re-render when the input file changes.

## Examples

### Simple Flowchart

```d2
start: Start {
  shape: circle
}
process: Process Data
decision: Decision {
  shape: diamond
}
end: End {
  shape: circle
}

start -> process -> decision -> end
decision -> process: Retry
```

### Architecture Diagram

```d2
user: User {
  shape: person
  icon: https://d2lang.com/img/logo.png
}

web-app: Web Application

backend: Backend Services {
  api: API Gateway
  auth: Auth Service
  database: Database {
    shape: cylinder
  }
}

cache: Redis Cache {
  shape: cylinder
}

user -> web-app
web-app -> api
api -> auth
api -> database
api -> cache
```

### Sequence Diagram

```d2
sequence-diagram: Sequence {
  shape: sequence_diagram
  
  user: User
  server: Server
  database: Database {
    shape: cylinder
  }
  
  user -> server: Request
  server -> database: Query
  database -> server: Result
  server -> user: Response
}
```

## Themes

Apply predefined themes for professional styling:

```bash
d2 -t theme-neutral ./docs/diagrams/diagram-name.d2 ./docs/diagrams/diagram-name.svg
d2 -t theme-flagr ./docs/diagrams/diagram-name.d2 ./docs/diagrams/diagram-name.svg
```

Available themes:
- `theme-neutral`
- `theme-neutral-grey`
- `theme-terminal`
- `theme-terminal-dark`
- `theme-flagr`
- `theme-dark-mono`
- `theme-gummy`
- `theme-original`
- `theme-club-house`

## Export Formats

Export to different formats (always use `./docs/diagrams/` directory):

```bash
# SVG (default)
d2 ./docs/diagrams/diagram-name.d2 ./docs/diagrams/diagram-name.svg

# PNG
d2 ./docs/diagrams/diagram-name.d2 ./docs/diagrams/diagram-name.png

# PDF
d2 ./docs/diagrams/diagram-name.d2 ./docs/diagrams/diagram-name.pdf
```

## Tips

1. Always create diagram files in `./docs/diagrams/` directory to keep the repository clean
2. Both `.d2` source files and `.svg` (or other format) rendered files should be in the same directory
3. Use descriptive shape names (keys) for better readability
4. Keep connection labels short for better layout
5. Use containers to logically group related elements
6. Themes make diagrams look professional instantly
7. The online playground is great for testing: https://play.d2lang.com
8. Use watch mode (`-w`) for rapid iteration during development

## Learning Resources

- Official documentation: https://d2lang.com/tour/
- Cheat sheet: https://d2lang.com/tour/cheat-sheet/
- Playground: https://play.d2lang.com
- Examples: https://d2lang.com/examples/overview/
