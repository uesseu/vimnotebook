scriptencoding utf-8
" VimNoteBook
" Last Change:	2019 Apr 24
" Maintainer:	Ninja <sheepwing@kyudai.jp>
" License:	Mit licence

if !exists('g:loaded_vimnotebook')
    finish
endif
let g:loaded_vimnotebook = 1

let s:save_cpo = &cpo
set cpo&vim

if v:progname == "nvim"
  function! NoteBook#Start (lang)
    vs
    execu "term script ".g:NoteBook#log_name
    execute "let @".g:NoteBook#note_reg." = a:lang . \"\n\n\""
    execute "put ".g:NoteBook#note_reg
    winc w
    execute "set filetype=".a:lang
    let g:NoteBook#note_lang = a:lang
  endfunction

  function! NoteBook#RunLine ()
    execute "let @".g:NoteBook#note_reg." = getline(\".\")"
    execute "let @".g:NoteBook#note_reg." = @".g:NoteBook#note_reg." . \"\n\n\""
    winc w
    execute "put ".g:NoteBook#note_reg
    winc w
  endfunction

  function! NoteBook#RunYank ()
    winc w
    put
    execute "let @".g:NoteBook#note_reg." = \"\n\n\""
    execute "put ".g:NoteBook#note_reg
    winc w
  endfunction

  function! NoteBook#End ()
    execute "let @".g:NoteBook#note_reg." =\"".g:NoteBook#end_codes[g:NoteBook#note_lang]."\""
    winc w
    execute "put ".g:NoteBook#note_reg
    execute "let @".g:NoteBook#note_reg."=\"\n\n\""
    execute "put ".g:NoteBook#note_reg
    execute "let @".g:NoteBook#note_reg." =\"exit\""
    execute "put ".g:NoteBook#note_reg
    execute "let @".g:NoteBook#note_reg."=\"\n\n\""
    execute "put ".g:NoteBook#note_reg
  endfunction

elseif v:progname == "vim"
  function! NoteBook#Start (lang)
    let g:NoteBook#note_lang = a:lang
    execute "set filetype=".a:lang
    execu "term script ".g:NoteBook#log_name
    for bf in getbufinfo()
      if bf["name"] == "!script ".g:NoteBook#log_name
        let g:NoteBook#note_buf = bf["bufnr"]
      endif
    endfor
    call term_sendkeys(g:NoteBook#note_buf, g:NoteBook#note_lang."\n")
  endfunction

  function! NoteBook#RunLine ()
    execute "let @".g:NoteBook#note_reg." = getline(\".\")"
    execute "call term_sendkeys(".g:NoteBook#note_buf.", @" . g:NoteBook#note_reg . ".\"\n\")"
  endfunction

  function! NoteBook#RunYank ()
    execute "call term_sendkeys(".g:NoteBook#note_buf.", @0.\"\n\")"
  endfunction

  function! NoteBook#End ()
    execute "call term_sendkeys(".g:NoteBook#note_buf.", g:NoteBook#end_codes[g:NoteBook#note_lang].\"\n\")"
    execute "let @".g:NoteBook#note_reg." =\"".g:NoteBook#end_codes[g:NoteBook#note_lang]."\""
    call term_sendkeys(g:NoteBook#note_buf, "exit"."\n")
  endfunction
endif

let &cpo = s:save_cpo
unlet s:save_cpo
