## Time script
## 〜静的型付きVim script〜
## 予告編

- - - - -

# Time scriptとは？

- - - - -

# Vim scriptに静的型付けを加えたやつ

- - - - -

# 先進的な機能を加えたやつ

- - - - -

### Vim scriptに静的型付けを加えたやつ

Vimプラグインを開発するには（主に）  
Vim scriptで書くことが必要。

- or ruby, lua, python2, python3

- - - - -

### Vim scriptに静的型付けを加えたやつ

静的型付き言語による開発が無理では？ :thinking_face:

- - - - -

### Vim scriptに静的型付けを加えたやつ

Vim scriptにコンパイルする  
静的型付き言語を開発すればいい

:point_up: :point_up:

- - - - -

### Vim scriptに静的型付けを加えたやつ

現行の意味論

`:help type` に書いてある型

```vim
let x: Int     = 42 " Vim's Number type
let s1: String = 'you'
let s2: String = "me"
let y: Float   = 1.0
let b: Bool    = v:true
let z1: Null   = v:null " None type
let z2: Null   = v:none "
```

- - - - -

### Vim scriptに静的型付けを加えたやつ

```vim
let xs: List String  = ['sugar', 'sweet', 'moon']
let ys: Dict Int     = {'foo': 10, 'bar': 20}
" Funcref type
let F: Int -> String = function('string')
```

- - - - -

### Vim scriptに静的型付けを加えたやつ

独自の型

```vim
let n: Nat  = 10
let c: Char = 'x'
let a: Any  = 10
```

- - - - -

### Vim scriptに静的型付けを加えたやつ

```vim
" Union types
let foo: Int | Null = v:null

" N-dimension tuples
let t: Tuple Char Nat        = ['a', 97]
let u: Tuple Int String Bool = [-10, 'me', v:true]
```

- - - - -

### Vim scriptに静的型付けを加えたやつ

関数への型付け

```vim
function! F(x: Int) [String] abort
  return string(a:x)
endfunction
```

- - - - -

# 先進的な機能を加えたやつ

- - - - -

### 先進的な機能を加えたやつ

- String interpolations

```vim
let n: Nat = 10
echo "$n ${n + 1}" " !!
" 10 11
```

- - - - -

### 先進的な機能を加えたやつ

- 自明な文脈（括弧中など）でのバッククォートを省略

```vim
let xs = [
  10, 20, 30,
]

echo map(xs, { _, x ->
    f(x) + g(x)
})
```

- - - - -

### 先進的な機能を加えたやつ

- ディクショナリでの自明なクオーテーションの省略

```vim
let x = {foo: 10} " !!
echo x == {'foo': 10}
" 1
```

- - - - -

### 先進的な機能を加えたやつ

- 関数型変数に対してのsneak\_case

```vim
let to_string = function('string')
```

- - - - -

Thanks.

🤟🙄🤟
