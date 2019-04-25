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
  function! vimnotebook#Start (lang)
    vs
    execu "term script ".g:vimnotebook#log_name
    execute "let @".g:vimnotebook#note_reg." = a:lang . \"\n\n\""
    execute "put ".g:vimnotebook#note_reg
    winc w
    execute "set filetype=".a:lang
    let g:vimnotebook#note_lang = a:lang
  endfunction

  function! vimnotebook#RunLine ()
    execute "let @".g:vimnotebook#note_reg." = getline(\".\")"
    execute "let @".g:vimnotebook#note_reg." = @".g:vimnotebook#note_reg." . \"\n\n\""
    winc w
    execute "put ".g:vimnotebook#note_reg
    winc w
  endfunction

  function! vimnotebook#RunYank ()
    winc w
    put
    execute "let @".g:vimnotebook#note_reg." = \"\n\n\""
    execute "put ".g:vimnotebook#note_reg
    winc w
  endfunction

  function! vimnotebook#End ()
    execute "let @".g:vimnotebook#note_reg." =\"".g:vimnotebook#end_codes[g:vimnotebook#note_lang]."\""
    winc w
    execute "put ".g:vimnotebook#note_reg
    execute "let @".g:vimnotebook#note_reg."=\"\n\n\""
    execute "put ".g:vimnotebook#note_reg
    execute "let @".g:vimnotebook#note_reg." =\"exit\""
    execute "put ".g:vimnotebook#note_reg
    execute "let @".g:vimnotebook#note_reg."=\"\n\n\""
    execute "put ".g:vimnotebook#note_reg
  endfunction

elseif v:progname == "vim"
  function! vimnotebook#Start (lang)
    let g:vimnotebook#note_lang = a:lang
    execute "set filetype=".a:lang
    execu "term script ".g:vimnotebook#log_name
    for bf in getbufinfo()
      if bf["name"] == "!script ".g:vimnotebook#log_name
        let g:vimnotebook#note_buf = bf["bufnr"]
      endif
    endfor
    call term_sendkeys(g:vimnotebook#note_buf, g:vimnotebook#note_lang."\n")
  endfunction

  function! vimnotebook#RunLine ()
    execute "let @".g:vimnotebook#note_reg." = getline(\".\")"
    execute "call term_sendkeys(".g:vimnotebook#note_buf.", @" . g:vimnotebook#note_reg . ".\"\n\")"
  endfunction

  function! vimnotebook#RunYank ()
    execute "call term_sendkeys(".g:vimnotebook#note_buf.", @0.\"\n\")"
  endfunction

  function! vimnotebook#End ()
    execute "call term_sendkeys(".g:vimnotebook#note_buf.", g:vimnotebook#end_codes[g:vimnotebook#note_lang].\"\n\")"
    execute "let @".g:vimnotebook#note_reg." =\"".g:vimnotebook#end_codes[g:vimnotebook#note_lang]."\""
    call term_sendkeys(g:vimnotebook#note_buf, "exit"."\n")
  endfunction
endif

let &cpo = s:save_cpo
unlet s:save_cpo
