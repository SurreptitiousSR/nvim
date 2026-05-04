return {
  -- Icons (required by several plugins)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = {
          normal   = { a = { bg = "#0000AA", fg = "#FFFFFF", gui = "bold" },
                       b = { bg = "#000055", fg = "#AAAAAA" },
                       c = { bg = "#000000", fg = "#AAAAAA" } },
          insert   = { a = { bg = "#005500", fg = "#FFFFFF", gui = "bold" } },
          visual   = { a = { bg = "#550055", fg = "#FFFFFF", gui = "bold" } },
          replace  = { a = { bg = "#550000", fg = "#FFFFFF", gui = "bold" } },
          command  = { a = { bg = "#555500", fg = "#000000", gui = "bold" } },
          inactive = { a = { bg = "#000000", fg = "#555555" },
                       b = { bg = "#000000", fg = "#555555" },
                       c = { bg = "#000000", fg = "#555555" } },
        },
        component_separators = { left = "│", right = "│" },
        section_separators   = { left = "█", right = "█" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "╔══════════════════════════════════════════════╗",
        "║                                              ║",
        "║    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗    ║",
        "║    ████╗  ██║██╔════╝██╔═══██╗██║   ██║    ║",
        "║    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║    ║",
        "║    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝    ║",
        "║    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝     ║",
        "║    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝      ║",
        "║                                              ║",
        "║              C:\\NVIM> _                      ║",
        "╚══════════════════════════════════════════════╝",
      }

      dashboard.section.header.opts.hl = "DashboardHeader"

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file",       "<cmd>Telescope find_files<cr>"),
        dashboard.button("r", "  Recent files",    "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("g", "  Live grep",       "<cmd>Telescope live_grep<cr>"),
        dashboard.button("n", "  New note",        "<cmd>ObsidianNew<cr>"),
        dashboard.button("o", "  Org agenda",      "<cmd>lua require('orgmode').action('agenda.prompt')<cr>"),
        dashboard.button("q", "  Quit",            "<cmd>qa<cr>"),
      }

      dashboard.section.footer.val = {
        "MS-DOS Neovim  [Version 0.11]",
        "Copyright (C) 2026 SurreptitiousSR. All rights reserved.",
      }

      dashboard.section.footer.opts.hl = "DashboardFooter"

      alpha.setup(dashboard.opts)
    end,
  },
}
