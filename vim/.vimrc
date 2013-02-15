"load plugins

for s:path in split(glob($VIM.'/plugins/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path

"solarized

set background=dark
let g:solarized_italic=0
colorscheme solarized

"cannot change fonts...

"set guifont=Source_Code_Pro:h9
"set guifontwide=MSºÞ¼¯¸:h10

