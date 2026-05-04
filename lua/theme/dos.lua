-- DOS colorscheme — CGA/EGA 16-color palette
-- Applied via: vim.cmd("colorscheme dos")

local M = {}

M.colors = {
  black     = "#000000",
  blue      = "#0000AA",
  green     = "#00AA00",
  cyan      = "#00AAAA",
  red       = "#AA0000",
  magenta   = "#AA00AA",
  brown     = "#AA5500",
  lgray     = "#AAAAAA",
  dgray     = "#555555",
  lblue     = "#5555FF",
  lgreen    = "#55FF55",
  lcyan     = "#55FFFF",
  lred      = "#FF5555",
  lmagenta  = "#FF55FF",
  yellow    = "#FFFF55",
  white     = "#F8F8FF",
}

function M.setup()
  local c = M.colors
  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Reset
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
  vim.o.background = "dark"
  vim.g.colors_name = "dos"

  -- ── Editor chrome ────────────────────────────────────────────────────────
  hi("Normal",       { fg = c.white,    bg = c.black })
  hi("NormalNC",     { fg = c.lgray,    bg = c.black })
  hi("NormalFloat",  { fg = c.white,    bg = "#000033" })
  hi("FloatBorder",  { fg = c.lblue,    bg = "#000033" })
  hi("SignColumn",   { fg = c.lgray,    bg = c.black })
  hi("ColorColumn",  { bg = "#111111" })
  hi("CursorLine",   { bg = "#0a0a0a" })
  hi("CursorLineNr", { fg = c.yellow,   bold = true })
  hi("LineNr",       { fg = c.dgray })
  hi("VertSplit",    { fg = c.blue,     bg = c.black })
  hi("WinSeparator", { fg = c.blue,     bg = c.black })
  hi("EndOfBuffer",  { fg = c.black })
  hi("Folded",       { fg = c.dgray,    bg = "#000033" })
  hi("FoldColumn",   { fg = c.dgray,    bg = c.black })

  -- ── Statusline (Norton Commander blue) ────────────────────────────────────
  hi("StatusLine",   { fg = c.white,    bg = c.blue,  bold = true })
  hi("StatusLineNC", { fg = c.lgray,    bg = "#000055" })

  -- ── Selection / search ───────────────────────────────────────────────────
  hi("Visual",    { fg = c.black,  bg = c.lgray })
  hi("VisualNOS", { fg = c.black,  bg = c.dgray })
  hi("Search",    { fg = c.black,  bg = c.yellow })
  hi("IncSearch", { fg = c.black,  bg = c.lcyan, bold = true })
  hi("CurSearch", { fg = c.black,  bg = c.lgreen })

  -- ── Popup menu ───────────────────────────────────────────────────────────
  hi("Pmenu",       { fg = c.white, bg = "#000033" })
  hi("PmenuSel",    { fg = c.black, bg = c.lblue, bold = true })
  hi("PmenuSbar",   { bg = "#000055" })
  hi("PmenuThumb",  { bg = c.blue })

  -- ── Syntax ───────────────────────────────────────────────────────────────
  hi("Comment",    { fg = c.lgray,    italic = true })
  hi("Constant",   { fg = c.lred })
  hi("String",     { fg = c.lgreen })
  hi("Character",  { fg = c.lgreen })
  hi("Number",     { fg = c.lred })
  hi("Boolean",    { fg = c.lred })
  hi("Float",      { fg = c.lred })
  hi("Identifier", { fg = c.lcyan })
  hi("Function",   { fg = c.lcyan,    bold = true })
  hi("Statement",  { fg = c.yellow,   bold = true })
  hi("Keyword",    { fg = c.yellow,   bold = true })
  hi("Operator",   { fg = c.white })
  hi("PreProc",    { fg = c.lmagenta })
  hi("Include",    { fg = c.lmagenta })
  hi("Type",       { fg = c.lmagenta, bold = true })
  hi("Special",    { fg = c.lcyan })
  hi("Delimiter",  { fg = c.lgray })
  hi("Underlined", { underline = true })
  hi("Bold",       { bold = true })
  hi("Italic",     { italic = true })

  -- ── Diagnostics ──────────────────────────────────────────────────────────
  hi("DiagnosticError",          { fg = c.lred })
  hi("DiagnosticWarn",           { fg = c.yellow })
  hi("DiagnosticInfo",           { fg = c.lcyan })
  hi("DiagnosticHint",           { fg = c.lgray })
  hi("DiagnosticSignError",      { fg = c.lred,   bg = c.black })
  hi("DiagnosticSignWarn",       { fg = c.yellow, bg = c.black })
  hi("DiagnosticSignInfo",       { fg = c.lcyan,  bg = c.black })
  hi("DiagnosticSignHint",       { fg = c.lgray,  bg = c.black })
  hi("DiagnosticVirtualTextError", { fg = c.lred,   italic = true })
  hi("DiagnosticVirtualTextWarn",  { fg = c.yellow, italic = true })
  hi("DiagnosticVirtualTextInfo",  { fg = c.lcyan,  italic = true })
  hi("DiagnosticVirtualTextHint",  { fg = c.dgray,  italic = true })
  hi("DiagnosticUnderlineError", { undercurl = true, sp = c.lred })
  hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.yellow })

  -- ── Gitsigns ─────────────────────────────────────────────────────────────
  hi("GitSignsAdd",    { fg = c.lgreen, bg = c.black })
  hi("GitSignsChange", { fg = c.yellow, bg = c.black })
  hi("GitSignsDelete", { fg = c.lred,   bg = c.black })

  -- ── Telescope ────────────────────────────────────────────────────────────
  hi("TelescopeNormal",         { fg = c.white,  bg = "#000033" })
  hi("TelescopeBorder",         { fg = c.blue,   bg = "#000033" })
  hi("TelescopePromptBorder",   { fg = c.lblue,  bg = "#000044" })
  hi("TelescopePromptNormal",   { fg = c.white,  bg = "#000044" })
  hi("TelescopePromptPrefix",   { fg = c.yellow, bg = "#000044" })
  hi("TelescopeSelection",      { fg = c.black,  bg = c.lblue, bold = true })
  hi("TelescopeSelectionCaret", { fg = c.yellow, bg = c.lblue })
  hi("TelescopeMatching",       { fg = c.lgreen, bold = true })
  hi("TelescopeResultsTitle",   { fg = c.yellow, bold = true })
  hi("TelescopePreviewTitle",   { fg = c.lcyan,  bold = true })
  hi("TelescopePromptTitle",    { fg = c.lgreen, bold = true })

  -- ── Dashboard ────────────────────────────────────────────────────────────
  hi("DashboardHeader",  { fg = c.lcyan,  bold = true })
  hi("DashboardFooter",  { fg = c.dgray,  italic = true })
  hi("DashboardIcon",    { fg = c.yellow })
  hi("DashboardDesc",    { fg = c.lgray })
  hi("DashboardKey",     { fg = c.lgreen, bold = true })

  -- ── Treesitter overrides ──────────────────────────────────────────────────
  hi("@comment",          { fg = c.lgray,    italic = true })
  hi("@string",           { fg = c.lgreen })
  hi("@number",           { fg = c.lred })
  hi("@boolean",          { fg = c.lred })
  hi("@keyword",          { fg = c.yellow,   bold = true })
  hi("@keyword.function", { fg = c.yellow,   bold = true })
  hi("@keyword.return",   { fg = c.yellow,   bold = true })
  hi("@function",         { fg = c.lcyan,    bold = true })
  hi("@function.call",    { fg = c.lcyan })
  hi("@method",           { fg = c.lcyan,    bold = true })
  hi("@method.call",      { fg = c.lcyan })
  hi("@type",             { fg = c.lmagenta, bold = true })
  hi("@type.builtin",     { fg = c.lmagenta })
  hi("@variable",         { fg = c.white })
  hi("@variable.builtin", { fg = c.lred,     italic = true })
  hi("@parameter",        { fg = c.white })
  hi("@property",         { fg = c.lcyan })
  hi("@field",            { fg = c.lcyan })
  hi("@tag",              { fg = c.yellow })
  hi("@tag.attribute",    { fg = c.lgreen })
  hi("@tag.delimiter",    { fg = c.lgray })
  hi("@operator",         { fg = c.white })
  hi("@punctuation",      { fg = c.lgray })
  hi("@constant",         { fg = c.lred })
  hi("@constant.builtin", { fg = c.lred,     bold = true })
  hi("@namespace",        { fg = c.lmagenta })
  hi("@include",          { fg = c.lmagenta })

  -- ── Org-mode ─────────────────────────────────────────────────────────────
  hi("OrgHeadlineLevel1", { fg = c.lcyan,    bold = true })
  hi("OrgHeadlineLevel2", { fg = c.lgreen,   bold = true })
  hi("OrgHeadlineLevel3", { fg = c.yellow,   bold = true })
  hi("OrgHeadlineLevel4", { fg = c.lmagenta, bold = true })
  hi("OrgTodo",           { fg = c.lred,     bold = true })
  hi("OrgDone",           { fg = c.lgreen,   bold = true })
  hi("OrgDate",           { fg = c.lcyan,    underline = true })
  hi("OrgAgendaScheduled",{ fg = c.lgreen })
  hi("OrgAgendaDeadline", { fg = c.lred,     bold = true })

  -- ── Which-key ────────────────────────────────────────────────────────────
  hi("WhichKey",          { fg = c.yellow, bold = true })
  hi("WhichKeyDesc",      { fg = c.white })
  hi("WhichKeyGroup",     { fg = c.lcyan,  bold = true })
  hi("WhichKeySeparator", { fg = c.dgray })
  hi("WhichKeyBorder",    { fg = c.blue })
  hi("WhichKeyFloat",     { bg = "#000033" })
end

return M
