let g:lsc_enable_autocomplete = v:false " Disable autocompletion
let g:lsc_trace_level='messages'
let g:lsc_hover_popup = v:false
let g:lsc_server_commands = {
  \ 'javascript': 'typescript-language-server --stdio',
  \ 'typescript': 'typescript-language-server --stdio',
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

let g:lsc_auto_map = {
    \ 'GoToDefinition': ',d',
    \ 'GoToDefinitionSplit': ',v',
    \ 'FindReferences': ',r',
    \ 'NextReference': ',nr',
    \ 'PreviousReference': ',pr',
    \ 'FindImplementations': ',i',
    \ 'FindCodeActions': ',a',
    \ 'Rename': ',R',
    \ 'ShowHover': v:true,
    \ 'DocumentSymbol': ',o',
    \ 'WorkspaceSymbol': ',S',
    \ 'SignatureHelp': ',s',
    \ 'Completion': 'omnifunc',
    \}
