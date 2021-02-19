execute 'resize' min([line('$') + 2, 10])
setlocal cursorline
setlocal signcolumn=no
setlocal statusline=%!my#statusline#local('qf')
