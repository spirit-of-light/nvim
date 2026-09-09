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
