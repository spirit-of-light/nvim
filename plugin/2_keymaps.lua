-- Create a global table with information about Leader groups in certain modes.
-- This is used to provide 'mini.clue' with extra clues.
Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+Language' },
  { mode = 'n', keys = '<Leader>m', desc = '+Map' },
  { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  { mode = 'n', keys = '<Leader>s', desc = '+Session' },
  { mode = 'n', keys = '<Leader>t', desc = '+Terminal' },
  { mode = 'n', keys = '<Leader>v', desc = '+Visits' },
  { mode = 'n', keys = '\\', desc = '+Visits' },

  { mode = 'x', keys = '<Leader>g', desc = '+Git' },
  { mode = 'x', keys = '<Leader>l', desc = '+Language' },
}

-- Option toggles under `\`
local toggle = function(key, opt, desc)
  vim.keymap.set('n', '\\' .. key, function()
    vim.o[opt] = not vim.o[opt]
    vim.notify(opt .. ' = ' .. tostring(vim.o[opt]))
  end, { desc = desc })
end

toggle('n', 'number',         'Toggle line numbers')
toggle('r', 'relativenumber', 'Toggle relative numbers')
toggle('w', 'wrap',           'Toggle wrap')
toggle('s', 'spell',          'Toggle spell')
toggle('c', 'cursorline',     'Toggle cursorline')
toggle('h', 'hlsearch',       'Toggle search highlight')
toggle('l', 'list',           'Toggle listchars')

-- Window navigation with <C-[key]>
for _, k in ipairs({ 'h', 'j', 'k', 'l' }) do
  vim.keymap.set('n', '<C-' .. k .. '>', '<C-w>' .. k, { desc = 'Focus window ' .. k })
end

-- Highlight yanked text
Config.new_autocmd('TextYankPost', nil, function() vim.hl.on_yank() end, 'Highlight on yank')

--== Helpers ==--
-- Normal mode
local nmap = function(keys, execution, desc)
  vim.keymap.set('n', keys, execution, { desc = desc })
end
-- Visual mode
local xmap = function(keys, execution, desc)
  vim.keymap.set('x', keys, execution, { desc = desc })
end

-- Normal mode leader
local nmap_leader = function(keys, execution, desc)
  vim.keymap.set('n', '<Leader>' .. keys, execution, { desc = desc })
end
-- Visual mode leader
local xmap_leader = function(keys, execution, desc)
  vim.keymap.set('x', '<Leader>' .. keys, execution, { desc = desc })
end
