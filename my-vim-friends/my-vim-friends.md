# 僕の友達を紹介するよ
## 僕の開発用プラグイン達
- VimConf2016
- aiya000

- - - - -

# このスライドについて
- 開発者として推したい、開発用Vimプラグインの紹介

- - - - -

# 僕
- 名前
    - **aiya000**
- Twitter
    - pubilc\_ai000ya
+ **Vim歴3年くらい**
    - いつVimを使い始めたのか覚えてない
    - 学生時代、知らないうちにVimを使い始めていた

- - - - -

# 僕
- **どの言語**でもVimでC#を書いている
- やっぱりエディタはVimに限るね！  
  余裕の迫力だ、**編集力**が違いますよ
    - VisualStudio等のIDEは  
      便利なGUIビルドツールとして使っている

- - - - -

# 僕
- 最近**Haskell**ばっかり書いてる
+ 好きな言語
    - **Haskell**
    - C#
    - Scala
- ただいま**NEET**
    - どっかバイトでコード書けるところないですか？ ＞＜


- - - - -

# 紹介するやつ
+ Vimプラグイン
    - vim-alignta
    - undotree
    - vim-textobj-indent
    - [aref-web.vim](http://github.com/aiya000/aref-web.vim)
    - vim-haskell-indent

- - - - -

# 紹介するやつ
+ Vimプラグイン
    + unite.vim
        - unite-outline
        - unite-session


- - - - -

# vim-alignta
**テキストの書式を整える**プラグイン  
変数宣言の`=`やコメントの`//`などの位置を整えられたりする

`:Alinta =/1`

![ex-vim-alignta](ex-vim-alignta.gif)

- - - - -

# undotree
**`undotree()`のGUI？フロントエンド**  
undofileが記憶しているうちの  
任意の時点にファイルを戻せる

`:UndotreeShow`

![ex-undotree](ex-undotree.gif)

- - - - -

# vim-textobj-indent
**同じインデントのブロック**を選択するtextobj  
空行で区切られたセンテンスを選択するのにも利用できる

`<Plug>(textobj-indent-a)`  
`<Plug>(textobj-indent-i)`

- - - - -

- for
    - C++, Scala
    - python, Haskell
    - markdown, plain text
    - and etc...

![ex-vim-textobj-indent](ex-vim-textobj-indent.gif)

- - - - -

# aref-web.vim
**僕が作った。**

定義済みの**Webページを非同期でバッファに取得**する

- Weblioで和英辞書引いたり
- HaskellのHackage引いたり

![ex-aref-web.vim.gif](ex-aref-web.vim.gif)

- - - - -

# vim-haskell-indent
Haskellのコーディング時に  
決まった形でオートインデントしてくれる  
**Haskellに特化したオートインデント**

![ex-vim-haskell-indent](ex-vim-haskell-indent.gif)


- - - - -

# unite.vim + unite-outline
**編集中のコードの目次を表示してくれる**

- ソース内の関数を一覧表示できる
- ソース内の関数を自由に移動できる

`:Unite outline`

![ex-unite-outline](ex-unite-outline.gif)

- - - - -

# unite.vim + unite-session
- **開いている状態(開いているウィンドウ,タブ等)を保存**できる
- 保存したセッションを再度開ける

`:UniteSessionSave {session-name}`  
`:UniteSessionLoad {session-name}`

![ex-unite-session](ex-unite-session.gif)

- - - - -

# おわり
- 使ってみてね
- **aref-web.vim**使ってみてね！！

![ex-aref-web.vim.gif](ex-aref-web.vim.gif)
