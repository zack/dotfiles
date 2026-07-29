# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# What this is

Zack's personal dotfiles. Config files are stored here **without** a leading dot
and symlinked into `$HOME` with one. Everything is a symlink, so edits in this
repo take effect immediately — there is no build step and nothing to re-run
after changing a tracked file.

# Layout and installation

`install_script` is the linker, and it owns everything symlink-related:

- `files` — each is linked `~/dotfiles/<name>` → `~/.<name>`
- `nvim/init.lua` → `~/.config/nvim/init.lua` and `nvim/lua` → `~/.config/nvim/lua`
- `rainbow` → `~/bins/rainbow`

It's idempotent and safe to re-run: anything already linked correctly is left
alone, anything else in the way gets backed up to
`~/dotfiles_old/<timestamp>/` first. It also prompts to `git clone` the
private `work_dotfiles` repo if it's missing — `work_dotfiles` gets no symlink
of its own, since `zshrc` sources `work_dotfiles/zshrc_*` straight out of the
repo path.

It also installs the tools these dotfiles assume are present. apt covers only
the baseline now: zsh, build-essential, curl, wget, fortune-mod, cowsay (zsh
also gets set as the login/default shell via `chsh`). eza, difftastic, tmux,
ripgrep, fzf, and bat are all pulled as prebuilt GitHub release binaries into
`~/bins` instead — no sudo, no third-party apt repos, no cargo — except tmux,
which GitHub only ships as source for, so that one gets built via
`./configure && make`. zoxide comes from its own upstream install script.
nvim is its own GitHub-release AppImage (a single self-mounting binary, so it
needs `fuse3` installed alongside it) rather than the usual tarball. nvm comes
from its own install script too, run with `PROFILE=/dev/null` so it doesn't
try to append its own source lines to `zshrc` — this repo already hand-manages
the nvm lazy-load there. Nothing in `install_script` is a manual do-nothing
step anymore; the only thing left that's genuinely manual is GitHub SSH
access, handled by `fre.sh` (below), not `install_script`.

**Adding a new top-level config file means adding its name to `files`**, or it
will sit in the repo and never get linked.

`fre.sh` is the one-liner bootstrap for a fresh machine (`wget ... | sh`): it
handles one-time setup that isn't really about linking. It first checks
whether GitHub SSH access already works and, if not, offers to generate an
`ed25519` key and prints the public key to add at
github.com/settings/keys before continuing — the clone right after this
needs SSH. It then clones this repo, zsh-syntax-highlighting, fzf-tab, and
tpm, and calls `install_script` for everything else, including the
`work_dotfiles` prompt. The `with-dir`/`only-dir` fzf helpers get copied into
`/usr/local/bin` last.

## Not in this repo

`.gitignore` excludes `vim/`, `work_dotfiles/`, and `zsh-syntax-highlighting/`.
Those directories exist on disk but are vendored or live in a separate private
repo — changes made there are not tracked here. `zshrc` sources every
`work_dotfiles/zshrc_*` at the bottom, so machine-specific and private config
goes there, never here.

`~/.config/nvim/lazy-lock.json` is also outside the repo: plugin versions are
deliberately unpinned and float with `lazy.nvim`'s update checker.

# Neovim

The bulk of the repo. `init.lua` (~330 lines) bootstraps lazy.nvim and then
holds everything that isn't a plugin spec, divided by box-drawing banners:
LSP setup, colors, autocommands, options, functions, key mappings.

Plugins are one file per plugin in `nvim/lua/plugins/`, each returning a single
lazy spec table. `init.lua` does `{ import = "plugins" }`, so **adding a plugin
is adding a file — there is no list to register it in**, and removing a plugin
means deleting the file.

Conventions in that directory:

- Filename mirrors the upstream repo name with `.lua` appended, keeping any
  suffix the upstream already has: `flash.nvim.lua`, `bclose.vim.lua`
- A one-line `--` comment above `return` when the plugin's purpose isn't
  obvious from its name (`-- delete a buffer without closing the window`).
- 2-space indent. Quote style is mixed per file — match the file you're in.

LSP is split across three places: `mason-tool-installer.nvim.lua` holds the
`ensure_installed` list of servers and formatters, `mason-lspconfig.nvim.lua`
wires mason to lspconfig, and per-server settings go in the LSP SETUP section
of `init.lua` via `vim.lsp.config('<server>', {...})`. Formatting is
`none-ls.nvim` running `prettierd` on `BufWritePre`.

Keymaps live in the KEY MAPPINGS section of `init.lua`, grouped by mode,
alphabetized within a group, each with a trailing `--` comment explaining it.
Leader is space. Plugin-local keys can also go in the spec's `keys` table.

# Shell

`zshrc` is sectioned with `### HEADING` comments — PATH, exports, history,
prompt (hand-rolled `vcs_info`, no framework), aliases, functions. Aliases are
alphabetized within their group. Vi mode is on. `nvm`/`node`/`npm`/`nvim` are
lazy-loaded via a self-replacing alias, which is why `nvim` looks like an alias
rather than a binary in an interactive shell (the real one is `~/bins/nvim`).
`with-dir`/`only-dir` are small in-repo `awk` scripts (wrapped in
`#!/bin/sh`) that fzf's path/dir completion pipes through; installed to
`/usr/local/bin` by `fre.sh`.

# Checking work

There are no tests, no linter, and no CI. What's available:

```sh
zsh -n zshrc                   # syntax-check the shell config
~/bins/nvim --headless +qa     # loads full config; prints errors, silent when clean
tmux source-file ~/.tmux.conf  # reload tmux config
```

For a plugin change, the honest check is opening nvim and using the thing.

# Commits

Terse, lowercase, no prefixes — often just the name of what changed
(`smart paste`, `git lineage`, `ctrl-backspace`, `bento.nvim.lua`). Sentence
case shows up for larger changes. One commit per config change is normal.
