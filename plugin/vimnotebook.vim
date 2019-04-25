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
let g:NoteBook#note_reg = "l"
let g:NoteBook#log_name = file.".log"

command! RunLine call NoteBook#RunLine()
command! -nargs=1 NoteBook call NoteBook#Start(<f-args>)
command! RunYank call NoteBook#RunYank()
command! EndNoteBook call NoteBook#End()
let g:end_codes = {"python": "exit()", "R": "q(\"no\")", "node": ".exit", "bash": "exit", "sh": "exit", "ex": "exit", "ghci": ":quit"}

let &cpo = s:save_cpo
unlet s:save_cpo
