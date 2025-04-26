# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test databricks-cli https://github.com/herberton/asdf-databricks-cli.git "databricks --version"
```

Tests are automatically run in GitHub Actions on push and PR.
