vim9script

if &background is 'light'
else
  # Override
  hi CursorLineNr cterm=bold
  hi PreProc guifg=Salmon guibg=NONE
  hi! link SignColumn    LineNr
  hi! link TabLineFill   Tabline
  hi! link VertSplit     LineNr
  hi! link netrwClassify netrwPlain
  hi! link netrwLink     netrwPlain
  hi! link netrwTreeBar  netrwPlain

  # New
  hi! link HighlightedyankRegion Visual
endif
