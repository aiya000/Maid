## Boost your vimrc with
## some template techniques!

- 2023-XX-XX
- aiya000（[@public\_ai000ya](https://twitter.com/public_ai000ya)）

<a style="position: absolute; bottom: -2; left: 0; width: 150px; height: auto;" href="https://aiya000.github.io/Maid/Boost-your-vimrc-with-some-template-techniques/#/">
<img src="qrcode.png">
</a>

<!-- 今回のキーワード

nice

# 👍

-->

- - - - -

# What is this session?

- - - - -

## What is this session?

- Learn how to **refine** your vimrc
    - using some techniques

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

# Vim script libraries

- - - - -

# vital.vim

- - - - -

## vital.vim

Vim script's semi standard library,  
from vim-jp.

https://github.com/vim-jp/vital.vim

```vim
let s:List = vital#vimrc#import('Data.List')
let s:Msg = vital#vimrc#import('Vim.Message')
let s:Promise = vital#vimrc#import('Async.Promise')
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

nice

# 👍

- - - - -

#### vital.vim

My favorite modules: **Data.List**

```vim
let s:List = vital#vimrc#import('Data.List')

echo s:List.has([1, 2, 3], 2)
" 1

echo s:List.char_range('a', 'f')
" ['a', 'b', 'c', 'd', 'e', 'f']

echo s:List.count({ x -> x % 2 == 0 }, [1, 2, 3, 4, 5])
" 2
```

- - - - -

These are VERY basic functions.

```vim
echo s:List.foldl({ memo, val -> memo + val }, 0, range(1, 10))
" 55 (= 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10)

echo s:List.intersect(['a', 'b', 'c'], ['b', 'c'])
" ['b', 'c']
```

- - - - -

#### vital.vim

**Vim.Message**

```vim
let s:Msg = vital#vimrc#import('Vim.Message')

call s:Msg.echo(hl, msg)
" > Execute echo with {hl} (highlight-groups).

call s:Msg.echomsg(hl, msg)
" > Execute :echomsg with {hl} (highlight-groups).

call s:Msg.warn(msg)
" > Execute :echomsg with hl-WarningMsg

call s:Msg.error(msg)
" Execute :echomsg with hl-ErrorMsg
```

- - - - -

Usually, `:echo` is a syntax (command).  
But this can be an expression.

```vim
let g:vimrc.open_on_gui =
  \ g:vimrc.is_macos   ? 'open' :
  \ g:vimrc.is_windows ? 'start' :
  \ g:vimrc.is_unix    ? 'xdg-open' :
    \ s:Msg.warn('no method for GUI-open')
```

(Also this is useful than `execute('echo "foo"')`)

- - - - -

nice

# 👍

- - - - -

# Vim script specs

- - - - -

## autoload, plugin, vimrc

- - - - -

#### autoload, plugin, vimrc

Function and command delcrations  
is placing num of lines.

```vim
function s:read_git_root() abort
  " ...
endfunction
function s:job_start_simply(cmd) abort
  " ...
endfunction
" ... and a lot of functions and sub functions.

command! -bar GitPushAsync call s:job_start_simply(['git', 'push'])
" ... and a lot of commands.

let s:root = call s:read_git_root()
" ... others
```

- - - - -

#### autoload, plugin, vimrc

You can use **~/.vim/autoload** and **~/.vim/plugin** directory.
For example:

.vim/autoload/vimrc.vim
```vim
function vimrc#read_git_root() abort
  " ...
endfunction

function s:foo() abort
  " a sub function
endfunction

" ...
```

- - - - -

.vim/autoload/vimrc/job.vim
```vim
function vimrc#job#start_simply(cmd) abort
  " ...
endfunction

function s:bar() abort
  " a sub function
endfunction

" ...
```

.vim/plugin/vimrc.vim
```vim
command! -bar GitPushAsync call s:job_start_simply(['git', 'push'])

" ...
```

- - - - -

.vimrc
```vim
let s:root = call vimrc#read_git_root()
" ...
```

- - - - -

#### autoload, plugin, vimrc

- autoload: **function** declarations
- plugins: **command** declaretions
- vimrc: settings and others

- - - - -

nice

# 👍

- - - - -

# String interpolation

- - - - -

#### String interpolation

`$''` `$""`

```vim
" No more '..' !!!!!!!!

" Not easy to read
call system('chown -R ' .. $USER .. ':' .. $GROUP .. '"{foo_directory}"')

" ↓ Easy to read ↓
call system($'chown -R "{$USER}:{$GROUP}" "{foo_directory}"')
```

```vim
" No more expand('~') !

if filereadable($'{$HOME}/dein_env.toml')
  call dein#load_toml('~/dein_env.toml', {'lazy': 0})
endif
```

- - - - -

```vim
" Better than printf()
let name = 'Bram'

" Not easy to read
echo printf('Hi %s', name)

" ↓ Easy to read ↓
echo $'Hi {name}'
```
