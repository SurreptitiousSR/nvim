-- Org-mode local keymaps (mirrors Emacs muscle memory where sensible)
local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { buffer = true, silent = true, desc = desc })
end

map("<leader>oA", "<cmd>lua require('orgmode').action('agenda.prompt')<cr>", "Agenda (from org file)")
map("<leader>oC", "<cmd>lua require('orgmode').action('capture.prompt')<cr>", "Capture (from org file)")

-- Smart Enter: continue list/checkbox on the current line's pattern
vim.keymap.set("i", "<CR>", function()
  local line = vim.api.nvim_get_current_line()
  local col  = vim.api.nvim_win_get_cursor(0)[2]
  local before_cursor = line:sub(1, col)

  -- Empty checkbox item "- [ ] " with nothing after → remove it (end of list)
  if line:match("^(%s*)%- %[ %] $") then
    vim.api.nvim_set_current_line(line:match("^(%s*)") )
    return "<CR>"
  end

  local indent = line:match("^(%s*)")

  -- Checkbox:        - [ ] text
  if before_cursor:match("^%s*%- %[.%]") then
    return "<CR>" .. indent .. "- [ ] "
  end

  -- Plain list item: - text  or  * text
  if before_cursor:match("^%s*[%-%*]%s+") then
    local bullet = line:match("^%s*([%-%*])%s+")
    return "<CR>" .. indent .. bullet .. " "
  end

  -- Numbered list:   1. text
  if before_cursor:match("^%s*%d+%.%s+") then
    local n = tonumber(line:match("^%s*(%d+)%.")) or 1
    return "<CR>" .. indent .. (n + 1) .. ". "
  end

  return "<CR>"
end, { buffer = true, expr = true, desc = "Smart Enter (continue list/checkbox)" })
