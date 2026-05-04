return {
  -- Mason: LSP server installer
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "double" },
    },
  },

  -- Mason <-> lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "pyright", "ts_ls", "html", "cssls",
        "bashls", "yamlls", "taplo", "dockerls", "marksman",
      },
      automatic_installation = true,
    },
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map("<leader>ld", vim.lsp.buf.definition,       "Go to definition")
        map("<leader>lD", vim.lsp.buf.declaration,      "Go to declaration")
        map("<leader>lr", "<cmd>Telescope lsp_references<cr>", "References")
        map("<leader>li", "<cmd>Telescope lsp_implementations<cr>", "Implementations")
        map("<leader>la", vim.lsp.buf.code_action,      "Code action")
        map("<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
        map("<leader>lk", vim.lsp.buf.hover,            "Hover docs")
        map("<leader>lR", vim.lsp.buf.rename,           "Rename")
        map("<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols")
        map("<leader>lS", "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace symbols")
        map("[d",         vim.diagnostic.goto_prev,     "Prev diagnostic")
        map("]d",         vim.diagnostic.goto_next,     "Next diagnostic")
        map("<leader>le", vim.diagnostic.open_float,    "Show diagnostic")
      end

      local servers = {
        "pyright", "ts_ls", "html", "cssls",
        "bashls", "yamlls", "taplo", "dockerls", "marksman",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      -- Diagnostic display
      vim.diagnostic.config({
        virtual_text = { prefix = "■" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "double" },
      })

      vim.fn.sign_define("DiagnosticSignError", { text = "✘", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn",  { text = "▲", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignHint",  { text = "⚑", texthl = "DiagnosticSignHint" })
      vim.fn.sign_define("DiagnosticSignInfo",  { text = "●", texthl = "DiagnosticSignInfo" })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion    = cmp.config.window.bordered({ border = "double" }),
          documentation = cmp.config.window.bordered({ border = "double" }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"]     = cmp.mapping.select_prev_item(),
          ["<C-j>"]     = cmp.mapping.select_next_item(),
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<CR>"]      = cmp.mapping.confirm({ select = false }),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "orgmode" },
          { name = "obsidian" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, item)
            local kind_icons = {
              Text = "T", Method = "m", Function = "f", Constructor = "C",
              Field = "F", Variable = "v", Class = "c", Interface = "I",
              Module = "M", Property = "p", Unit = "u", Value = "#",
              Enum = "e", Keyword = "k", Snippet = "S", Color = "~",
              File = "📄", Reference = "r", Folder = "📁", EnumMember = "E",
              Constant = "K", Struct = "s", Event = "!", Operator = "o",
              TypeParameter = "t",
            }
            item.kind = string.format("%s %s", kind_icons[item.kind] or "?", item.kind)
            return item
          end,
        },
      })
    end,
  },
}
