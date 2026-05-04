return {
  {
    "nvim-orgmode/orgmode",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    config = function()
      local org_dir = vim.fn.expand("~/Nextcloud/Documents/org/")

      require("orgmode").setup({
        org_agenda_files = { org_dir .. "*.org" },
        org_default_notes_file = org_dir .. "inbox.org",

        org_todo_keywords = { "TODO", "|", "DONE" },

        org_capture_templates = {
          t = {
            description = "TODO",
            template    = "* TODO %?\n",
            target      = org_dir .. "inbox.org",
            headline    = "Inbox",
          },
          j = {
            description = "Journal entry",
            template    = "* %U\n%?\n",
            target      = org_dir .. "journal.org",
            headline    = "Journal",
          },
          r = {
            description = "Reading list",
            template    = "* TODO %? :reading:\n",
            target      = org_dir .. "reading_list.org",
            headline    = "Reading List",
          },
        },

        org_agenda_custom_commands = {
          n = {
            description = "Next 3 days + all TODOs",
            types = {
              { type = "agenda", span = 3 },
              { type = "alltodo", header = "Upcoming" },
            },
          },
        },

        org_startup_indented = true,
        org_startup_folded = "content",
        org_hide_leading_stars = true,
        org_ellipsis = " ▾",
        org_log_done = "time",
        org_agenda_start_on_weekday = false,
        org_agenda_time_leading_zero = true,
      })

      -- Keybindings
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
      end

      map("<leader>oa", function() require("orgmode").action("agenda.prompt") end, "Agenda")
      map("<leader>oc", function() require("orgmode").action("capture.prompt") end, "Capture")
      map("<leader>on", "<cmd>e ~/Nextcloud/Documents/org/inbox.org<cr>",           "Open inbox")
    end,
  },
}
