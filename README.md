# nvim

Personal Neovim configuration — DOS aesthetic, Zettelkasten, personal org-mode.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/SurreptitiousSR/nvim/main/install.sh | bash
```

Or manually:

```sh
git clone https://github.com/SurreptitiousSR/nvim.git ~/.config/nvim
cd ~/.config/nvim && bash install.sh --skip-clone
```

## What's inside

| Feature | Tool |
|---|---|
| Plugin manager | lazy.nvim |
| Fuzzy finder | telescope.nvim + fzf-native |
| Syntax | nvim-treesitter |
| LSP | nvim-lspconfig + Mason |
| Completion | nvim-cmp + LuaSnip |
| File browser | oil.nvim |
| Zettelkasten | obsidian.nvim → `~/Nextcloud/Cryptex/` |
| Personal org | nvim-orgmode → `~/Nextcloud/Documents/org/` |
| Git signs | gitsigns.nvim |
| Colorscheme | custom DOS (CGA/EGA palette) |

## Key bindings (Space leader)

| Key | Action |
|---|---|
| `<Space>ff` | Find file |
| `<Space>fg` | Live grep |
| `<Space>fr` | Recent files |
| `<Space>nn` | New zettel note |
| `<Space>ns` | Search vault |
| `<Space>nb` | Backlinks |
| `<Space>nd` | Daily notes |
| `<Space>oa` | Org agenda |
| `<Space>oc` | Org capture |
| `<Space>te` | File explorer |

Run `:checkhealth` after first launch to verify everything is configured correctly.
