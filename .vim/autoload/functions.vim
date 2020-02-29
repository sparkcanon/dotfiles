" Colors {{{
" Make buffer transparent
function! functions#modifyBufferColors() abort
	highlight! Normal ctermbg=NONE
	highlight! EndOfBuffer ctermbg=NONE
	highlight! VertSplit ctermbg=NONE
endfunction

" Lsc signs color mods
function! functions#modifylscColors() abort
	" Red
	highlight lscDiagnosticError ctermfg=196 cterm=bold
	" Orange
	highlight lscDiagnosticWarning ctermfg=202 cterm=bold
	" Green
	highlight lscDiagnosticInfo ctermfg=48 cterm=bold
	" Yellow
	highlight lscDiagnosticHint ctermfg=226 cterm=bold
	" Grey
	highlight lscReference ctermbg=241 ctermfg=white
endfunction

" Signify color mods
function! functions#modifySignifyColors() abort
	" Green
	highlight SignifySignAdd ctermfg=48
	" Red
	highlight SignifySignDelete ctermfg=196
	" Yellow
	highlight SignifySignChange ctermfg=226
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
