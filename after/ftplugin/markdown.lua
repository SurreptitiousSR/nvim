-- Smart Enter: continue list/checkbox on the current line's pattern
vim.keymap.set("i", "<CR>", function()
  local line = vim.api.nvim_get_current_line()
  local col  = vim.api.nvim_win_get_cursor(0)[2]
  local before_cursor = line:sub(1, col)

  -- Empty checkbox "- [ ] " with nothing typed → remove it (end of list)
  if line:match("^(%s*)%- %[ %] $") then
    vim.api.nvim_set_current_line(line:match("^(%s*)"))
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

-- Cryptex-only: Enter follows [[wikilinks]] in normal mode
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
