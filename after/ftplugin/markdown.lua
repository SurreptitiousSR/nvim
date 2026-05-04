-- Extra keymaps active only inside ~/Nextcloud/Cryptex markdown files
local bufname = vim.api.nvim_buf_get_name(0)
local cryptex = vim.fn.expand("~/Nextcloud/Cryptex")

if bufname:find(cryptex, 1, true) then
  local map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = true, silent = true, desc = desc })
  end

  map("<CR>",       "<cmd>ObsidianFollowLink<cr>",  "Follow [[link]]")
  map("<BS>",       "<cmd>ObsidianBack<cr>",         "Back (pop link stack)")
  map("<leader>nl", "<cmd>ObsidianLinks<cr>",        "List links in note")
end
