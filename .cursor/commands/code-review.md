# Strict Code Review

Zero tolerance for substandard code. Review **every line** comprehensively. Reference `@ARCHITECTURE.md` for patterns. Think deep, megathink, ultrathink

## Review Categories

Before flagging any issue, apply this decision rule: **"Would this cause immediate production problems?"**
- **🔴 Critical**: YES - Would break functionality, cause crashes, security vulnerabilities, or data corruption
- **🟡 Warning**: MAYBE - Would create technical debt, reduce maintainability, or increase bug likelihood
- **🟢 Suggestion**: NO - Style preference, minor optimization, or theoretical improvement with limited impact

### 🔴 Critical (Blockers) - Immediate production impact

1. **Bugs & Logic**: Memory leaks, retain cycles, race conditions, force unwraps (`!`) that can fail, force casts (`as!`), bounds errors, edge cases, state corruption, crashes
2. **Architecture**: Violations that break MVVM-C patterns or DI - protocol-based DI, coordinator navigation, service layer patterns (see `@ARCHITECTURE.md`)
3. **SwiftUI/iOS**: Lifecycle (`onAppear`/`onDisappear`), state management (`@State`/`@StateObject`/`@ObservedObject`), task cancellation, coordinator-only navigation, accessibility
4. **Concurrency**: Task cancellation, Combine cancellables, race conditions, main actor isolation, thread safety, @MainActor usage
5. **Security**: Direct exploit paths - keychain for sensitive data, input validation, no hardcoded secrets, secure credential handling, auth bypass, injection vulnerabilities
6. **Performance**: System failure or unacceptable UX - infinite loops, blocking main thread, O(n²) on large datasets, memory leaks

### 🟡 Warning (Should Fix) - Degrades quality but system remains functional

7. **Performance**: Degradation without failure - N+1 queries, inefficient algorithms, missing caching, unnecessary view updates, network optimization
8. **Error Handling**: Error types, propagation, recovery, validation - poor error handling that reduces maintainability
9. **Testing**: Testability, dependency injection, test coverage, mocking support - missing tests that increase bug likelihood
10. **Maintainability**: Coupling, cohesion, abstraction, technical debt, deprecated APIs, code duplication
11. **Security**: Increased attack surface - missing input validation, weak encryption (not direct exploits)
12. **Architecture**: Minor violations that don't break functionality but create technical debt

### 🟢 Suggestion (Nice to Have) - Minor improvements with limited impact

13. **Style** (non-functional): Naming conventions, formatting consistency (only if inconsistent with project standards), file organization, pattern consistency that doesn't cause bugs (e.g., visibility modifiers, code organization)
14. **Documentation**: Missing comments for complex logic (not obvious code), public API docs, clarity
15. **Code Quality**: Minor code smells that don't impact functionality - SOLID principles, DRY violations, long methods >30 lines, large classes >200 lines, >3 params, complexity (<10), magic numbers, dead code
16. **Performance**: Small optimizations for small datasets or theoretical improvements

## Two-Pass Review Process

**PASS 1 - COMPREHENSIVE SCANNING**:
1. Read complete file content looking for issue patterns
2. Mark code matching security, performance, or quality issue patterns
3. Note potential issues WITHOUT detailed verification
4. Complete Pass 1 for ALL files before Pass 2

**Goal**: Build comprehensive issue candidate list across all files

**PASS 2 - THOROUGH VERIFICATION**:
1. For each marked issue, read complete context
2. Verify issue exists in CURRENT code (not assumptions)
3. Confirm severity and impact
4. Verify not already addressed by comments/surrounding code
5. Calculate accurate line numbers from file content
6. Only add to final report if genuine and impactful

**Goal**: Eliminate false positives, ensure all reported issues are valid

**Why Two Passes?**: Prevents analysis fatigue, ensures consistent detection across all files, thorough verification prevents false positives, equal attention to all files.

## Prioritization Guidelines

### Professional Developer Guidelines

- **Trust Expertise**: Assume developers made informed decisions
- **Focus on Impact**: Only flag issues meaningfully affecting security, performance, or maintainability
- **Avoid Micro-Management**: Skip minor style preferences, theoretical optimizations, or "perfect" code that's already functional
- **Respect Context**: Consider business requirements, deadlines, existing patterns
- **Empty Reviews Are Valid**: No issues may be correct for quality code
- **Do Not Force Findings**: Never report issues just to have something to report

### Quality Check Before Flagging

For each potential issue, verify:
- ✅ Does this actually impact functionality, security, or maintainability?
- ✅ Would this cause real production problems or significantly impact maintainability?
- ✅ Is this a genuine problem, not just a style preference?
- ✅ Does the issue exist in CURRENT code (not assumptions or already-fixed code)?

**Remember**: Zero tolerance for Critical issues, but be selective with Warnings and Suggestions. Quality over quantity.

## Guidelines

- Check every line, function, class
- Provide exact locations and code examples
- Reference `@ARCHITECTURE.md` for patterns
- Apply decision rule ("Would this cause immediate production problems?") before flagging issues
- Zero tolerance: Critical = BLOCK merge
- Be selective with Warnings and Suggestions - quality over quantity

## Output Format

For each issue:

```
## [Issue #] 🔴 CRITICAL: [Title]

**Location**: `file.swift`:`LINENUMBERS`
**Category**: [Bug/Architecture/Security/etc]

**Issue**: [Description]
**Impact**: [Why it matters]

**Fix**:
```swift
// Before/after code example
```
```

End with summary:

```
## Review Summary

**Issues**: 🔴 [X] Critical | 🟡 [X] Warning | 🟢 [X] Suggestion
**Assessment**: APPROVED / CONDITIONAL / REJECTED
**Recommendation**: [Clear action]
```
