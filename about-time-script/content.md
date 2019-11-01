## Time script
## - Strong Static Typing with Vim script -

　

### https://bit.ly/2PxJOYe
### aiya000 (@public_ai000ya)

- - - - -

# What is Time script?

- - - - -

### What is Time script?

- `Vim script` +=
    - **'Strong' Static Typing**
    - **Advanced features**

Like TypeScript of JavaScript.

- - - - -

### What is Time script?

Now, making Vim plugins requires Vim script.
Or

- ruby
- lua
- python2
- python3
- ...etc

- - - - -

### What is Time script?

Which is **static typing languages**? :thinking_face:

- - - - -

### What is Time script?

:muscle: :muscle: :muscle:  :muscle: :muscle: :muscle:  :muscle: :muscle: :muscle:  
＞＞＞ It's me, **Time script** ＜＜＜  
:muscle: :muscle: :muscle:  :muscle: :muscle: :muscle:  :muscle: :muscle: :muscle:  

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

例えばこのString・Bool・Null型はそのままVim scriptにある型で、
このInt・Float型は、Vim scriptにあるnumber型を調整したものになります。
</aside>

- - - - -

### Syntax and Types

```vim
let xs: List String = ['sugar', 'sweet', 'moon']
let d:  Dict Int    = {'foo': 10, 'bar': 20}

" Function (Funcref) type
let F: Int -> String     = function('string')
let G: (Int, Int) -> Int = function('range')
```

- - - - -

### Syntax and Types

Advanced types

```vim
let n: Nat  = 10
let c: Char = 'x'
let a: Any  = 10

" Same as Dict Any
let o: Object = {'foo': 10, 'bar': 'string'}
```

- - - - -

### Syntax and Types

Compile error!

```vim
let n: Nat  = -10   " ! negative numbers
let c: Char = 'xaa' " ! two or more characters

" ! In Time script, Object and Dict must be
"    accessed by an Int or Nat index.
let o: Object = {'foo': 10, 'bar': 'string'}
echo o[0]
```

- - - - -

### Syntax and Types

Compile error!

```vim
" ! Any is not the 'top' type.
let a: Any = 10
let b: Int = a
```

<aside class="notes">
TypeScriptは TODO
</aside>

- - - - -

### Syntax and Types

Typing functions

```vim
" abort by default
function F(x: Int): String
  return string(x)
endfunction
```

- - - - -

### Syntax and Types

Typing functions

```vim
" Options is embraced by
" [] (traditional options) or
" [[]] (Time script's options).
function x.f(): Bool [dict] [[no-abort]]
  return v:true
endfunction
```

- - - - -

### Syntax and Types

```vim
" Union types
let foo: Int | Null = v:null

" N-dimension tuples
let t: Tuple Char Nat        = ['a', 97]
let u: Tuple Int String Bool = [-10, 'me', v:true]
```

- - - - -

# Another advanced features

- - - - -

### Another advanced features

String interpolations.

```vim
let n: Nat = 10
echo $'$n ${n + 1}'  " 10 11
```

- - - - -

### Another advanced features

Don't require **unnecessary back-slashes** on trivial cases.

```vim
let xs = [
  10, 20, 30,
]

echo map(xs, { _, x ->
  f(x) + g(x)
})
```

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

- - - - -

### Another advanced features

Allowing to **names of non upper cases** `[a-z_]+` for function references.

```vim
let to_string = function('string')
" let ToString = function('string')
```

　

(FYI, in Vim script, variables of funcref must be named by `[A-Z][a-zA-Z0-9_]`.)

- - - - -

:point_right: Thanks! :point_right:

- - - - -

Please give me stars to increase my development!  
🤟🙄🤟

[https://github.com/aiya000/hs-time-script](https://github.com/aiya000/hs-time-script)

:point_up: :point_up: :point_up:
