local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs / indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Wrapping
opt.wrap = true
opt.linebreak = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- DOS box-drawing characters for splits
opt.fillchars = {
  vert  = "║",
  horiz = "═",
  horizup = "╩",
  horizdown = "╦",
  vertleft = "╣",
  vertright = "╠",
  verthoriz = "╬",
  fold = "─",
  eob = " ",
}

-- Block cursor everywhere, blinking in insert
opt.guicursor = "n-v-c:block,i-ci-ve:block-blinkwait700-blinkon400-blinkoff250,r-cr:hor20,o:hor50"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Split behaviour
opt.splitright = true
opt.splitbelow = true

-- Misc
opt.mouse = "a"
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.updatetime = 250
opt.timeoutlen = 500
opt.completeopt = "menuone,noinsert,noselect"
opt.pumheight = 10

-- Word wrap for prose
opt.breakindent = true
opt.showbreak = "  ↳ "

-- Show whitespace
opt.list = true
opt.listchars = { tab = "→ ", trail = "·", nbsp = "·" }

-- No intro message
opt.shortmess:append("I")
