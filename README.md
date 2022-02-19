# Conventional Commits Git Hook

This tool helps you follow the [Conventional Commits](https://www.conventionalcommits.org) conventional by installing a configurable `commit-msg` into your Git projects.

### Prerequisites

You must have [jq](https://stedolan.github.io/jq/download/) installed.

### Installing

```sh
curl -o- https://raw.githubusercontent.com/tapsellorg/conventional-commits-git-hook/master/scripts/install.sh | bash
```

### Uninstalling

Remove the `commit-msg` Git hook from your project:

```sh
rm <your-project>/.git/hooks/commit-msg
```

## Usage <a name = "usage"></a>

Once installed, you must run `git init` in your Git projects to (re)initialize your repository.

**Supported types:**

```json
["build", "ci", "docs", "feat", "fix", "perf", "refactor", "style", "test", "chore"]
```

**Note**: you can disable this hook per commit by using `--no-verify`. Which is not recommended.
