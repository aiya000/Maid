## Time script
## - Strong Static Typing with Vim script -

　

### https://bit.ly/2PxJOYe
### aiya000 (@public_ai000ya)

<aside class="notes">
LTを始めさせていただきます。  
「Time script - Strong Static Typing with Vim script -」。  

よろしくお願いします。  
  
（パチパチパチ）  
  
LTですので、スライドをどんどん進めてっちゃいます。
多分見逃すことが多いと思うので、このURLにあるこのスライドを手元でみつつ、聞いてもらえればと思います。
</aside>

- - - - -

# Who are you?

- - - - -

### Who are you?

<div class="profile">
    <div class="left">
        ![profile-image](profile.png)
    </div>
    <div class="right">
        <ul>
            <li>name: aiya000 (@public_ai000ya)
                <ul>
                    <li>**Haskell**</li>
                    <li>Vim script</li>
                    <li>TypeScript</li>
                    <li>Category Theory</li>
                </ul>
            </li>
        </ul>
    </div>
</div>

<aside class="notes">
どうも、あいやと申します。  
Haskellをメインで触っていて、その他TypeScriptとVim scriptを触っています。  
  
数学・圏論の初歩入門書を頒布したりもしています。
  
24年間、この声しか出せないと思ってて、この声で生活をしていたのですが、最近「可愛い女の子の声を出したい」と思い、練習していました。
その成果として、低い声を出せるようになりました。  
  
うん……よかった。 ってところで本題に。
</aside>

- - - - -

# What is Time script?

<aside class="notes">
What is Time script?
</aside>

- - - - -

### What is Time script?

- `Vim script` +=
    - **'Strong' Static Typing**
    - **Advanced features**

- Like TypeScript of JavaScript.
- Also Haskell like type systems.

<aside class="notes">
Time scriptとは何か、どんな意義を持つのかっていうのは、簡単で  

「Vim scriptに**静的型付けを導入する**」  
「後方互換性を保全しなければいけないVim script本体に変わって、**後方互換性よりも先進性を優先して、先進的な機能を導入する**」  

という感じです。
今回はその2つについて、紹介します。  

まず最初に言っておかなければいけないのが =>
</aside>

- - - - -

### What is Time script?

- `Vim script` +=
    - 'Strong' Static Typing
    - Advanced features

**Now this is the implementing phase!**

<aside class="notes">
Time scriptはまだ実装中だということです。  
  
ということで =>
</aside>

- - - - -

### What is Time script?

Now, making Vim plugins requires Vim script.
And (not "or")

- ruby
- lua
- python2
- python3
- ...etc

<aside class="notes">
現在Vimプラグインを開発するには、動的型付け言語に頼るのがほとんど主流です。
</aside>

- - - - -

### What is Time script?

Which is **static typing languages**? :thinking_face:

<aside class="notes">
静的型付き言語に頼ることもできなくはないのですが、うーん、大変。  
ということで =>
</aside>

- - - - -

### What is Time script?

:muscle: :muscle: :muscle:  :muscle: :muscle: :muscle:  :muscle: :muscle: :muscle:  
＞＞＞ It's me, **Time script** ＜＜＜  
:muscle: :muscle: :muscle:  :muscle: :muscle: :muscle:  :muscle: :muscle: :muscle:  

<aside class="notes">
Time scriptが、Vim scriptのVimへのフルサポーティングを残しつつ、静的型付き言語の恩恵を与えます！  

次に型と構文について =>
</aside>

- - - - -

### Syntax and Types

Basic types

```vim
let x:  Int    = 42
let s1: String = 'you'
let s2: String = "me"
let y:  Float  = 1.0
let b:  Bool   = v:true
let z1: Null   = v:null
let z2: Null   = v:none
```

These types can show `:help type` on Vim.

<aside class="notes">
これらは「`:help type` に書いてある各型」を調整したものです。
</aside>

- - - - -

### Syntax and Types

```vim
let xs: List String = ['sugar', 'sweet', 'moon']
let d:  Dict Int    = {'foo': 10, 'bar': 20}

let xs: List (List Int) = [
  [0, 1], [0], []
]
```

This design of types is based on Haskell's types.

<aside class="notes">
もちろん、ListやDictもあります。

この型の書き方は、Haskellと同じです。
</aside>

- - - - -

### Syntax and Types

```vim
" Function (Funcref) type
let F: Int -> String          = function('string')
let G: (Int, Int) -> List Int = function('range')

" Same as `Int -> (String -> Bool)`
let h: Int -> String -> Bool = { _ ->
  { _ -> v:true }
}
```

<aside class="notes">
これは関数への付けです。
ここで変数名の「h」が小文字になっていることと、行継続のバックスラッシュが書かれてないのは、あとへの伏線です。
</aside>

- - - - -

### Syntax and Types

Advanced types

```vim
let n: Nat  = 10
let c: Char = 'x'
let a: Any  = 10
```

<aside class="notes">
これらはVim scriptには定義されていない型です。  
  
　  
Natは0以上の数値のみを表します。  
Charは長さ1の文字列。  
  
Anyはいつものやつで、型情報を忘却する、本当は入れたくないやつです。
</aside>

- - - - -

### Syntax and Types

Compile error!

