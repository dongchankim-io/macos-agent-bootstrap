-- ~/.config/nvim/init.lua
-- Lightweight, zero-plugin Neovim configuration

local opt = vim.opt

-- Indentation: 4 spaces, expand tabs to spaces
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true

-- Line wrapping: soft wrap at word boundaries while preserving indent
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- Search: case-insensitive by default, case-sensitive when uppercase is used
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- UI & Appearance
opt.number = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Split windows in natural directions
opt.splitright = true
opt.splitbelow = true

-- System integration & persistence
opt.clipboard = "unnamedplus" -- Sync yank/paste with macOS clipboard
opt.undofile = true           -- Persistent undo history across sessions
opt.updatetime = 250

-- Invisible character symbols (toggle visibility with :set list)
opt.listchars = {
  tab = "▸·",
  trail = "·",
  nbsp = "␣",
}

-- Colorscheme
vim.cmd.colorscheme("industry")

-- Keymaps
-- Clear search highlight when pressing <Esc> in Normal mode
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Autocommands
-- Restore cursor to last known position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursorPosition", { clear = true }),
  callback = function(event)
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
