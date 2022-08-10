local colorscheme = "everforest"

if colorscheme == "everforest" then
  vim.g.everforest_transparent_background = true
  vim.g.everforest_background = 'hard'
end

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  print("Theme doesn't work lol")
  return
end
