-- Org-mode local keymaps (mirrors Emacs muscle memory where sensible)
local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { buffer = true, silent = true, desc = desc })
end

map("<leader>oA", "<cmd>lua require('orgmode').action('agenda.prompt')<cr>", "Agenda (from org file)")
map("<leader>oC", "<cmd>lua require('orgmode').action('capture.prompt')<cr>", "Capture (from org file)")
