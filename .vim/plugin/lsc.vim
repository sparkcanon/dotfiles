let g:lsc_enable_autocomplete = v:false  " Disable autocompletion
let g:lsc_trace_level         = 'off'    " Turn off tracing for servers
let g:lsc_hover_popup         = v:false  " Disable hover pop up

" Server configurations
let g:lsc_server_commands = {
  \ 'javascript': {
	\ 'command': 'typescript-language-server --stdio',
	\ 'log_level': -1,
	\ 'supress_stderr': v:true,
  \ },
  \ 'typescript': {
	\ 'command': 'typescript-language-server --stdio',
	\ 'log_level': -1,
	\ 'supress_stderr': v:true,
  \ },
  \ 'typescriptreact': {
	\ 'command': 'typescript-language-server --stdio',
	\ 'log_level': -1,
	\ 'supress_stderr': v:true,
  \ },
  \ 'html': 'html-languageserver --stdio',
  \ 'css': 'css-languageserver --stdio',
  \ 'vim' : {
  \   'name': 'vim-language-server',
  \   'command': 'vim-language-server --stdio',
  \      'message_hooks': {
  \          'initialize': {
  \              'initializationOptions': { 'vimruntime': $VIMRUNTIME, 'runtimepath': &rtp },
  \          },
  \      },
  \   },
  \ }

" Remap default mappings
let g:lsc_auto_map = {
    \ 'GoToDefinition'      : ',d',
    \ 'GoToDefinitionSplit' : ',v',
    \ 'FindReferences'      : ',r',
    \ 'NextReference'       : ',nr',
    \ 'PreviousReference'   : ',pr',
    \ 'FindImplementations' : ',i',
    \ 'FindCodeActions'     : ',a',
    \ 'Rename'              : ',R',
    \ 'ShowHover'           : v:true,
    \ 'DocumentSymbol'      : ',o',
    \ 'WorkspaceSymbol'     : ',S',
    \ 'SignatureHelp'       : ',s',
    \ 'Completion'          : 'omnifunc',
    \}
