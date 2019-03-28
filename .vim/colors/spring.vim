
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" File Name:      spring.vim
" Abstract:       A color sheme file (only for GVIM), which make the VIM 
"                 bright with colors. It looks like the flowers are in 
"                 blossom in Spring.
" Author:         CHE Wenlong <chewenlong AT buaa.edu.cn>
" Version:        1.0
" Last Change:    September 16, 2008

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !has("gui_running")
    runtime! colors/default.vim
    finish
endif

set background=light

hi clear

" Version control
if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

let colors_name = "spring"

" Common
hi Normal           guifg=#000000   guibg=#cce8cf   gui=NONE
hi Visual           guibg=#B0E0E6                   gui=NONE
hi Cursor           guifg=NONE      guibg=#D2A2CC   gui=NONE
hi Cursorline       guibg=#ccffff
hi lCursor          guifg=#000000   guibg=#ffffff   gui=NONE
hi LineNr           guifg=black     guibg=#e0e0e0   gui=NONE
hi Title            guifg=#202020   guibg=NONE      gui=bold
hi Underlined       guifg=#202020   guibg=NONE      gui=underline

" Split
hi StatusLine       guifg=#000000   guibg=#7bbfea   gui=NONE
hi StatusLineNC     guifg=#000000   guibg=#65c294   gui=NONE
hi VertSplit        guifg=#cce8cf   guibg=#cce8cf   gui=NONE

" Folder
hi Folded           guifg=#006699   guibg=#e0e0e0   gui=NONE

" Syntax
hi Type             guifg=#8000FF   guibg=NONE      gui=bold
hi Define           guifg=#0080FF   guibg=NONE      gui=bold
hi Comment          guifg=#04B404   guibg=NONE      gui=NONE
hi Constant         guifg=#5E610B   guibg=NONE      gui=NONE
hi String           guifg=#a07040   guibg=NONE      gui=NONE
hi Number           guifg=#cd0000   guibg=NONE      gui=NONE
hi Statement        guifg=#FA58AC   guibg=NONE      gui=NONE

" Others
hi PreProc          guifg=#1060a0    guibg=NONE     gui=NONE
hi Error            guifg=#ff0000    guibg=#ffffff  gui=bold,underline
hi Todo             guifg=#a0b0c0    guibg=NONE     gui=bold,underline
hi Special          guifg=#8B038D    guibg=NONE     gui=NONE
hi SpecialKey       guifg=#d8a080    guibg=#e8e8e8  gui=NONE

hi IncSearch     guibg=#ffd400
hi Search        guibg=#ffd400

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim:tabstop=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
