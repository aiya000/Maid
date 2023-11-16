## Boost your vimrc with some template techniques!

- 2023-11-18
- aiya000（[@public\_ai000ya](https://twitter.com/public_ai000ya)）

<a style="position: absolute; bottom: -2; left: 0; width: 150px; height: auto;" href="https://aiya000.github.io/Maid/Boost-your-vimrc-with-some-template-techniques/#/">
<img src="qrcode-to-zenn.png">
</a>
<!-- 
<img src="qrcode.png">
-->

　

← This session's slide

<!-- 今回のキーワード

nice

# 👍

-->

<aside class="notes">
こんにちは、aiya000と申します。
これから「Boost your vimrc with some template techniques!」という発表をさせていただきます。
よろしくお願いします。 <br />
ちなみに今回の資料はzennにアップしています。
よかったらQRコードからアクセスしてみてください。
</aside>

- - - - -

# What is this session?

<aside class="notes">
さて、この発表が何かというと
</aside>

- - - - -

## What is this session?

- Learn how to **refine** your vimrc
- using some **techniques**

<aside class="notes">
.vimrcをよくしていく方法と、そのテクニックについて話していきます。
</aside>

- - - - -

# Me

<aside class="notes">
その前に、まず自己紹介をさせてください。
</aside>

- - - - -

## Me

<img src="../shared/me-mu2.jpg" style="position: absolute; top: 0px; right: -100px; width: 250px; height: auto;" />

- Name
    - aiya000
- Twitter
    - [@pubilc\_ai000ya](https://twitter.com/public_ai000ya)
- High tone Peter Pan 🤔

<aside class="notes">
僕の名前はaiya000と申します。
だいたいの人は「あいや」と呼んでくれています。 <br />
常に裏声で生活をしている、変なおじさんです。
よろしくお願いします。
</aside>

- - - - -

## Me

<img src="../shared/me-mu2.jpg" style="position: absolute; top: 0px; right: -100px; width: 250px; height: auto;" />

- Name
    - aiya000
- Like
    - Strong static typed languages
        - **TypeScript**, **Haskell**, Idris, Scala3
    - Math
        - Categoroy theory, Algebraic structure  
          ↑ a little bit :)

<aside class="notes">
好きなものは、強い静的型付き言語と、その型システムです。
必ずしも使用経験があるわけではないですが、**TypeScript**, **Haskell**, Idris, Scala3などが好きです。 <br />
TypeScriptは実務でガリガリにやっています。
Haskellについては過去にガリガリやっていました。
僕のふるさとはHaskellです。 <br />
<br />
数学も好きで、趣味でやっています。
圏論と代数を少しやっています。
</aside>

- - - - -

## Me

- I also love in **Vim** ;)

<aside class="notes">
そしてもちろん、Vimがだいすきです。 <br />
僕がパワーでハラスメントな会社で働いていたときは、
上司の目を盗んで、
Vimのヘルプを読んで心の安寧を得ていました。
</aside>

- - - - -

## Me

My works!

<div>
    <a href="https://aiya000.booth.pm/items/1298622"><img src="../shared/setulab-cover.png" class="book" /></a>
    <a href="https://aiya000.booth.pm/items/1298622"><img src="../shared/setulab-backcover.png" class="book" /></a>
</div>

<aside class="notes">
あとは……
せつラボっていう本を出しています。
数学がわからないけど、入門したい！
圏論に入門したいけど、難しい！
という人向けに書きました。
数学の前提知識を仮定しない、全てこの本の中で説明する内容になっています。
なので初心者向けです。<br />
<br />
僕のzennのプロフィールにある、Twitterアカウントからこの商品をたどれるので、よかったら見てくれるとうれしいです！
サンプルで、集合論とHaskellについてをまるまる解説しています。
</aside>

- - - - -

## Me

Latest works!

<div>
    <a href="https://aiya000.booth.pm/items/5138923"><img src="../shared/setulab2-cover.jpg" class="book" /></a>
    <a href="https://aiya000.booth.pm/items/5138923"><img src="../shared/setulab2-backcover.jpg" class="book" /></a>
</div>

