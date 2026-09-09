-- Create a global table with information about Leader groups in certain modes.
-- This is used to provide 'mini.clue' with extra clues.
Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+Language' },
  { mode = 'n', keys = '<Leader>s', desc = '+Session' },
  { mode = 'n', keys = '<Leader>t', desc = '+Terminal' },
  { mode = 'n', keys = '\\', desc = '+Toggles' },

  { mode = 'x', keys = '<Leader>g', desc = '+Git' },
  { mode = 'x', keys = '<Leader>l', desc = '+Language' },
}

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

-- Option toggles under `\`
local toggle = function(key, opt, desc)
   vim.keymap.set('n', '\\' .. key, function()
      vim.cmd('setlocal ' .. opt .. '!')
      vim.notify(opt .. ' = ' .. tostring(vim.o[opt]))
   end, { desc = desc })
end

-- Window navigation with <C-[key]>
for _, k in ipairs({ 'h', 'j', 'k', 'l' }) do
  vim.keymap.set('n', '<C-' .. k .. '>', '<C-w>' .. k, { desc = 'Focus window ' .. k })
end

-- Highlight yanked text
Config.new_autocmd('TextYankPost', nil, function() vim.hl.on_yank() end, 'Highlight on yank')

--== Keybinds ==--
-- Toggles for various common options
toggle('n', 'number',         'Toggle line numbers')
toggle('r', 'relativenumber', 'Toggle relative numbers')
toggle('w', 'wrap',           'Toggle wrap')
toggle('s', 'spell',          'Toggle spell')
toggle('c', 'cursorline',     'Toggle cursorline')
toggle('h', 'hlsearch',       'Toggle search highlight')

-- Buffer control
nmap_leader('ba', '<Cmd>b#<CR>',                                 'Alternate')
nmap_leader('bd', '<Cmd>lua MiniBufremove.delete()<CR>',         'Delete')
nmap_leader('bD', '<Cmd>lua MiniBufremove.delete(0, true)<CR>',  'Delete!')
nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')
nmap_leader('bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', 'Wipeout!')

-- Explore
local explore_at_file = '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>'
local explore_quickfix = function()
  vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and 'cclose' or 'copen')
end

nmap_leader('ed', '<Cmd>lua MiniFiles.open()<CR>',          'Directory')
nmap_leader('ef', explore_at_file,                          'File directory')
nmap_leader('ei', '<Cmd>edit $MYVIMRC<CR>',                 'init.lua')
nmap_leader('en', '<Cmd>lua MiniNotify.show_history()<CR>', 'Notifications')
nmap_leader('eq', explore_quickfix,                         'Quickfix list')

-- Find
nmap_leader('fb', '<Cmd>Pick buffers<CR>',                      'Buffers')
nmap_leader('ff', '<Cmd>Pick files<CR>',                        'Files')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>',                    'Grep live')
nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>',       'Grep current word')
nmap_leader('fh', '<Cmd>Pick help<CR>',                         'Help tags')

-- Git
local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. ' --follow -- %'

nmap_leader('ga', '<Cmd>Git diff --cached<CR>',             'Added diff')
nmap_leader('gA', '<Cmd>Git diff --cached -- %<CR>',        'Added diff buffer')
nmap_leader('gc', '<Cmd>Git commit<CR>',                    'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>',            'Commit amend')
nmap_leader('gd', '<Cmd>Git diff<CR>',                      'Diff')
nmap_leader('gD', '<Cmd>Git diff -- %<CR>',                 'Diff buffer')
nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>',         'Log')
nmap_leader('gL', '<Cmd>' .. git_log_buf_cmd .. '<CR>',     'Log buffer')
nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',  'Show at cursor')

xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at selection')
-- Find git
local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'
nmap_leader('gfc', '<Cmd>Pick git_commits<CR>',                  'Commits (all)')
nmap_leader('gfC', '<Cmd>Pick git_commits path="%"<CR>',         'Commits (buf)')
nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>',     'Added hunks (all)')
nmap_leader('fA', pick_added_hunks_buf,                         'Added hunks (buf)')
nmap_leader('fm', '<Cmd>Pick git_hunks<CR>',                    'Modified hunks (all)')
nmap_leader('fM', '<Cmd>Pick git_hunks path="%"<CR>',           'Modified hunks (buf)')

-- LSP
nmap_leader('la', '<Cmd>lua vim.lsp.buf.code_action()<CR>',     'Actions')
nmap_leader('ld', '<Cmd>lua vim.diagnostic.open_float()<CR>',   'Diagnostic popup')
nmap_leader('lf', '<Cmd>lua require("conform").format()<CR>',   'Format')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.implementation()<CR>',  'Implementation')
nmap_leader('lh', '<Cmd>lua vim.lsp.buf.hover()<CR>',           'Hover')
nmap_leader('ll', '<Cmd>lua vim.lsp.codelens.run()<CR>',        'Lens')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>',          'Rename')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>',      'References')
nmap_leader('ls', '<Cmd>lua vim.lsp.buf.definition()<CR>',      'Source definition')
nmap_leader('lt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type definition')

xmap_leader('lf', '<Cmd>lua require("conform").format()<CR>', 'Format selection')

-- Session
local session_new = 'vim.ui.input({ prompt = "Session name: " }, MiniSessions.write)'

nmap_leader('sd', '<Cmd>lua MiniSessions.select("delete")<CR>', 'Delete')
nmap_leader('sn', '<Cmd>lua ' .. session_new .. '<CR>',         'New')
nmap_leader('sr', '<Cmd>lua MiniSessions.select("read")<CR>',   'Read')
nmap_leader('sR', '<Cmd>lua MiniSessions.restart()<CR>',        'Restart')
nmap_leader('sw', '<Cmd>lua MiniSessions.write()<CR>',          'Write current')

-- Terminal
nmap_leader('tT', '<Cmd>horizontal term<CR>', 'Terminal (horizontal)')
nmap_leader('tt', '<Cmd>vertical term<CR>',   'Terminal (vertical)')
