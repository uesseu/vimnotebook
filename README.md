# English
Sorry, my English is poor...:(
If you can read Japanese, it is better to read japanese.

## VimNoteBook
This is a plugin for neovim to use repl,
for example, python, node.js, haskell and so on.

## Install
In case of vimplug

```
Plug 'uesseu/vimnotebook'
```

Incase of dein

```
call dein#add('uesseu/vimnotebook')
```

## Usage

### TLDR;

Write as this

```vim
extend(vimnotebook#end_codes, {"python": "exit", "node": ".exit"})
extend(vimnotebook#lang_names, {"python": "exit", "node", "javascript"})
nnoremap g<Up> :NoteBook python<CR>
nnoremap g<Down> :RunYank<CR>
nnoremap g<Left> :RunLine<CR>
nnoremap g<Right> :EndNoteBook<CR>
```

And then, your vim can run interpreter.
Logfile willbe written as "log"

### Start

Command to start is

```vim
:NoteBook [command]
```
for example, type

```vim
:NoteBook python
```

and python interpreter run.
Other interpreter can run in the same way.

It is just name of interpreter.
If your name of interpreter is not name of language,
type like this.

```vim
extend(vimnotebook#lang_names, {"python": "exit", "node", "javascript"})
```

### Run current line

```
:RunLine
```

### Run yanked

```
:RunYank
```

### End
First, you should ending command of interpreter to use.

```vim
extend(vimnotebook#end_codes, {"python": "exit", "node": ".exit"})
```

for example...

```vim
extend(end_codes, {"python": "exit"}
```
(End code of python is already set :)

```
:EndNoteBook
```

### Run paragraph
There is no such function ;)
You can yank paragraph by...

```
{V}y
```

### Other options

#### Register
By default, it uses register @l.
If you want to use other register, use this option.
```vim
let g:vimnotebook#note_reg = "r"
```
This set @r to use.

### Limitation
This plugin only send key to terminal.
And so, you cannot send such words like "<CR>".

If you use neovim, there is no such limitation.

# 日本語
英語うまく書けないお(´・ω・｀)

## これは何？
これはvimでreplを使う為のプラグインです。
pythonとかnode.jsとか、そういうのをvimでやります。

## インストール
普通です。下記がわかんないなら、vimplugやdeinでググってください。

vimplug

```
Plug 'uesseu/vimnotebook'
```

dein

```
call dein#add('uesseu/vimnotebook')
```
## 使い方

### なげえよ！

例えばこんな風に書いてしまいます。
```vim
extend(vimnotebook#end_codes, {"python": "exit", "node": ".exit"})
extend(vimnotebook#lang_names, {"python": "exit", "node", "javascript"})
nnoremap g<Up> :NoteBook python<CR>
nnoremap g<Down> :RunYank<CR>
nnoremap g<Left> :RunLine<CR>
nnoremap g<Right> :EndNoteBook<CR>
```

そうすると、自分の使いたいreplをg+矢印で使えるんじゃね？
というふうなやつです。

### はじめかた

こんなふうにします。

```vim
:NoteBook [command]
```

例えばインタプリタがpythonならこうです。
あくまでインタプリタの名前です。

```vim
:NoteBook python
```

そうすると、新たなターミナルが開いて、replが使えるのです。

インタプリタと言語の紐付けはこうします。

```vim
extend(vimnotebook#lang_names, {"python": "exit", "node", "javascript"})
```

### 今いる行をreplに放り込む

```
:RunLine
```

### ヤンクしてるものを放り込む

```
:RunYank
```

### 終了する
まず、終わりの言葉を入れてあげる必要があります。

```vim
extend(vimnotebook#end_codes, {"python": "exit", "node": ".exit"})
```

例えばpythonならこうです。

```vim
extend(end_codes, {"python": "exit"})
```

(pythonの終わりの言葉は既に入れています
その上で、こうです。

```
:EndNoteBook
```

### 段落を放り込む
段落を入れたいときのコマンドは用意していませんが、
下記で段落はヤンク出来るから良いのではないでしょうか？

```
{V}y
```

### その他の設定

#### レジスタ
このぷらぎんはデフォルトで@lレジスタを使います。
もし別のレジスタを…@rを使いたいならこのようにしてください。

```vim
let g:vimnotebook#note_reg = "r"
```

### これのダメなところ
これ、vimだとキーストロークをそのまま反映するから、
<CR>みたいな文字列は改行として受け取られます。
neovimなら大丈夫と思います、多分。