<aside class="notes">
こちらはさきほどの本の続きで、圏論をやるにあたって、あると満足できる知識を書いた本です。
こちらも購入とか、Boothでスキをしてくれると、とってもよろこびます！ <br />
</aside>

- - - - -

nice

# 👍

<aside class="notes">
いいね！
</aside>

- - - - -

#### HIKKY, Inc.

![](vketcloud.png)

<aside class="notes">
最後の宣伝をさせてください。
このスライドは、株式会社HIKKYの業務時間の一部を使って書かれました。
</aside>

- - - - -

#### HIKKY, Inc.

A company which is holding **Vket** on VRChat.

<aside class="notes">
HIKKYは、VketというイベントをVRChat上で開催している会社です。
</aside>

- - - - -

#### HIKKY, Inc.

[Vket Cloud](https://cloud.vket.com/)

[![](vketcloud.gif)](https://cloud.vket.com/)

- A **metaverse** development platform
- For PC, smartphones, tablet devices
- **Free** (for persons)

Try now: [My Vket](https://vket.com)

<aside class="notes">
事業としてVket Cloudというものを展開しています。
これを使うと、いわゆるメタバース、アバターを使って人としゃべったり遊んだりする空間を、作れます。
ブラウザがまともに動く環境なら、Vket Cloudは動きます。
スマホでも動くメタバースプラットフォームが作れます。 <br />
個人はフリーです。
商用も比較的安いです。 <br />
自由に試せるので、もしよかったら試してみてください。
My Vketという、Vket Cloudを活用したサイトでVket Cloudを試せるので、こちらもよかったら試してみてください。
</aside>

- - - - -

## Boost your vimrc with
## some template techniques!

<aside class="notes">
というところで、
前置きが長くなりましたが、
発表を始めていきます。
よろしくお願いします！
</aside>

- - - - -

## autoload, plugin, vimrc

<aside class="notes">
まずはautoload, plugin, vimrc、というファイル構成の話です。
</aside>

- - - - -

#### autoload, plugin, vimrc

In vimrc,  
function and command delcrations  
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
command! -bar GitAddAllAsync call s:job_start_simply(['git', 'add', '-A'])
" ... and a lot of commands.

let s:root = call s:read_git_root()
" ... others
```

<aside class="notes">
皆さんまず最初にVimに入門したら、.vimrcを書くと思います。
ええ、わかります。
vimrcは楽しいものです。 <br />
でも何も考えずにvimrcを書いていると、
このように行がかさんでしまいますね。
3000行とかも行く人もいるんじゃないでしょうか。
</aside>

- - - - -

#### autoload, plugin, vimrc

You can use **~/.vim/autoload** and **~/.vim/plugin** directory.

```
$HOME
|- .vim
   |- autoload
   |- plugin
```

<aside class="notes">
そこで、vimrcをautoload, plugin, vimrcの3つに分けましょう、という話です。 <br />
これはVimに備わっている機構で、簡単に言うとautoloadには関数を、pluginにはコマンドを書くことができます。
なんでもかんでもvimrcに書くよりは、とてもいいと思われます。
モジュール分割ですね。
</aside>

- - - - -

#### autoload, plugin, vimrc

**autoload**

- - -

.vim/autoload/vimrc.vim
```vim
function vimrc#read_git_root() abort
    " ...
endfunction

function s:foo() abort
    " a sub function (not be exposed)
endfunction

" ...
```

<aside class="notes">
まず、autoloadです。
先ほど言った通り、ここには関数が書けます。 <br />
見ての通り、vimrc#という名前空間に、関数を置いています。
あとはsプリフィックスを付けると、外部に公開しない、スクリプトローカルな関数が書けます。
</aside>

- - - - -

(Sub namespaces `foo#bar#baz()`)

- - -

.vim/autoload/vimrc/job.vim
```vim
function vimrc#job#start_simply(cmd) abort
    " ...
endfunction

function s:bar() abort
    " a sub function (not be exposed)
endfunction

" ...
```

<aside class="notes">
もちろん、名前空間は掘ることができます。
慣習的に、名前空間を掘ったら、autoload/vimrc/job.vimというように、ファイルパスも同様に掘ります。 <br />
ここではvimrc#jobという名前空間に、start_simplyという関数を定義しています。
もちろんここでも、barというような、privateな関数も置くことができます。
</aside>

- - - - -

**plugins**

<aside class="notes">
次はpluginについてです。  
いわゆる「Vimプラグイン」とはまた違った概念なので、そこは混乱なきようお願いします。
</aside>

- - - - -

.vim/plugin/vimrc.vim
```vim
command! -bar GitPushAsync call s:job_start_simply(['git', 'push'])
command! -bar GitAddAllAsync
    \ call s:job_start_simply(['git', 'add', '-A'])
command! -bar -nargs=1 GitCommitMAsync
    \ call s:job_start_simply(['git', 'commit', '-m', <q-args>])
command! -bar -nargs=1 GitCheckoutAsync
    \ call s:job_start_simply(['git', 'checkout', <q-args>])

" ...
```

<aside class="notes">
pluginには主に、コマンドの定義ができます。 <br />
もちろん他のこともできるのですが、vimrcに関連するものは、コマンドがほとんどだと思います。
</aside>

- - - - -

🙌 Easy to use 🙌

<aside class="notes">
autoloadとpluginのおかげで、モジュール分割ができました！
</aside>

- - -

.vimrc
```vim
let s:root = call vimrc#read_git_root()
" ...
```

On your Vim
```
:GitCommitMAsync awesome
:GitPushAsync
```

<aside class="notes">
あとはこのように、autoloadの関数やpluginのコマンドを使うだけです。
</aside>

- - - - -

#### autoload, plugin, vimrc

- autoload: **functions**
- plugin: **commands**
- vimrc: settings and others

<aside class="notes">
改めて確認してみます。 <br />
autoloadには関数を置きます。
pluginにはコマンドなどを置きます。
そしてvimrcには、それらを使う部分や、その他の部分を置きます。
</aside>

- - - - -

nice

# 👍

<aside class="notes">
ナイスです！
</aside>

- - - - -

#### autoload, plugin, vimrc

- doc, indent, syntax, ftdetect, ftplugin, ...

<aside class="notes">
$HOME配下の.vimディレクトリに置けるものは他にもあるので、よかったら調べてみてください。
</aside>

- - - - -

# String interpolation `$''` `$""`

<aside class="notes">
次は構文についてです。 <br />
まずはstring interpolationについてです。
</aside>

- - - - -

#### String interpolation `$''` `$""`

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

<aside class="notes">
string interpolationは、他言語でtemplate stringなどとして実装されているので、知っている人も多いかもしれません。
これが実は、Vim scriptにも実装されています。 <br />
このように今までは「..」で文字列結合をしていましたが、今は$''を使って、ブラケットで囲むだけで、文字列の中に値を注入することができます。 <br />
かなり見やすいですね！
expand('~')もしなくてよくなりました。
</aside>

- - - - -

```vim
" Better than printf()
let name = 'Vim'

" Not easy to read
echo printf('Hi %s', name)

" ↓ Easy to read ↓
echo $'Hi {name}'
```

<aside class="notes">
もちろん、単純なprintfよりも見やすいです。
だいぶいいですね。
</aside>

- - - - -

# Literal Dict `#{}`

<aside class="notes">
次はLiteral Dictです。
</aside>

- - - - -

#### Literal Dict `#{}`

Dict `{}`

```vim
call ddc#custom#patch_global({
    \ 'ui': 'native',
    \ 'sources': ['vim-lsp', 'around', 'neosnippet', 'file', 'buffer'],
    \ 'sourceOptions': {
        \ '_': {
            \ 'matchers': ['matcher_fuzzy'],
            \ 'sorters': ['sorter_fuzzy'],
            \ 'converters': ['converter_fuzzy'],
            \ 'ignoreCase': v:true,
        \ },
        \ 'vim-lsp': #{
" ...
```

<aside class="notes">
皆さん、辞書は使いますよね。
でもちょっとJavaScriptなどとは違って、書きにくいですよね。
</aside>

- - - - -

highlighter to be **Karoshi**

![](./sample-dict.png)

hard to write

<aside class="notes">
クオートが必要で書きにくいし、ハイライティングもまっかっかです。
</aside>

- - - - -

#### Literal Dict `#{}`

```vim
call ddc#custom#patch_global(#{
    \ ui: 'native',
    \ sources: ['vim-lsp', 'around', 'neosnippet', 'file', 'buffer'],
    \ sourceOptions: #{
        \ _: #{
            \ matchers: ['matcher_fuzzy'],
            \ sorters: ['sorter_fuzzy'],
            \ converters: ['converter_fuzzy'],
            \ ignoreCase: v:true,
        \ },
        \ vim-lsp: #{
" ...
```

<aside class="notes">
そこでLiteral Dictです。
Literal Dictは、キーをクオートで囲まずに書けます。
</aside>

- - - - -

Good highlighting!

![](./sample-literal-dict.png)

<aside class="notes">
見てもらうと、きれいなのがわかるかと思います。
ハイライティングもきれいですね。
</aside>

- - - - -

nice

# 👍

<aside class="notes">
いいね！
</aside>

- - - - -

# method `x->Foo(y, z)`

- - - - -

#### method `x->Foo(y, z)`

```vim
function Sum(num, x, y) abort
    return a:num + a:x + a:y
endfunction

echo Sum(10, 20, 30)

" ↑ Same ↓

echo 10->Sum(20, 30)
```

- - - - -

#### method `x->Foo(y, z)`

```vim
" `x` is 1st argument
" `y` and `z` is rest arguments
x->Foo(y, z)

" ↑ Same ↓

Foo(x, y, z)
```

- - - - -

#### method `x->Foo(y, z)`

Where is the method notation useful?

- - - - -

#### method `x->Foo(y, z)`

Easy to read.  
Can read from above to below.

```vim
" Fisrt foo(), next bar(), and then baz()
echo self->foo()
    \ ->bar(x)
    \ ->baz(y)

" If don't use the method notation
echo baz(
      \ bar(
          \ foo(self)
      \ )
\ )
```

- - - - -

# Vim script libraries

<aside class="notes">
というところで、構文や機能についてはここまでにして。 <br />
次はVim scriptの、あるライブラリについて話します。
その名も…
</aside>

- - - - -

# vital.vim

<aside class="notes">
vital.vimです。
</aside>

- - - - -

## vital.vim

Vim script's **semi standard** library,  
from vim-jp.

https://github.com/vim-jp/vital.vim

```vim
let s:List = vital#vimrc#import('Data.List')
let s:Msg = vital#vimrc#import('Vim.Message')
let s:Promise = vital#vimrc#import('Async.Promise')
```

<aside class="notes">
vital.vimはvim-jp製の、Vim scriptの準標準ライブラリです。
例えばリストの操作をするためのモジュールや、
メッセージを扱うモジュール、
非同期処理を扱うモジュールなどがあります。
</aside>

- - - - -

## vital.vim

<img src="./vital1.png" style="width: auto; height: 55vh;" />

<aside class="notes">
READMEを見てもらうとわかるんですが、
その他すごーーーく多くのモジュールが存在しています。
</aside>

- - - - -

## vital.vim

<img src="./vital2.png" style="width: auto; height: 55vh;" />

<aside class="notes">
僕もData.List・Data.EitherやData.Optionalなどなどのモジュールに、
コントリビュートさせていただきました。
</aside>

- - - - -

## vital.vim

<img src="./vital3.png" style="width: auto; height: 30vh;" />

...

And a lot of modules!!

<aside class="notes">
本当に多くのモジュールが存在します。
ぜひVim scriptを書く際には、使うことをおすすめします。
</aside>

- - - - -

## vital.vim

vital.vim is for writing Vim script.  
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

<aside class="notes">
そしてvital.vimを、Vim scriptを書くために使えるということは、
つまり.vimrcを書くためにも使えます。 <br />
例えばこんな感じですね。
</aside>

- - - - -

nice

# 👍

<aside class="notes">
いいですね！
</aside>

- - - - -

#### vital.vim

My favorite modules.

First: **Data.List**

```vim
let s:List = vital#vimrc#import('Data.List')

echo s:List.has([1, 2, 3], 2)
" 1

echo s:List.char_range('a', 'f')
" ['a', 'b', 'c', 'd', 'e', 'f']

echo s:List.count({ x -> x % 2 == 0 }, [1, 2, 3, 4, 5])
" 2
```

<aside class="notes">
僕の好きなモジュールを紹介します。
まずはData.Listです。 <br />
Data.Listには、リストがその要素を持つかを確認するhasや、 <br />
Vim scriptには欲しい、文字の範囲を出力するchar_range、 <br />
条件を満たす要素をカウントするcountがあります。
あとは <br />
</aside>

- - - - -

These are VERY basic functions.

```vim
echo s:List.foldl({ memo, val -> memo + val }, 0, range(1, 10))
" 55
" (= 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10)

echo s:List.intersect(['a', 'b', 'c'], ['b', 'c'])
" ['b', 'c']
```

<aside class="notes">
わかる人にはわかる、畳み込み関数foldl。
もちろんfoldrもあります。<br />
集合の積を取るintersectもあります。 <br />
他にも
</aside>

- - - - -

#### vital.vim

- `pop`, `shift`, `unshift`, `cons`, `uncons`
- `uniq`, `uniq_by`, `sort`, `sort_by`
- `all`, `any`

<aside class="notes">
このような古典的な関数が多くあります。
ここでは説明しきれないくらいあります。
興味があったらぜひ、ご自身で見てみてください。
</aside>

- - - - -

#### vital.vim

**Data.Optional**

<aside class="notes">
次に紹介するのは、Data.Optionalです。
</aside>

- - - - -

#### vital.vim

**Data.Optional**

```vim
let s:Optional = vital#vimrc#import('Data.Optional')

let _1 = s:Optional.none()
" none
let _2 = s:Optional.some(42)
" some(42)
let _3 = s:Optional.new(v:null) " Returns none if v:null, or returns some
" none
let _4 = s:Optional.new(42)
" some(42)
```

<aside class="notes">
これはHaskellやScalaを知っていると、同じく知っているかもしれません。 <br />
「nullもしくはある値」を表す型です。 <br />
ちなみにここでechoではなくletしているのは、echoをすると内部表現が出てくるからです。
これについてはあんまり考えなくていいです！
</aside>

- - - - -

#### vital.vim

```vim
let _1 = v:null
let _2 = 42
```

<aside class="notes">
でも動的型付き言語なら、v:nullと値を素直に使えばいいんじゃないの？
と思いますよね。 <br />
実は……
</aside>

- - - - -

# 😭

<aside class="notes">
その通りです。
</aside>

- - - - -

#### vital.vim

Expression Oriented Programming

```vim
call s:Optional.new(s:read_foo_file_if_exist())
    \ ->s:Optional.flat_map({ foo -> s:parse_foo(foo) })
    \ ->s:Optional.optional(
        \ { parsed -> s:make_parsed_file(parsed) },
        \ { -> execute('echo "Nothing to do"') }
    \ )
```

<aside class="notes">
でももしVim scriptで、ScalaやHaskellのような式指向のプログラミング、
つまり構文ではなく式を使った、冗長さのないショートハンドなプログラミングを行いたい場合は、
役に立つでしょう。 <br />
つまり、行数が少なくなることが期待できます。 <br />
これはfooファイルが存在すれば内容を読み込んで、
その内容をパースして、
パースした結果をファイルに書き込む例です。 <br />
もしfooファイルがなかったり、パースに失敗したりした場合、最終的には何もしません。 <br />
という式指向プログラミングの例でした。 <br />
関数型プログラミングにも通じますね。 <br />
ちなみに余談として、ここのメソッド記法を外してみましょう。
</aside>

- - - - -

#### vital.vim

```vim
call s:Optional.optional(
      \ s:Optional.flat_map(
          \ s:Optional.new(s:read_foo_file_if_exist()),
          \ { foo -> s:parse_foo(foo) })
      \ ),
      \ { parsed -> s:make_parsed_file(parsed) },
      \ { -> execute('echo "Nothing to do"') }
\ )
```

<aside class="notes">
順序が上から下でないので、読みにくいですね。
メソッド記法の重要性がわかりました。
という余談でした。
</aside>

- - - - -

#### vital.vim

```vim
" Folds an optional value to a non optional value
s:Optional.optional(
    \ maybeOptional,
    \ { innerValue -> nonOptionalValue1 },
    \ { -> nonOptionalValue2 }
\ )
```

<aside class="notes">
ちょっと先におおきな塊を出してしまったので、ここで理解のために、Optionalの関数の説明をさせてください。
new関数については、先ほど解説した通りです。 <br />
次にoptional関数ですが、これはOptionalの値をextractするために使われます。
ここのmaybeOptionalがoptionalであれば、Optionalの中のinnerValueを使って、nonOptionalValue1にします。
もしmaybeOptionalがoptionalでなければ、代わりの値、nonOptionalValue2にします。 <br />
結果として、この式はOptionalでない値を返します。
</aside>

- - - - -

#### vital.vim

```vim
" Extracts innerValue, or throws error
get(optional)

" Extracts innerValue, or to be undefined behavior
get_unsafe(optional)

" Extracts innerValue, or returns alternative value (altValue)
get_or(optional, { -> altValue })
```

<aside class="notes">
余談が多いですが、また余談をはさませてください。
optionalの値をextractするには、optional関数以外にも方法があります。
それがget系の関数です。 <br />
これら全て、optionalがoptionalの値の場合はinnerValueを返すのですが、
optionalがinnerValueを持たなかった場合の挙動が違います。 <br />
get()は例外をthrowします。
get_unsafe()は挙動が未定義です。
僕は通常の場合、get_or()をおすすめします。
get_or()はinnerValueがなかった場合、altValueを返します。 <br />
ここまでが、余談でした。
</aside>

- - - - -

#### vital.vim

```vim
let optinoalValue =
    \ s:Optional.flat_map(maybeOptional, { innerValue ->
        \ optinalValue1
    \ })
```

<aside class="notes">
flat_map関数は、maybeOptionalにinnerValueがある場合にそれを使用し、optionalValue1を返します。
この結果、戻り値optinoalValueはoptionalな値です。 <br />
これはモナドという性質によって、担保された関数です。
詳しくは説明しませんが、そう、Optionalはモナドなのです。 <br />
ええ、ここでは忘れていいことです。忘れましょう。
</aside>

- - - - -

#### vital.vim

```vim
" You understood this
call s:Optional.optional(
      \ s:Optional.flat_map(
          \ s:Optional.new(s:read_foo_file_if_exist()),
          \ { foo -> s:parse_foo(foo) })
      \ ),
      \ { parsed -> s:make_parsed_file(parsed) },
      \ { -> execute('echo "Nothing to do"') }
\ )
```

<aside class="notes">
ということで、この式の関数は全て説明しました。
あなたはこれを理解しました。
おめでとうございます！
</aside>

- - - - -

#### vital.vim

**Data.Either**

<aside class="notes">
次はData.Eitherです！
</aside>

- - - - -

#### vital.vim

```vim
" Where is error info...?
call s:Optional.new(s:read_foo_file_if_exist())
    \ ->s:Optional.flat_map({ foo -> s:parse_foo(foo) })
    \ ->s:Optional.optional(
        \ { parsed -> s:make_parsed_file(parsed) },
        \ { -> execute('echo "Nothing to do"') }
    \ )
```

<aside class="notes">
先ほどのOptionalのメソッドチェーンですが、実は情報が足りていません。
そのため、失敗したときのメッセージが「Nothing to do」と、情報量がほとんどないです。
</aside>

- - - - -

#### vital.vim

＞＞＞ Data.Either ＜＜＜

<aside class="notes">
そこで、Data.Eitherです！
</aside>

- - - - -

#### vital.vim

```vim
let s:Either = vital#vimrc#import('Data.Either')

let _1 = s:Either.left('file not found')
" left('file not found')
let _2 = s:Either.right(42)
" right(42)
let _3 = s:Either.null_to_left(v:null, 'it is null')
" left('it is null')
let _4 = s:Either.null_to_left(42, 'it is null')
" right(42)
```

<aside class="notes">
正しい結果をinnerValueに持つEitherの値を、rightの値と言います。
逆に失敗した結果をinnerValueに持つEitherの値を、leftの値と言います。 <br />
rightは英語で「正しい」、leftは英語で「間違った」という意味を持ちますので、
英語の意味にそっているのがわかります。
</aside>

- - - - -

#### vital.vim

Either is Optional with info.

```vim
" Meaning right (correct) foo value, or below error message
let result = s:Either.null_to_left(
    \ s:read_foo_file_if_exist(),
    \ 'file foo is not existent.'
\ )
```

<aside class="notes">
応用に進んでみましょう。
先ほどのOptionalと少し似た例ですが、これはまずfooファイルを読みに行きます。
`s:read_foo_file_if_exist`関数はfooファイルがなければnullを返します。 <br />
このときもし本当にnullが返されれば、resultはエラーメッセージのleftの値になります。
そうでなければ、fooのrightの値になります。 <br />
つまりEitherは、Optionalと違い、失敗したときのためのエラーメッセージを持つということです。
</aside>

- - - - -

#### vital.vim

```vim
let eitherValue =
    \ s:Either.flat_map(maybeRight, { innerValue ->
        \ eitherValue1
    \ })
```

<aside class="notes">
そしてEitherもモナドなので、flat_mapができます。
もちろんモナドについては、今回も忘れていいです。
忘れましょう。
</aside>

- - - - -

#### vital.vim

```vim
" Extracts from a left value, or returns the default value
from_left(defaultValue, either)

" Extracts from a right value, or returns the default value
from_right(defaultValue, either)

" Extracts from a left value, or throws error
unsafe_from_left(either)

" Extracts from a right value, or throws error
unsafe_from_right(either)
```

<aside class="notes">
Eitherにもextractをするための関数があります。
from_leftとfrom_rightは、Optionalのget_orのようなものです。
ここでunsafe_from_leftとunsafe_from_rightは、Optionalのget_unsafeとは違って、未定義動作は起こしません。
例外を送出します。 <br />
Data.Eitherについては以上です。
</aside>

- - - - -

#### vital.vim

**Vim.Message**

<aside class="notes">
頭が疲れてきたので、頭をあんまり使わない、次のモジュールにいきましょう。
</aside>

- - - - -

#### vital.vim

**Vim.Message**

```vim
let s:Msg = vital#vimrc#import('Vim.Message')

call s:Msg.echo('WarningMsg', 'some warning')
" > some warning

call s:Msg.echomsg('ErrorMsg', 'some error')
" > some error

call s:Msg.warn('some warning')
" > some warning

call s:Msg.error('some error')
" > some error
```

<aside class="notes">
Vim.Messageは、Vimのechoを拡張したモジュールです。 <br />
例えばこのように、ワンハンドで警告メッセージやエラーメッセージを出すことができます。
</aside>

- - - - -

Usually, `:echo` is a syntax (a command).  
But Vim.Message allows to use as an **expression**.

```vim
let g:vimrc.open_on_gui =
    \ g:vimrc.is_macos   ? 'open' :
    \ g:vimrc.is_windows ? 'start' :
    \ g:vimrc.is_unix    ? 'xdg-open' :
        \ s:Msg.warn('no method for GUI-open')
```

(Also this is useful than `execute('echo "foo"')`)

<aside class="notes">
先ほど使っていた、execute関数でechoするよりも、モダンでいいですね。 <br />
ちなみにこれらの関数も式として使えるので、このような書き方ができます。
</aside>

- - - - -

nice

# 👍

<aside class="notes">
いいね！
</aside>

- - - - -

nice

# 👍👍👍

<aside class="notes">
いいね！いいね！
</aside>

- - - - -

## Boost your vimrc with
## some template techniques!

<aside class="notes">
というところで、この発表は以上になります。
</aside>

- - - - -

# END

<aside class="notes">
ご清聴ありがとうございました！
</aside>
