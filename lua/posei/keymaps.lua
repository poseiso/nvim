local keymap = vim.keymap.set
local opts = { silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- navigation
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Lint --
keymap("n", "<leader>fs", ":DartFmt -l 120")

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<C-b>", ":NvimTreeToggle <CR>", opts)

-- Telescope
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

keymap("n", "<leader>ff", function()
  builtin.find_files(themes.get_ivy())
end, opts)

keymap("n", "<leader>ft", function()
  builtin.live_grep(themes.get_ivy())
end, opts)

keymap("n", "<leader>fp", function()
  builtin.projects(themes.get_ivy())
end, opts)

keymap("n", "<leader>fb", function()
  builtin.buffers(themes.get_ivy())
end, opts)
