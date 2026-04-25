## Installation

Install chezmoi and apply these dotfiles:

```sh
curl -fs "https://raw.githubusercontent.com/choco14t/dotfiles/master/install.sh" | bash
```

## Usage

```sh
make init
make diff
make deploy
```

`make deploy` is an alias for `chezmoi apply --source .`.
