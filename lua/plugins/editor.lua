return {
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",               desc = "Find files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                 desc = "Recent files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",                desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                  desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",                desc = "Help tags" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>",              desc = "Diagnostics" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>",                  desc = "Keymaps" },
      { "<leader>fc", "<cmd>Telescope commands<cr>",                 desc = "Commands" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = "C:\\> ",
          selection_caret = "► ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Esc>"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = { hidden = true },
        },
      })

      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python", "javascript", "typescript", "tsx",
          "html", "css", "bash", "lua", "vim", "vimdoc",
          "markdown", "markdown_inline", "org",
          "yaml", "toml", "json", "dockerfile",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "org" },
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection    = "<C-space>",
            node_incremental  = "<C-space>",
            scope_incremental = false,
            node_decremental  = "<bs>",
          },
        },
      })
    end,
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "classic",
        icons = { mappings = false },
      })
      wk.add({
        { "<leader>f",  group = "Files" },
        { "<leader>b",  group = "Buffers" },
        { "<leader>w",  group = "Windows" },
        { "<leader>g",  group = "Git" },
        { "<leader>l",  group = "LSP" },
        { "<leader>n",  group = "Notes (Zettel)" },
        { "<leader>o",  group = "Org (Personal)" },
        { "<leader>oc", group = "Capture" },
        { "<leader>t",  group = "Toggle" },
      })
    end,
  },

  -- File browser (dired-like)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    keys = {
      { "<leader>te", "<cmd>Oil<cr>", desc = "File explorer (oil)" },
      { "-",          "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      view_options = {
        show_hidden = false,
      },
      float = {
        border = "double",
      },
    },
  },
}
