<div align="center">

# asdf-databricks-cli [![Build](https://github.com/herberton/asdf-databricks-cli/actions/workflows/build.yml/badge.svg)](https://github.com/herberton/asdf-databricks-cli/actions/workflows/build.yml) [![Lint](https://github.com/herberton/asdf-databricks-cli/actions/workflows/lint.yml/badge.svg)](https://github.com/herberton/asdf-databricks-cli/actions/workflows/lint.yml)

[databricks-cli](https://docs.databricks.com/aws/en/dev-tools/cli) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add databricks-cli
# or
asdf plugin add databricks-cli https://github.com/herberton/asdf-databricks-cli.git
```

databricks-cli:

```shell
# Show all installable versions
asdf list-all databricks-cli

# Install specific version
asdf install databricks-cli latest

# Set a version globally (on your ~/.tool-versions file)
asdf global databricks-cli latest

# Now databricks-cli commands are available
databricks --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/herberton/asdf-databricks-cli/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Herberton Candido Souza](https://github.com/herberton/)
