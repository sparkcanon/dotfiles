" Colors {{{
" Make buffer transparent
function! functions#modifyBufferColors() abort
	highlight! Normal ctermbg=NONE
	highlight! EndOfBuffer ctermbg=NONE
	highlight! VertSplit ctermbg=NONE
endfunction

" Lsc signs color mods
function! functions#modifylscColors() abort
	highlight lscDiagnosticError ctermfg=202
	highlight lscDiagnosticWarning ctermfg=94
	highlight lscDiagnosticInfo ctermfg=29
	highlight lscDiagnosticHint ctermfg=100
	highlight lscReference ctermbg=59 ctermfg=white
endfunction

" Signify color mods
function! functions#modifyCocGitColors() abort
	highlight CocAddSign guifg=green guibg=NONE ctermbg=NONE
	highlight CocDeleteSign guifg=#ff0000  guibg=NONE ctermbg=NONE
	highlight CocChangeSign guifg=#fab005 guibg=NONE ctermbg=NONE
	highlight CocChangeRemovedSign guifg=#fab005 guibg=NONE ctermbg=NONE
	highlight CocTopRemovedSign guifg=#ff0000 guibg=NONE ctermbg=NONE
endfunction
" }}}

" Grep {{{
" Perform the search in a sub-shell
function! functions#grep(args) abort
	let args = split(a:args, ' ')
	return system(join([&grepprg, shellescape(args[0]), len(args) > 1 ? join(args[1:-1], ' ') : ''], ' '))
endfunction
" }}}

" Visual {{{
" Get visual section
function! functions#getVisualSelection() abort
	let l=getline("'<")
	let [line1,col1] = getpos("'<")[1:2]
	let [line2,col2] = getpos("'>")[1:2]
	return l[col1 - 1: col2 - 1]
endfunction
" }}}

" Abbrs {{{
function! functions#setupCommandAbbrs(from, to) abort
	exec 'cnoreabbrev <expr> '.a:from
				\ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
				\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction
" }}}

" Git stash {{{
function! functions#getGitStash() abort
	let stashList = systemlist('git stash list')
	call setqflist([], ' ', {'lines': systemlist('git stash list'), 'title': 'Stash list'}) 
				\| copen
endfunction
" }}}
