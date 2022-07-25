# Conventional Commits Git Hook

This tool helps you follow the [Conventional Commits](https://www.conventionalcommits.org) conventional by installing a configurable `commit-msg` into your Git projects.

### Installing

* clone this repository
* In this repository folder, execute `make install`
* done! 🎉 


### Uninstalling

* In this repository folder, execute `make uninstall`

## Usage 


**Supported types:**

```json
["docs", "feat", "fix", "perf", "refactor", "style", "test", "chore", "build", "ci", "revert", "dataset"]
```

**Note**: you can disable this hook per commit by using `--no-verify`. Which is not recommended.

## IDE Plugins

- [JetBrains Conventional Commit](https://plugins.jetbrains.com/plugin/13389-conventional-commit)
- [VS Code Conventional Commit](https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits)
