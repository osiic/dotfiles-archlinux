local keymap = vim.keymap

-- Escape dari mode insert dan visual
keymap.set("i", "jj", "<Esc>")
keymap.set("v", "jk", "<Esc>")

-- Save file dan keluar
keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Buffer management
keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-h>", ":bprev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })

-- Clear highlight search dengan ESC
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Paste aman dari Windows clipboard
keymap.set("n", "<leader>v", function()
	vim.cmd([[%s/\r//g]])
end, { desc = "Paste from clipboard safely (strip \\r)" })

-- Pindah window (split)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus bottom window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus top window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- Split window
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })
