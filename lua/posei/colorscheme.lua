local colorscheme = "onedark"

if colorscheme == "everforest" then
  vim.g.everforest_transparent_background = true
  vim.g.everforest_background = 'hard'
end

if colorscheme == "onedark" then
  require('onedark').setup {
      style = 'warm',
      transparent = true
  }
  require('onedark').load()
end

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  print("Theme doesn't work lol")
  return
end
