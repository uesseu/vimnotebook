scriptencoding utf-8
" VimNoteBook
" Last Change:	2019 Apr 24
" Maintainer:	Ninja <sheepwing@kyudai.jp>
" License:	Mit licence

if exists('g:loaded_vimnotebook')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

let g:loaded_vimnotebook = 1
let g:vimnotebook#note_reg = "l"
let g:vimnotebook#log_name = expand("%:p")."log"

command! RunLine call vimnotebook#RunLine()
command! -nargs=1 NoteBook call vimnotebook#Start(<f-args>)
command! RunYank call vimnotebook#RunYank()
command! EndNoteBook call vimnotebook#End()
let g:vimnotebook#end_codes = {"python": "exit()", "R": "q(\"no\")", "node": ".exit", "bash": "exit", "sh": "exit", "ex": "exit", "ghci": ":quit"}

let &cpo = s:save_cpo
unlet s:save_cpo
