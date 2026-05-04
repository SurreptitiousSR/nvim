local map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", { silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Better escape
map("i", "jk", "<Esc>")

-- Save
map("n", "<C-s>", "<cmd>w<cr>")

-- Quit
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- ── Windows ──────────────────────────────────────────────────────────────
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>wq", "<cmd>close<cr>", { desc = "Close window" })
map("n", "<leader>wh", "<C-w>h", { desc = "Move left" })
map("n", "<leader>wl", "<C-w>l", { desc = "Move right" })
map("n", "<leader>wj", "<C-w>j", { desc = "Move down" })
map("n", "<leader>wk", "<C-w>k", { desc = "Move up" })

-- Also use Ctrl+hjkl for quick window movement
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- ── Buffers ───────────────────────────────────────────────────────────────
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "Prev buffer" })

-- ── Toggles ───────────────────────────────────────────────────────────────
map("n", "<leader>tn", "<cmd>set number! relativenumber!<cr>", { desc = "Toggle line numbers" })
map("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "Toggle word wrap" })
map("n", "<leader>ts", "<cmd>set spell!<cr>", { desc = "Toggle spell check" })
map("n", "<leader>tl", "<cmd>set list!<cr>", { desc = "Toggle whitespace chars" })

-- ── Editing ───────────────────────────────────────────────────────────────
-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Keep cursor centred on search nav and page scroll
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Paste without losing register
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>")
