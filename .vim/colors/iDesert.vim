
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

let g:colors_name="iDesert"
    
    hi Cursor        ctermfg=white ctermbg=magenta
    hi SpecialKey    cterm=bold ctermfg=red
    hi NonText       cterm=bold ctermfg=darkblue
    hi Directory     ctermfg=darkblue
    hi ErrorMsg      cterm=bold ctermfg=7 ctermbg=1
    hi IncSearch     cterm=NONE ctermfg=grey ctermbg=blue
    hi Search        cterm=NONE ctermfg=yellow ctermbg=darkgreen
    hi MoreMsg       ctermfg=darkgreen
    hi ModeMsg       cterm=NONE ctermfg=brown
    hi LineNr        ctermfg=darkblue
    hi Question      ctermfg=darkcyan
    
    " Lu Yi set status line color
    hi StatusLine		guifg=blue guibg=darkgrey gui=none		ctermfg=blue ctermbg=gray term=none cterm=none
    hi StatusLineNC		guifg=black guibg=darkgrey gui=none		ctermfg=black ctermbg=gray term=none cterm=none
    "hi StatusLine    cterm=bold,reverse 
    "hi StatusLineNC  cterm=reverse 
    hi VertSplit     cterm=reverse
    hi Title         ctermfg=5
    hi Visual        cterm=reverse
    hi VisualNOS     cterm=bold,underline
    hi WarningMsg    ctermfg=1
    hi WildMenu      ctermfg=0 ctermbg=3
    hi Folded        ctermfg=darkgrey ctermbg=NONE
    hi FoldColumn    ctermfg=darkgrey ctermbg=NONE
    hi DiffAdd       ctermbg=gray
    hi DiffChange    ctermbg=gray
    hi DiffDelete    cterm=bold ctermfg=4 ctermbg=6
    hi DiffText      cterm=bold ctermbg=1 ctermfg=yellow
    hi Comment       ctermfg=darkgreen
    " string color
    hi Constant      ctermfg=brown
    hi Special       cterm=bold ctermfg=darkred
    hi Identifier    cterm=bold ctermfg=darkcyan
    "hi Statement     cterm=bold ctermfg=blue
    hi Statement     cterm=bold ctermfg=darkblue
    hi PreProc       ctermfg=5
    hi Type          cterm=bold ctermfg=darkmagenta
    hi Underlined    cterm=underline ctermfg=5
    hi Ignore        ctermfg=darkgrey
    hi Error         cterm=bold ctermfg=7 ctermbg=1

""" vim: set fdl=0 fdm=marker:

