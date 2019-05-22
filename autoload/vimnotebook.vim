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

if g:vimnotebook#save_log == 1
  let g:vimnotebook#logger = "script "
else
  let g:vimnotebook#logger = ""
endif

let g:vimnotebook#lang_names = {"python": "python", "R": "r", "node": "javascript", "bash": "sh", "sh": "sh", "ex": "ex", "ghci": "haskell"}
let g:vimnotebook#end_codes = {"python": "exit()", "R": "q(\"no\")", "node": ".exit", "bash": "exit", "sh": "exit", "ex": "exit", "ghci": ":quit"}



if v:progname == "nvim"
  function! vimnotebook#Start (lang)
    vs
    execu "term ".g:vimnotebook#logger.g:vimnotebook#log_name
    execute "let @".g:vimnotebook#note_reg." = a:lang . \"\n\n\""
    execute "put ".g:vimnotebook#note_reg
    execute "set filetype=".g:vimnotebook#lang_names[a:lang]
    winc w
    execute "set filetype=".g:vimnotebook#lang_names[a:lang]
    let g:vimnotebook#note_lang = a:lang
    winc H
  endfunction

  function! vimnotebook#RunLine ()
    execute "let @".g:vimnotebook#note_reg." = getline(\".\")"
    execute "let @".g:vimnotebook#note_reg." = @".g:vimnotebook#note_reg." . \"\n\n\""
    winc w
    execute "put ".g:vimnotebook#note_reg
    winc w
  endfunction

  function! vimnotebook#RunLines() range
    let tmp = @@
    silent normal gvy
    let tmp_lines = @@
    let @@ = tmp
    let tmp_lines = split(tmp_lines, '\n')
    for lns in tmp_lines
      execute "let @".g:vimnotebook#note_reg." = lns.\"\n\n\""
      winc w
      execute "put ".g:vimnotebook#note_reg
      winc w
    endfor
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
    execute "set filetype=".g:vimnotebook#lang_names[a:lang]
    execute "term ".g:vimnotebook#logger.g:vimnotebook#log_name
    for bf in getbufinfo()
      "If buffer has 
      "if bf["name"] == "!script ".g:vimnotebook#log_name
        let g:vimnotebook#note_buf = bf["bufnr"]
      "endif
    endfor
    call term_sendkeys(g:vimnotebook#note_buf, g:vimnotebook#note_lang."\n")
    winc w
    winc H
    redraw!
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
