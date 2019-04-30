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

if !exists('g:vimnotebook#save_log')
  let g:vimnotebook#save_log = 1
endif

if !exists('let g:vimnotebook#note_reg')
  let g:vimnotebook#note_reg = "l"
endif

if expand("%:p") == ""
  let g:vimnotebook#log_name = "tmp.log"
else
  let g:vimnotebook#log_name = expand("%:p").".log"
endif

command! RunLine call vimnotebook#RunLine()
command! -nargs=1 NoteBook call vimnotebook#Start(<f-args>)
command! RunYank call vimnotebook#RunYank()
command! EndNoteBook call vimnotebook#End()

let &cpo = s:save_cpo
unlet s:save_cpo
