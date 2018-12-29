# Haskellのおいしいところ

- 2019-06-08
- aiya000

- - - - -

## 僕

<img src="./profile.png" class="profile" />
- 名前
    - aiya000
- Twitter
    - pubilc\_ai000ya
    - よかったらフォローしてね！

- - - - -

## 僕

こういう数学の本を書いてます。

<div>
    <img src="./cover.png" class="book" />
    <img src="./backcover.png" class="book" />
</div>

- - - - -

## Haskell

- プログラミング言語
- オブジェクト指向ではない
- バグを出しにくい

```haskell
main :: IO ()
main = do
    let message = "Hello, world!"
    putStrLn message
```

<aside class="notes">
今日お話しするのはHaskellというプログラミング言語についてです。

Haskellはだいたいこの3つの感じの言語です。
</aside>

- - - - -

## Haskell

- **プログラミング言語**
- **オブジェクト指向ではない**
- バグを出しにくい

<aside class="notes">
まずHaskellはどんな言語なのか？
というと
</aside>

- - - - -

## Haskell - プログラミング言語

```haskell
main :: IO ()
main = do
    let hello = "Hello, " -- 変数代入
    let ten = show 10     -- 関数呼び出し
    let thWorld = "-th world!"
    let message = hello ++ ten ++ thWorld -- 文字列の足し合わせ
    putStrLn message  -- 画面に出力
```

<aside class="notes">
こんな感じの普通の言語です。
mainっていうのが、Javaのpublic static void mainや、C++のmainみたいなものです。

こんなじに、変数代入や関数呼び出し、足し算などの機能もあります。
普通の言語ですね。
</aside>

- - - - -

## Haskell - プログラミング言語

`foo.bar` のようなメソッド呼び出しや、
状態を保持するオブジェクトの生成は、
言語機能としてはない。

```haskell
main :: IO ()
main = do
  let hello = "Hello, " -- 変数代入
  let ten = show 10     -- 関数呼び出し
  let thWorld = "-th world!"
  let message = hello ++ ten ++ thWorld -- 文字列の足し合わせ
  putStrLn message  -- 画面に出力
```

<aside class="notes">
Javaなどと違って、オブジェクト指向は採用していません。

ただしオプショナルでオブジェクト指向にできたり、様々なスタイルを採用できます。
つまり自由度が高いってことです。
</aside>

- - - - -

## Haskell

- プログラミング言語
- オブジェクト指向ではない
- **バグを出しにくい**

<aside class="notes">
Haskellはバグを出しにくい言語です。

「バグを出しにくい」

そんな馬鹿な……？
って思ったでしょ。

本当です。
</aside>

- - - - -

## Haskell - バグを出しにくい

なぜか？

- コンパイル時に誤りを**めっちゃ**検出する

```haskell
main :: IO ()
main = do
  let x: Maybe Int = something 42 -- nullかもしれない値x
  print $ x + 10
-- エラー！　nullかもしれない値と数を足し合わせることはできない。
```

<aside class="notes">
例えばxっていう「nullかもしれない値」があって、
これは10と足し合わせられません。
`null + 10`が何になるのか、わからないので。

これをHaskellは実行せずに、コンパイルしたときにエラーを吐きます。
</aside>

- - - - -

## Haskell - バグを出しにくい

- コンパイル時に誤りを**めっちゃ**検出する

```haskell
ネットワークを使わない処理 :: Int -> m Int
ネットワークを使わない処理 num = do
  x <- fetchFromNetwork num -- ネットワークを使う処理fetchFromNetwork
  print x
-- エラー！
-- 「ネットワークを使わない処理」で、間違えて
-- 「ネットワークを使う処理」を使ってしまっている。
```

<aside class="notes">
さらにHaskellは、その関数ができることを制限できます。
例えばネットワークを使わない処理を書いているつもりなのに、
いつのまにかネットワークを使う処理を書いてしまっていたら、
それは誤り検知にひっかかります。

ネットワークを使う処理を書く場合は、それをちゃんと示してあげなければいけません。
</aside>

- - - - -

# つまりどういうことか？

- - - - -

# Haskellを使えばバグが出にくい

- - - - -

### よくある勘違い

- Haskell**むずかしそう**
    - Java・JavaScriptやScalaにべたら**簡素**な言語です
- **数学的な知識**が必要って聞いた
    - プログラミング周りの知識以外、**必要ない**です

- - - - -

# まとめ

- - - - -

# Haskellを使いましょう

- - - - -

# ありがとうございました！
