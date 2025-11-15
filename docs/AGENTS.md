# Agent Instructions

Quick reference guide for agents to build, test, run, and verify iOS apps.

**For architecture details**: See [ARCHITECTURE.md](./ARCHITECTURE.md) for MVVM-C patterns, dependency injection, and project structure.

**Note**: All paths are relative to the workspace root. If running from a different directory, use absolute paths. All commands shown are MCP (Model Context Protocol) tool calls.

**⚠️ IMPORTANT: Do NOT use `xcodebuild` directly.** Always use the MCP tool calls provided (e.g., `build_run_sim()`, `test_sim()`, `build_sim()`) instead of running `xcodebuild` commands via terminal.

## Project-Specific Configuration

Each project should have its own build/test configuration. Check the project's `.cursor/rules/build-test.mdc` file for project-specific details such as:
- Project name and scheme
- Bundle identifier
- Project path
- Simulator UUID

## Quick Commands

### Run App (Build + Install + Launch)

```
build_run_sim({
  projectPath: "ProjectName/ProjectName.xcodeproj",
  scheme: "ProjectScheme",
  simulatorId: "SIMULATOR_UUID"
})
open_sim()  // Ensure simulator window is visible and active on Mac
```

### Build Only

```
build_sim({
  projectPath: "ProjectName/ProjectName.xcodeproj",
  scheme: "ProjectScheme",
  simulatorId: "SIMULATOR_UUID"
})
```

### Run Unit Tests

```
// Run all unit tests
test_sim({
  projectPath: "ProjectName/ProjectName.xcodeproj",
  scheme: "ProjectScheme",
  simulatorId: "SIMULATOR_UUID",
  extraArgs: ["-only-testing:ProjectTests"]
})

// Run specific test class
test_sim({
  projectPath: "ProjectName/ProjectName.xcodeproj",
  scheme: "ProjectScheme",
  simulatorId: "SIMULATOR_UUID",
  extraArgs: ["-only-testing:ProjectTests/TestClassName"]
})

// Run specific test method
test_sim({
  projectPath: "ProjectName/ProjectName.xcodeproj",
  scheme: "ProjectScheme",
  simulatorId: "SIMULATOR_UUID",
  extraArgs: ["-only-testing:ProjectTests/TestClassName/testMethodName"]
})
```

### Run UI Tests

```
// Run all UI tests
test_sim({
  projectPath: "ProjectName/ProjectName.xcodeproj",
  scheme: "ProjectScheme",
  simulatorId: "SIMULATOR_UUID",
  extraArgs: ["-only-testing:ProjectUITests"]
})

// Run specific UI test class
test_sim({
  projectPath: "ProjectName/ProjectName.xcodeproj",
  scheme: "ProjectScheme",
  simulatorId: "SIMULATOR_UUID",
  extraArgs: ["-only-testing:ProjectUITests/TestClassName"]
})
```

### Verify Functionality

**For detailed verification workflow and UI checklist, see `@qa_verify.md`**

Quick verification:
1. `build_run_sim()` - Build, install, and launch app
2. `describe_ui()` - Verify UI elements programmatically
3. Navigate and test functionality

Use `@qa_verify.md` command for comprehensive verification with UI checklist and test case planning.

**Avoid redundant calls:**

- ❌ `xcodebuild` - Use MCP tools (`build_run_sim()`, `test_sim()`, etc.) instead
- ❌ `list_sims()` - Use project-specific simulator UUID from `.cursor/rules/build-test.mdc`
- ❌ `get_app_bundle_id()` - Use known bundle identifier from project configuration
- ❌ `list_schemes()` - Use known scheme name from project configuration
- ❌ `get_sim_app_path()` - Use `build_run_sim()` instead

## Cleanup Commands

### Stop App

```
stop_app_sim({
  simulatorUuid: "SIMULATOR_UUID",
  bundleId: "com.example.BundleID"
})
```

### Clean Build

```
clean({
  projectPath: "ProjectName/ProjectName.xcodeproj",
  scheme: "ProjectScheme",
  platform: "iOS Simulator"
})
```

## Notes

- **Never use `xcodebuild` directly** - Always use MCP tool calls (`build_run_sim()`, `test_sim()`, `build_sim()`, etc.)
- Use project-specific configuration from `.cursor/rules/build-test.mdc` for each project
- **Verification**: Use `@qa_verify.md` command for comprehensive verification workflow and UI checklist
- **Parameter Names**: Build/test commands use `simulatorId`, while UI inspection commands (`describe_ui`, `screenshot`, `start_sim_log_cap`) use `simulatorUuid` - both accept the same UUID value.
