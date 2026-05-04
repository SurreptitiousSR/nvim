return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▌" },
        change       = { text = "▌" },
        delete       = { text = "▄" },
        topdelete    = { text = "▀" },
        changedelete = { text = "▌" },
        untracked    = { text = "▌" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map("<leader>gs", gs.stage_hunk,        "Stage hunk")
        map("<leader>gr", gs.reset_hunk,        "Reset hunk")
        map("<leader>gS", gs.stage_buffer,      "Stage buffer")
        map("<leader>gu", gs.undo_stage_hunk,   "Undo stage hunk")
        map("<leader>gR", gs.reset_buffer,      "Reset buffer")
        map("<leader>gp", gs.preview_hunk,      "Preview hunk")
        map("<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("<leader>gd", gs.diffthis,          "Diff this")
        map("]g",         gs.next_hunk,         "Next hunk")
        map("[g",         gs.prev_hunk,         "Prev hunk")
      end,
    },
  },
}
