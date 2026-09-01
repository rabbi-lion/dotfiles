-- Leader
vim.g.mapleader = ","

-- General
vim.opt.title = true
vim.opt.background = "dark"
vim.opt.mouse = "a"
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.laststatus = 0

vim.opt.wildmode = "longest,list,full"

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Syntax / filetypes
vim.cmd("filetype plugin on")
vim.cmd("syntax on")
vim.cmd.colorscheme("vim")

-- Don't automatically continue comments on new lines
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Change without copying deleted text
vim.keymap.set("n", "c", '"_c')

-- Repeat last normal-mode command over visual selection
vim.keymap.set("v", ".", ":normal .<CR>", { silent = true })

-- Navigate splits with Ctrl+h/j/k/l
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Q formats text instead of entering Ex mode
vim.keymap.set("n", "Q", "gq")

-- S = substitute throughout file
vim.keymap.set("n", "S", ":%s//g<Left><Left>")

-- Toggle spellcheck
vim.keymap.set("n", "<leader>o", function()
	vim.opt_local.spell = not vim.opt_local.spell:get()
	vim.opt_local.spelllang = "en_us"
end)

-- Jump to <++> placeholders
vim.keymap.set("n", ",,", ":keepp /<++><CR>ca<", { silent = true })
vim.keymap.set("i", ",,", "<Esc>:keepp /<++><CR>ca<", { silent = true })

-- Remove trailing whitespace when saving
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local cursor = vim.api.nvim_win_get_cursor(0)

		vim.cmd([[%s/\s\+$//e]])

		vim.api.nvim_win_set_cursor(0, cursor)
	end,
})
