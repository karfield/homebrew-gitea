# Gitea: Homebrew

[![Join the chat at https://img.shields.io/discord/322538954119184384.svg](https://img.shields.io/discord/322538954119184384.svg)](https://discord.gg/NsatcWJ)

Homebrew repository to install Gitea on macOS.

## Prepare

```bash
brew tap gitea/tap https://gitea.com/gitea/homebrew-gitea
```

## Install

### gitea

```bash
brew install gitea
gitea -h
```

## Upgrade

In case you installed Gitea before v1.8.3, you still might have the old tap. In that case, you need to remove it and add the new tap via

```bash
brew untap go-gitea/gitea
brew tap gitea/tap https://gitea.com/gitea/homebrew-gitea
```

Once you updated the tap, you can upgrade via

```bash
brew upgrade gitea
```


## Contributing

Fork -> Patch -> Push -> Pull Request

## Authors

* [Maintainers](https://gitea.com/org/gitea/members)
* [Contributors](https://github.com/go-gitea/gitea/graphs/contributors)

## License

This project is under the MIT License. See the [LICENSE](LICENSE) file for the
full license text.

## Copyright

```
Copyright (c) 2016 The Gitea Authors <https://gitea.io>
```
