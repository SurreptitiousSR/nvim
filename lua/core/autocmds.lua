local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Remove trailing whitespace on save (except markdown/org)
autocmd("BufWritePre", {
  group = augroup("TrimWhitespace", { clear = true }),
  pattern = { "*" },
  callback = function()
    local ft = vim.bo.filetype
    if ft ~= "markdown" and ft ~= "org" then
      vim.cmd([[%s/\s\+$//e]])
    end
  end,
})

-- Restore cursor position on open
autocmd("BufReadPost", {
  group = augroup("RestoreCursor", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Prose settings for markdown and org
autocmd("FileType", {
  group = augroup("ProseMode", { clear = true }),
  pattern = { "markdown", "org", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_gb"
    vim.opt_local.conceallevel = 2
  end,
})

-- Daily notes: jump to first blank line after "## Notes" on open
autocmd("BufReadPost", {
  group = augroup("DailyNoteCursor", { clear = true }),
  pattern = { "*/Cryptex/daily/*.md" },
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for i, line in ipairs(lines) do
      if line:match("^## Notes") then
        -- Move to the line after the heading (or end of file)
        local target = math.min(i + 1, #lines)
        vim.api.nvim_win_set_cursor(0, { target, 0 })
        -- Drop into insert mode at end of that line
        vim.schedule(function() vim.cmd("startinsert!") end)
        return
      end
    end
  end,
})

-- Close quickfix/help/man with q
autocmd("FileType", {
  group = augroup("QuickClose", { clear = true }),
  pattern = { "qf", "help", "man", "lspinfo" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
  end,
})
