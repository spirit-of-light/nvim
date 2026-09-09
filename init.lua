-- Define config table to pass data between files
_G.Config = {}

-- Create an autocommand group with an empty table (that being {} ), which clears any any previous autocommands present.
local autocommand_group = vim.api.nvim_create_augroup('custom-config', {})
-- Function to make creating an autocommand easier
Config.new_autocmd = function(event, pattern, callback, desc)
	local opts = { group = autocommand_group, pattern = pattern, callback = callback, desc = desc }
	vim.api.nvim_create_autocmd(event, opts)
end

-- Install the Mini.Nvim library
vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

-- Load the mini.misc module to use its safely() functions
local misc         = require('mini.misc')
Config.now         = function(f) misc.safely('now', f) end
Config.later       = function(f) misc.safely('later', f) end
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
Config.on_event    = function(ev, f) misc.safely('event:' .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end
