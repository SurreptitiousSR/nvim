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
      { "<leader>ff", desc = "Find files (project root)" },
      { "<leader>fF", "<cmd>Telescope find_files cwd=~<cr>",         desc = "Find files (home)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                 desc = "Recent files" },
      { "<leader>fg", desc = "Live grep (project root)" },
      { "<leader>fG", "<cmd>Telescope live_grep cwd=~<cr>",          desc = "Live grep (home)" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                  desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",                desc = "Help tags" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>",              desc = "Diagnostics" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>",                  desc = "Keymaps" },
      { "<leader>fc", "<cmd>Telescope commands<cr>",                 desc = "Commands" },
      { "<leader>fz", desc = "Find in Cryptex vault" },
      { "<leader>fZ", desc = "Grep in Cryptex vault" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      -- Root-aware find: uses git root if inside a repo, else cwd
      local function find_root()
        local root = vim.fs.root(0, { ".git", ".hg", "pyproject.toml", "package.json" })
        builtin.find_files({ cwd = root or vim.loop.cwd(), hidden = false })
      end

      local function grep_root()
        local root = vim.fs.root(0, { ".git", ".hg", "pyproject.toml", "package.json" })
        builtin.live_grep({ cwd = root or vim.loop.cwd() })
      end

      vim.keymap.set("n", "<leader>ff", find_root, { silent = true, desc = "Find files (project root)" })
      vim.keymap.set("n", "<leader>fg", grep_root,  { silent = true, desc = "Live grep (project root)" })

      local cryptex = vim.fn.expand("~/Nextcloud/Cryptex")
      vim.keymap.set("n", "<leader>fz", function()
        builtin.find_files({ cwd = cryptex, hidden = false })
      end, { silent = true, desc = "Find in Cryptex vault" })
      vim.keymap.set("n", "<leader>fZ", function()
        builtin.live_grep({ cwd = cryptex })
      end, { silent = true, desc = "Grep in Cryptex vault" })

      telescope.setup({
        defaults = {
          prompt_prefix = "C:\\> ",
          selection_caret = "► ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
          },
          preview = {
            treesitter = false,
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

  -- Treesitter (v0.9+ API: just a parser installer; highlighting is built into nvim 0.9+)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup()

      local ensure = {
        "python", "javascript", "typescript", "tsx",
        "html", "css", "bash", "lua", "vim", "vimdoc",
        "markdown", "markdown_inline",
        "yaml", "toml", "json", "dockerfile",
      }

      -- Defer parser installation so it doesn't block startup
      vim.schedule(function()
        local installed = require("nvim-treesitter").get_installed()
        local installed_set = {}
        for _, p in ipairs(installed) do installed_set[p] = true end

        local to_install = {}
        for _, p in ipairs(ensure) do
          if not installed_set[p] then table.insert(to_install, p) end
        end
        if #to_install > 0 then
          require("nvim-treesitter.install").install(to_install)
        end
      end)

      -- Enable treesitter highlighting and indent per-buffer (built-in nvim feature)
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
        callback = function()
          pcall(vim.treesitter.start)
          -- Use treesitter-based indentation where available
          local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
          if lang then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
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
