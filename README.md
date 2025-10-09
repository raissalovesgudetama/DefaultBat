DefaultBat

> Oh-My-Zsh plugin that makes [bat](https://github.com/sharkdp/bat) a drop-in replacement for `cat`

Automatically uses `bat` for syntax highlighting when viewing files, while preserving standard `cat` behavior for pipes, redirects, and scripts.

## Installation

### Prerequisites

Install [bat](https://github.com/sharkdp/bat) first:

```bash
# macOS
brew install bat

# Ubuntu/Debian
apt install bat

# Other platforms: see https://github.com/sharkdp/bat#installation
```

### Oh-My-Zsh

1. Clone this repo into your custom plugins directory:

```bash
git clone https://github.com/Rational-Idiot/DefaultBat ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/DefaultBat 
```

2. Add `DefaultBar` to your plugins in `~/.zshrc`:

```bash
plugins=(... DefaultBat)
```

3. Reload your shell:

```bash
source ~/.zshrc
```

### Manual Installation

Add this to your `~/.zshrc`:

```bash
real_cat=$(whence -p cat)
if command -v bat > /dev/null 2>&1; then
  function cat() {   
    if [ $# -eq 0 ] || [ "$1" = "-" ]; then 
      "$real_cat" "$@"
      return
    fi 
    [[ $- == *i* ]] || { "$real_cat" "$@"; return; }
    if [ -t 1 ]; then 
      bat -P --style=plain "$@"
    else 
      "$real_cat" "$@"
    fi 
  }
fi
```

## Customisation

You can change the flags you want for displaying in the file

```sh
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/DefaultBat/DefaultBat.plugin.zsh
```

On the line containing

```zsh
   if [ -t 1 ]; then 
      bat -P --style=plain "$@"
    else 
```

Add all the flags you want here

## How It Works

When you run `cat file.txt`:

- **In terminal**: Uses `bat` with syntax highlighting
- **In pipe**: `cat file.txt | grep` uses real `cat`
- **In redirect**: `cat file.txt > output` uses real `cat`
- **In scripts**: Non-interactive shells use real `cat`

## Uninstall

Remove `bat-cat` from your plugins list in `~/.zshrc` and reload your shell.

## License

MIT
