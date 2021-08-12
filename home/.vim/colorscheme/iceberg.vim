vim9script

if &background is 'light'
else
  # Override
  hi CursorLineNr cterm=bold
  hi ModeMsg      cterm=bold
  hi MoreMsg      cterm=bold
  hi NonText      cterm=bold
  hi Question     cterm=bold
  hi Directory    ctermfg=110 guifg=#84a0c6
  hi EndOfBuffer  ctermfg=239 guifg=#444b71
  hi netrwExe     ctermfg=234 guifg=#e27878
  hi netrwSymlink ctermfg=140 guifg=#a093c7
  hi WildMenu ctermfg=253 ctermbg=240 guifg=#c2c6d3 guibg=#414a70
  hi VertSplit term=NONE ctermfg=234 ctermbg=NONE guifg=#0f1117 guibg=NONE
  hi StatusLine   cterm=NONE ctermfg=250 ctermbg=236 gui=NONE guifg=#aab1d4 guibg=#272c42
  hi StatusLineNC cterm=NONE ctermfg=238 ctermbg=233 gui=NONE guifg=#3e445e guibg=#0f1117
  hi! link IncSearch      Cursor
  hi! link Search         PmenuSel
  hi! link StatusLineTerm StatusLine
  hi! link netrwClassify  netrwPlain
  hi! link netrwLink      netrwPlain
  hi! link netrwTreeBar   netrwPlain

  # New
  hi CleverFDefaultLabel cterm=bold,underline ctermfg=203 ctermbg=234 gui=bold,underline guifg=#e27878 guibg=#161821
  hi! link GitGutterAddIntraLine    DiffAdd
  hi! link GitGutterDeleteIntraLine DiffDelete
  hi! link HighlightedyankRegion    Visual
  hi! link MatchWord                CursorColumn
  hi! link TabLineSelMod            Statement
endif
