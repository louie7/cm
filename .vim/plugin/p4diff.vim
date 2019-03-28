function s:P4Diff()
  !p4 print -q %\#have > /tmp/vim\#p4diff\#%:t
  rightb vert diffsplit /tmp/vim\#p4diff\#%:t
  %foldopen!
  wincmd h
  %foldopen!
endfunction
command PD :call s:P4Diff()
autocmd BufUnload /tmp/vim\#p4diff\#* !rm <afile>
