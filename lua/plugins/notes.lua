return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>nn", "<cmd>ObsidianNew<cr>",           desc = "New note" },
      { "<leader>no", "<cmd>ObsidianSearch<cr>",        desc = "Search vault" },
      { "<leader>ns", "<cmd>ObsidianSearch<cr>",        desc = "Search vault" },
      { "<leader>nd", "<cmd>ObsidianDailies<cr>",       desc = "Daily notes" },
      { "<leader>nb", "<cmd>ObsidianBacklinks<cr>",     desc = "Backlinks" },
      { "<leader>nt", "<cmd>ObsidianTags<cr>",          desc = "Tags" },
      { "<leader>nl", "<cmd>ObsidianFollowLink<cr>",    desc = "Follow link" },
      { "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>",   desc = "Quick switch" },
      { "<leader>nr", "<cmd>ObsidianRename<cr>",        desc = "Rename note" },
      { "gd",         "<cmd>ObsidianFollowLink<cr>",    desc = "Follow link", ft = "markdown" },
    },
    opts = {
      workspaces = {
        {
          name = "cryptex",
          path = "~/Nextcloud/Cryptex",
        },
      },
      note_id_func = function(title)
        local suffix = title and title:gsub(" ", "-"):gsub("[^A-Za-z0-9%-]", ""):lower() or ""
        return os.date("%Y%m%d%H%M") .. (suffix ~= "" and "-" .. suffix or "")
      end,
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        template = "daily-template",
      },
      templates = {
        folder = "templates",
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      ui = {
        enable = true,
        checkboxes = {
          [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          ["x"] = { char = "☑", hl_group = "ObsidianDone" },
          [">"] = { char = "▶", hl_group = "ObsidianRightArrow" },
        },
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "↗", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        hl_groups = {
          ObsidianTodo        = { bold = true, fg = "#FFFF55" },
          ObsidianDone        = { bold = true, fg = "#55FF55" },
          ObsidianRightArrow  = { bold = true, fg = "#55FFFF" },
          ObsidianRefText     = { underline = true, fg = "#55FFFF" },
          ObsidianExtLinkIcon = { fg = "#AAAAAA" },
          ObsidianTag         = { italic = true, fg = "#FF55FF" },
          ObsidianHighlightText = { bg = "#555500" },
          ObsidianBullet      = { bold = true, fg = "#FFFF55" },
        },
      },
      attachments = {
        img_folder = "assets",
      },
      open_notes_in = "current",
      picker = {
        name = "telescope.nvim",
      },
    },
  },
}
