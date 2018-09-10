## Haskellで依存型と
## コンパイル時
## インラインlisp
## 🤘😋🤘

- https://github.com/aiya000/hs-zuramaru

- - - - -

## 今日の内容

Haskellでの依存型のすごいところ  
（一例の紹介）

1. 自作Lisp処理系
1. Haskellの依存型の概要
1. Haskellの依存型 + 自作Lisp処理系
    - = コンパイル時インラインLisp

- - - - -

## 今日の内容

Haskellでの依存型のすごいところ

コンパイル時に…

- Lispコードの実行 &  
  コンパイルエラー化
- その実行結果を  
  Haskellコードに埋め込み

- - - - -

## 僕
![profile-image](profile.png)

- 名前: aiya000
- Twitter: [pubilc\_ai000ya](https://twitter.com/public_ai000ya)
- GitHub: [aiya000](https://github.com/aiya000)

- - - - -

## 技術書典5

当選しました、よろしくお願いします 🤘🙄🤘

![サークルカット](circle-cut.png)

- - - - -

# 自作Lisp処理系（[zuramaru](https://github.com/aiya000/hs-zuramaru)）

- - - - -

## 自作Lisp処理系（[zuramaru](https://github.com/aiya000/hs-zuramaru)）

```
$ stack exec maru

zuramaru> (+ 10 20)
30

zuramaru> '(10 20)
(10 20)

zuramaru> (def! x 10)
10

zuramaru> x
10
```

- - - - -

## 自作Lisp処理系（[zuramaru](https://github.com/aiya000/hs-zuramaru)）

```
zuramaru> (print 'hello)
hello()
     ^^ REPLが表示した戻り値（nil）
^^^^^ 出力（hello）

zuramaru> (let* (x 10) x)
10

zuramaru> ((fn* (a) (+ a 100)) 200)
300

zuramaru> (if nil 5 15)
15
```

- - - - -

## 自作Lisp処理系（[zuramaru](https://github.com/aiya000/hs-zuramaru)）

```
zuramaru> (do (def! id (fn* (a) a)) (print (id 252)))
252()

zuramaru> (id 72)
72
```

- - - - -

## 自作Lisp処理系（[zuramaru](https://github.com/aiya000/hs-zuramaru)）

再帰以外ひと通りできる

↑
無限再帰しないから多分  
コンパイルが停止するし  
ちょうどいいね🤔

- - - - -

# Haskellの依存型

- - - - -

## Haskellの依存型

`DataKinds` + singleton-types

```haskell
print $ natVal (Proxy :: Proxy 10)

print $ natVal (Proxy :: Proxy (20 + 30))

putStrLn $ symbolVal (Proxy :: Proxy "poi")
```

- - - - -

## Haskellの依存型

```haskell
-- 型10から値10を抜き出し
natVal (Proxy :: Proxy 10)

-- 自然数の型レベル計算(+)
natVal (Proxy :: Proxy (20 + 30))

-- 文字列も使える
symbolVal (Proxy :: Proxy "poi")
```

- - - - -

# Haskellの依存型
# +
# 自作Lisp処理系

- - - - -

## Haskellの依存型 + 自作Lisp処理系

- レベル1: parse
    - コンパイル時にASTを展開

- コードを（依存）型に解釈する
- コードが異常ならコンパイルエラー

- - - - -

## Haskellの依存型 + 自作Lisp処理系

```haskell
                         これは型！
                      vvvvvvvvvvvvvvvv
>>> fromSing (sing :: Sing [parse|10|])
AtomInt 10

>>> fromSing (sing :: Sing [parse|x|])
AtomSymbol "x"
```

- - - - -

## Haskellの依存型 + 自作Lisp処理系

```haskell
>>> fromSing (sing :: Sing [parse|'x|])
Quote (AtomSymbol "x")

>>> fromSing (sing :: Sing [parse|(1 2 3)|])
Cons (AtomInt 1)
    (Cons (AtomInt 2)
    (Cons (AtomInt 3) Nil))
```

- - - - -

## Haskellの依存型 + 自作Lisp処理系

これくらいならできて当然のコンパイル時処理やろ🤔

- - - - -

## Haskellの依存型 + 自作Lisp処理系

- レベルn: zura
    - コンパイル時にコードを実行

- コンパイル時IO
- 実行の結果を（依存）型に解釈する

- - - - -

## Haskellの依存型 + 自作Lisp処理系

```haskell
>>> fromSing (sing :: Sing [zura|'(10)|])
Cons (AtomInt 10) Nil

>>> fromSing (sing :: Sing [zura|(print 10)|])
10Nil
  ^^^ fromSingの結果
^^
コンパイル時に出力された "10"
```

- - - - -

## zuramaru + 依存型

- 実行が失敗したらコンパイルエラー

```haskell
>>> fromSing (sing :: Sing [zura|(10)|])

error:
- Maru.QQ.zura: an error is occured
    in the compile time: EvalException:
"expected a symbol of either a function or a macro,
    but got `10` in `(10)`"
- In the quasi-quotation: [zura|(10)|]
```

- - - - -

## 今日の内容

Haskellでの依存型すごくないですか？

- コンパイル時にLispコードの実行 &  
  妥当性チェック
- Lispコードの実行結果をHaskellコードに  
  埋め込み

- - - - -

## おわり
技術書典5よろしく！

![サークルカット](circle-cut.png)
