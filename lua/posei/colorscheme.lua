local colorscheme = "everforest"
-- local colorscheme = "gruvbox"

if colorscheme == "everforest" then
  vim.g.everforest_transparent_background = true
  vim.g.everforest_background = 'hard'
end

require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  print("Theme doesn't work lol")
  return
end
