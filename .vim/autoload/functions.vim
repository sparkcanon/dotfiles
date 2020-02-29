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

" Sessions {{{
function! functions#sessionSave() abort
	let root = fnamemodify(getcwd(0), ':t')
	execute 'mks! $HOME/.vim/tmp/dir_session/'.root.'.vim' | echo 'Session saved as '.root.'.vim'
endfunction

function! functions#sessionLoad(file) abort
	execute 'source $HOME/.vim/tmp/dir_session/'.a:file | echo 'Session '.a:file.' has been loaded'
endfunction

function! functions#sessionCompletePath(A,L,P) abort
	let pathList =  split(globpath('$HOME/.vim/tmp/dir_session/', '*.vim'), '\n')
	let emptyList = []
	for i in pathList
		let item = split(i, '/')[-1]
		let finalList = add(emptyList, item)
	endfor
	return finalList
endfunction
" }}}

" Jest {{{
" TODO: Resolve root automatically
function! functions#jestRunForSingleFile() abort
	execute 'vert terminal ./web/node_modules/.bin/jest --watch '
endfunction
" }}}
