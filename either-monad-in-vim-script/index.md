# Either Monad in Vim script

- VimConf2017
- aiya000

- - - - -

# 僕
![profile-image](profile.png)

- 名前
    - aiya000
- Twitter
    - pubilc\_ai000ya

- - - - -

# 僕

- 😂 声高い

- - - - -

# 僕

- ✌ Haskell `=<<`
    - 過去にHaskellに救われた経験がある
    - [hs-zuramaru](https://github.com/aiya000/hs-zuramaru)

- - - - -

# 今日

Vim scriptにモナドを持ってきました。

- - - - -

# 今日

Eitherを使ったプログラム

```vim
let s:V = vital#vital#new()
let s:E = s:V.import('Data.Either')
let s:H = s:V.import('Web.HTML')

let page_or_err = s:fetch_my_posts()
let titles_or_err = s:E.map(page_or_err, function('s:get_post_titles'))
let first_monad_post_or_err = s:E.flat_map(titles_or_err, {titles ->
    \ s:E.null_to_left(
    \     get(filter(titles, 'v:val =~ "monad"'), 0, v:null),
    \     "monad post couldn't be found"
    \ )})
echo first_monad_post_or_err
```

- - - - -

# 今日

結果

```
{'either_right_value': 'lens（のMonadState演算子など）で自己に言及したい時はidを使う'}
```

- - - - -

# 何？

Eitherモナド

- - - - -

# モナド（Either）

- 効能
    - プログラムを関数単位に分割して、メンテナンスアビリティを上げる

- - - - -

# 関数を使う側は簡単なコードになる

```vim
let s:V = vital#vital#new()
let s:E = s:V.import('Data.Either')
let s:H = s:V.import('Web.HTML')

let page_or_err = s:fetch_my_posts()
let titles_or_err = s:E.map(page_or_err, function('s:get_post_titles'))
let first_monad_post_or_err = s:E.flat_map(titles_or_err, !...!)  " !...!はλ関数
echo first_monad_post_or_err
```

- - - - -

# 関数を使う側は簡単なコードになる

使う側に分岐がない

- - - - -

# 自ずと関数分割されるコードになる

```vim
function! s:fetch_my_posts() abort
    try
        let result = s:H.parseURL('http://aiya000.github.io/archive.html')
        return s:E.right(result)
    catch
        return s:E.left("http://aiya000.github.io/archive.html couldn't be gotten")
    endtry
endfunction
```

- - - - -

# 自ずと関数分割されるコードになる

```vim
function! s:get_post_titles(dom) abort
    let xs = []
    for post in a:dom.child[3].child[3].child[3].child
        try
            let title = post.child[1].child[0]
            call add(xs, title)
        catch
        endtry
    endfor
    return xs
endfunction
```

- - - - -

# 自ずと関数分割されるコードになる

そしてコードに平穏が訪れる

- - - - -

# モナドを使おう

- - - - -

# モナドは難しくないんだ

- - - - -

# 頼む、モナドを受け入れてくれ…

- - - - -

# ありがとうございました
