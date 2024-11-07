local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Exit insert mode
keymap.set("i", "jk", "<ESC>")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "+", "<C-x>")

-- Split window
keymap.set("n", "ss", ":split<CR>", opts)
keymap.set("n", "sv", ":vsplit<CR>", opts)
keymap.set("n", "sd", ":close<CR>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Tabs
keymap.set("n", "tn", ":tabnew<CR>")
keymap.set("n", "td", ":tabclose<CR>")
keymap.set("n", "<tab>", ":tabnext<CR>", opts)
keymap.set("n", "<s-tab>", ":tabprev<CR>", opts)

-- Buffers
keymap.set("n", "[b", ":bprev<CR>", opts)
keymap.set("n", "]b", ":bnext<CR>", opts)

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")
