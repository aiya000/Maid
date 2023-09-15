## Boost your vimrc with
## some template techniques!

- 2023-XX-XX
- aiya000（[@public\_ai000ya](https://twitter.com/public_ai000ya)）

<a style="position: absolute; bottom: 0; left: 0; width: 150px; height: auto;" href="TODO: このスライドがあるURL">
<img src="TODO">
</a>

- - - - -

# What is this session?

- - - - -

## What is this session?

1. Learn 

- - - - -

# Me

- - - - -

## Me

<img src="../shared/me-mu2.jpg" style="position: absolute; top: 100px; right: 0; width: 300px; height: auto;" />

- Name
    - aiya000
- Twitter
    - [@pubilc\_ai000ya](https://twitter.com/public_ai000ya)

- Like
    - Strong static typed languages
        - TypeScript, **Haskell**, Scala3, Idris
    - Math
        - Categoroy theory, Algebraic structure

- - - - -

## Me

- Like
    - and **Vim** ;)

- - - - -

## Me

I wrote this books!

<div>
    <a href="https://aiya000.booth.pm/items/1298622"><img src="../shared/setulab-cover.png" class="book" /></a>
    <a href="https://aiya000.booth.pm/items/1298622"><img src="../shared/setulab-backcover.png" class="book" /></a>
</div>

<aside class="notes">
せつラボっていう本を出しています。 <br />
数学がわからないけど、入門したい！ という人向けに、やさしい内容の本になっています。 <br />
このLTのこの画像をクリックすると販売ページに進めるので、よかったら買ってくれると、僕がよろこびます！ <br />
</aside>

- - - - -

[This session's zenn link](https://zenn.dev/aiya000/articles/cd06a0f3620d59)  
↑ Please ♡

<aside class="notes">
ちなみに、今回の資料はZennにも上げています。
もしよかったら、いいねをよろしくお願いします。
</aside>

- - - - -

## Boost your vimrc with
## some template techniques!

- - - - -

# vital.vim

- - - - -

## vital.vim

Vim script's semi standard library,  
from vim-jp.

https://github.com/vim-jp/vital.vim

```vim
let s:V = vital#vimrc#new()
let s:List = s:V.import('Data.List')
let s:Msg = s:V.import('Vim.Message')
let s:Promise = s:V.import('Async.Promise')
```

- - - - -

## vital.vim

<img src="./vital1.png" style="width: auto; height: 60vh;" />

- - - - -

## vital.vim

<img src="./vital2.png" style="width: auto; height: 60vh;" />

- - - - -

## vital.vim

<img src="./vital3.png" style="width: auto; height: 30vh;" />

...

And a lot of modules!!

- - - - -

## vital.vim

vital.vim for writing Vim script.  
Meaning also vital.vim for writing your **vimrc**.

```vim
" Writing expression oriented error messages
let g:vimrc.open_on_gui =
  \ g:vimrc.is_macos   ? 'open' :
  \ g:vimrc.is_windows ? 'start' :
  \ g:vimrc.is_unix    ? 'xdg-open' : s:Msg.warn('no method for GUI-open')

" Do keymapping for the range of @a ~ @z
for x in s:List.char_range('a', 'z')
  execute 'nnoremap' '<silent>' $'@{x}'
    \ (":\<C-u>" .. $'call vimrc#foo("{x}")\<CR>')
endfor
```

- - - - -

# Vim script specs

- - - - -

## Vim script specs

String interpolation

`$''` `$""`

```vim
" No more '..' !!!!!!!!

" Not easy to read
call system('chown -R ' .. $USER .. ':' .. $GROUP .. '"{foo_directory}"')

" ↓ Easy to read ↓
call system($'chown -R "{$USER}:{$GROUP}" "{foo_directory}"')
```

- - - - -

## Vim script specs

```vim
" Ne more expand('~') !

if filereadable($'{$HOME}/dein_env.toml')
  call dein#load_toml('~/dein_env.toml', {'lazy': 0})
endif
```

- - - - -

## Vim script specs

Function delcrations is placing num of lines.

```vim
function s:read_git_root() abort
  " ...
endfunction
function s:job_start_simply(cmd) abort
  " ...
endfunction
" ... and a lot of functions.

command! -bar GitPush call s:job_start_simply(['git', 'push'])
" ... and a lot of commands.

let s:root = call s:read_git_root()
" ... others
```

- - - - -

## Vim script specs

You can use **~/.vim/autoload** and **~/.vim/plugin** directory.  
For example:

.vim/autoload/vimrc.vim
```vim
function vimrc#job_start_simply(cmd) abort
  " ...
endfunction

" ...
```

- - - - -

.vim/autoload/vimrc/job.vim
```vim
function vimrc#job#start_simply(cmd) abort
  " ...
endfunction

" ...
```

.vim/plugin/vimrc.vim
```vim
command! -bar GitPush call s:job_start_simply(['git', 'push'])

" ...
```

.vimrc
```vim
let s:root = call s:read_git_root()

" ...
```

- - - - -

## Vim script specs

- autoload: **function** declarations
- plugins: **command** declaretions
- vimrc: settings and others
