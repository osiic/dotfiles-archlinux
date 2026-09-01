# Graph Report - dotfiles  (2026-09-01)

## Corpus Check
- Large corpus: 402 files · ~15,628,923 words. Semantic extraction will be expensive (many Claude tokens). Consider running on a subfolder.

## Summary
- 97 nodes · 98 edges · 29 communities (9 shown, 3 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Community 0
- Community 1
- Community 2
- Community 3
- Community 4
- Community 5
- Community 6
- Community 7
- Community 8
- Community 11
- Community 12
- Community 13

## God Nodes (most connected - your core abstractions)
1. `evaluate()` - 8 edges
2. `workspace.library` - 5 edges
3. `containsMathFunctions()` - 4 edges
4. `Lua` - 4 edges
5. `setup.sh script` - 3 edges
6. `install_cli_tools()` - 3 edges
7. `_replaceDegreeFunc()` - 3 edges
8. `preprocessExpression()` - 3 edges
9. `validateMathExpression()` - 3 edges
10. `evaluateInteger()` - 3 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (29 total, 3 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.12
Nodes (17): globals, hint.enable, Lua, diagnostics, runtime, workspace, path, runtime.version (+9 more)

### Community 1 - "Community 1"
Cohesion: 0.29
Nodes (13): containsMathFunctions(), evaluate(), evaluateInteger(), evaluatePrecise(), evaluateWithExponentiation(), _findMatchingParen(), _getMathNamesRegex(), isIntegerOnly() (+5 more)

### Community 2 - "Community 2"
Cohesion: 0.15
Nodes (9): Calculator, code, fs, path, Calculator, rejectTests, tests, Calculator (+1 more)

### Community 3 - "Community 3"
Cohesion: 0.70
Nodes (4): backup_and_link(), install_cli_tools(), run_sudo(), setup.sh script

### Community 4 - "Community 4"
Cohesion: 0.70
Nodes (4): backup_and_link(), install_packages(), run_sudo(), setup.sh script

### Community 5 - "Community 5"
Cohesion: 0.70
Nodes (4): backup_and_link(), install_packages(), run_sudo(), setup.sh script

### Community 6 - "Community 6"
Cohesion: 0.83
Nodes (3): install_packages(), run_sudo(), setup.sh script

### Community 7 - "Community 7"
Cohesion: 0.83
Nodes (3): install_packages(), run_sudo(), setup.sh script

### Community 8 - "Community 8"
Cohesion: 0.83
Nodes (3): install_packages(), run_sudo(), setup.sh script

## Knowledge Gaps
- **21 isolated node(s):** `fs`, `path`, `code`, `Calculator`, `Calculator` (+16 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 44 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What connects `fs`, `path`, `code` to the rest of the system?**
  _21 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.12418300653594772 - nodes in this community are weakly interconnected._