```vim
let n: Nat  = -10   " invalid: negative numbers
let c: Char = 'xaa' " invalid: two or more characters

" In Time script, Dict must be
" accessed by a String index.
let x: Dict Int = {'foo': 10, 'bar': 20}
echo x[0]  " invalid: integral index
```

<aside class="notes">
これらに対して、ちゃんとこんな感じに、コンパイルエラーを出します。
</aside>

- - - - -

### Syntax and Types

Compile error!

```vim
" Any is not the 'top' type.
let a: Any = 10
let b: Int = a  " invalid
```

TypeScript :point_down:

```typescript
" No compile error
let x: any = 10
let y: number = x
```

<aside class="notes">
あとここが大事で、TypeScriptは実はこんな感じにコンパイルを通すのですが、
個人的にすごくよくないので、Time scriptではそうしません。
</aside>

- - - - -

### Syntax and Types

Typing functions

```vim
" abort by default
function F(x: Int): String
  if a:x is 0 | throw 'rejected' | endif
  echo 'bad'
  return string(x)
endfunction
echo F(0)  " Error! 'rejected'
           " (No 'bad')
```

<aside class="notes">
関数の型です。
デフォルトでabortにします。
abortっていうのは、例外が送出されたときに、後続の処理を行わないやつですね。
</aside>

- - - - -

<!-- ### Syntax and Types -->
<!--  -->
<!-- Typing functions -->
<!--  -->
<!-- ```vim -->
<!-- " Options is embraced by -->
<!-- " [] (traditional options) or -->
<!-- " [[]] (Time script's options). -->
<!-- function x.f(): Bool [dict] [[no-abort]] -->
<!--   return v:true -->
<!-- endfunction -->
<!-- ``` -->
<!--  -->
<!-- <aside class="notes"> -->
<!-- Vim scriptとTime scriptの関数オプションはこんな感じに指定します。 -->
<!-- </aside> -->
<!--  -->
<!-- - - - - - -->

### Syntax and Types

```vim
" Union types
let foo: Int | Null = v:null

" N-dimension tuples
let t: Tuple Char Nat        = ['a', 97]
let u: Tuple Int String Bool = [-10, 'me', v:true]
```

<aside class="notes">
あとは和型と、N次元のタプルも、もちろんサポートします。
</aside>

- - - - -

# Another advanced features

<aside class="notes">
最後に、「先進的機能」について。
</aside>

<!-- - - - - - -->
<!--  -->
<!-- ### Another advanced features -->
<!--  -->
<!-- String interpolations. -->
<!--  -->
<!-- ```vim -->
<!-- let n: Nat = 10 -->
<!-- echo $'$n ${n + 1}'  " 10 11 -->
<!-- ``` -->
<!--  -->
<!-- <aside class="notes"> -->
<!-- 皆大好きなやつです。 -->
<!--  -->
<!-- でもこれはもう僕がVim本体にパッチを書いて送ったので、 -->
<!-- Time script側では実装しないかもしれません。 -->
<!-- </aside> -->

- - - - -

### Another advanced features

Don't require **unnecessary back-slashes** on trivial cases.

```vim
let xs: List Int = [
  10  " In Time script
]
```

```vim
let xs: List Int = [
\   10
\ ]  " In Vim script

```

<aside class="notes">
これ、関数型のところで伏線っていってたやつです。  
Vim scriptって自明な箇所でも、行継続のためにバックスラッシュを書かないといけないのですが、
Time scriptはこれを必要としません。  
個人的にはすっっっっっごく推しポイントです！
</aside>

- - - - -

### Another advanced features

Don't require **unnecessary quotes 'on `{}` notation'** dicts.

```vim
echo {foo: 10}  " {'foo': 10}
```

Also allowing **mixin names** both quoted and not quoted.

```vim
let x = { aaa: 'caramel', 'keba-b': 'sweet' }
```

<aside class="notes">
これは最近Vim scriptにも シャープブロックブロックっていう記法で、キーの名前にクオートを必要しなくなったのですが、
後方互換性のためにシャープを先頭につける必要があったり、クオートをつけるケースと混在させられなかったりします。  
  
Time scriptはこれらの混乱を統合して、このように書くことができるようにします。
</aside>

- - - - -

### Another advanced features

Allowing to **names of non upper cases** `[a-z_]+` for function references.

In Time script :point_down:

```vim
let to_string = function('string')  " OK
let ToString = function('string')   " OK
```

In Vim script :point_down:

```vim
let to_string = function('string')  " runtime error!!
let ToString = function('string')   " OK
```

<aside class="notes">
さいご！
これも先程、伏線として書いておいたのですが……  
  
Vim scriptでは関数参照への変数は大文字スタートで名付ける必要があって、これは個人的な実行時例外の温床になっています。  
ということで賛否両論だとは思いますが、その制限をとっぱらっちゃいます。  
  
というところで……
</aside>

- - - - -

:point_right: Thanks! :point_right:

<aside class="notes">
以上です！

**その他色んな、超強力な機能を書いてありますので、GitHubリポジトリのREADMEを見てみてください。**
</aside>

- - - - -

Please give me stars to increase my development!  
🤟🙄🤟

[https://github.com/aiya000/hs-time-script](https://github.com/aiya000/hs-time-script)

:point_up: :point_up: :point_up:

<aside class="notes">
よければStarください。
ご清聴ありがとうございました！
</aside>
