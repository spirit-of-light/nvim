--== General ==--
vim.g.mapleader = " "
vim.o.undofile = true
vim.o.swapfile = false

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

--== UI ==--
vim.o.breakindent = true
vim.o.breakindentopt = 'list:-1'
vim.o.cursorline = true
vim.o.cursorlineopt = 'screenline,number'
vim.o.fillchars = 'eob: ,fold:╌'
vim.o.linebreak = true
vim.o.pumblend = 0
vim.o.pumborder = 'single' -- popup menu border
vim.o.pumheight = 10 -- popup menu height
vim.o.pummaxwidth = 100 -- popup menu width
vim.o.relativenumber = true
vim.o.ruler = false 
vim.o.shortmess = 'CFOWaco'
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitkeep = 'screen'
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.winblend = 0
vim.o.winborder = 'single'
vim.o.wrap = false

-- Folds
vim.o.foldlevel = 10
vim.o.foldmethod = 'indent'
vim.o.foldnestmax = 10
vim.o.foldtext = ''

--== Editing ==--
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.formatoptions = 'rqnl1j'
vim.o.ignorecase = true -- Show both upper and lower case search matches when searching in lower case
vim.o.incsearch = true -- Show search matches during input
vim.o.infercase = true
vim.o.shiftwidth = 3
vim.o.smartcase = true -- When search contains upper case letter, do not show lower case letters
vim.o.smartindent = true
vim.o.softtabstop = 3
vim.o.spelloptions = 'camel'
vim.o.tabstop = 3
vim.o.virtualedit = 'block' -- Allow virtual block mode to move past line end

vim.o.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as part of word for textobject

-- Pattern for a start of numbered list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Completion
vim.o.complete = '.,w,b,kspell' -- Limit completion sources
vim.o.completeopt = 'fuzzy,menuone,noselect,nosort' -- Define behavior for completion
vim.o.completetimeout = 100

--== Autocommands ==--
-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
local fix_formatoptions = function() vim.cmd('setlocal formatoptions-=c formatoptions-=o') end
Config.new_autocmd('FileType', nil, fix_formatoptions, "Proper 'formatoptions'")

--== Diagnostics ==--
-- Neovim has built-in support for showing diagnostic messages. This configures
-- a more conservative display while still being useful.
-- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
local diagnostic_opts = {
  -- Show signs on top of any other sign, but only for warnings and errors
  signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },

  -- Show all diagnostics as underline (for their messages type `<Leader>ld`)
  underline = { severity = { min = 'HINT', max = 'ERROR' } },

  -- Show more details immediately for errors on the current line
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    severity = { min = 'ERROR', max = 'ERROR' },
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}

-- Use `later()` to avoid sourcing `vim.diagnostic` on startup
Config.later(function() vim.diagnostic.config(diagnostic_opts) end)
