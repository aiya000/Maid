## 僕の推し
## Vimプラグインを見て！
　
#### .vimconf.swp.2018 🤟🙄🤟 aiya000
### https://aiya000.github.io/Maid/vimconf.swp.2018

- - - - -

## 僕
![profile-image](profile.png)

- 推しVim: **NeoVim**
- 名前: aiya000 (あいや)
- Twitter: [pubilc\_ai000ya](https://twitter.com/public_ai000ya)
- GitHub: [aiya000](https://github.com/aiya000)

- - - - -

# Chiel92/
# vim-autoformat

- - - - -

### Chiel92/vim-autoformat

ファイル保存時に  
コードを**整形**して保存してくれる。

<aside class="notes">
こんなコードがあったときに  
（ここで次へ） ->
</aside>

- - - - -

### Chiel92/vim-autoformat

(with elm-format)  
**before**

![](autoformat-before.png)

<aside class="notes">
こんな感じに整形してくれます  
（ここで次へ） ->
</aside>

- - - - -

### Chiel92/vim-autoformat

(with elm-format)  
**after**

![](autoformat-after.png)

- - - - -

### Chiel92/vim-autoformat

**コードフォーマット**に  
気を使いたくない人の必需品。

- - - - -

# LeafCage/foldCC

- - - - -

### LeafCage/foldCC

Vimの**畳み込み**をしたときの  
表示をわかりやすくしてくれる

<aside class="notes">
こんな感じ（ここで次へ） ->
</aside>

- - - - -

### LeafCage/foldCC

<p class="left">
before :point_down:
</p>

![before](foldCC-before.png)
![after](foldCC-after.png)

<p class="right">
:point_up: after
</p>

<aside class="notes">
見ての通り素晴らしい。  
Vim初心者にこそ使ってみて欲しい。
</aside>

- - - - -

# aiya000/
# aho-bakaup.vim

- - - - -

### aiya000/aho-bakaup.vim

ファイル保存時に  
その**バックアップ**として  
別の場所にも保存しておいてくれる。

- - - - -

### aiya000/aho-bakaup.vim

<p class="left">
日別 :point_down:
</p>

![](bakaup-directories.png)
![](bakaup-files.png)

<p class="right">
:point_up: 分別
</p>

<aside class="notes">
こんな感じに保管してくれる。
</aside>

- - - - -

### aiya000/aho-bakaup.vim

まだgit-commitしてないファイルを  
**ふっ飛ばしちゃうアレ**に有効。

```shell-session
$ git status
 M foo.md
 M bar.css
$ git reset --hard HEAD  # 手が勝手に打つ
< foo.mdとbar.cssへの変更が吹っ飛ぶ >

< 数秒後に意識が戻って後の祭り >
```

<aside class="notes">
僕も何度もお世話になった。  
あの絶望を回避したい人は是非に。
</aside>

- - - - -

# aiya000/vim-fmap

- - - - -

### aiya000/vim-fmap

nnoremapとかvnoremapとかみたいに  
fキーにマッピングをかけるやつ

```vim
FNoreMap tt ・
FNoreMap p （
FNoreMap k 「
FNoreMap K 『
```

<aside class="notes">
`df｛IME切り替え｝,｛IME切り替え｝`  
みたいに、  
横移動だけのためにキーを  
いっぱい押すのはめんどかったので  
作った。  
こんな感じ（ここで次へ） ->
</aside>

- - - - -

![](vim-fmap.gif)

- - - - -

### aiya000/vim-fmap

`[f'su`とかすると「す」のところに  
IME切り替えなしでf移動できる🙄

<aside class="notes">
日本語ドキュメント作成や  
日本語本の執筆に便利。
</aside>

- - - - -

# andymass/vim-matchup
# cohama/lexima.vim
# deris/vim-shot-f
# lambdalisue/gina.vim
# lambdalisue/vim-manpager
# lambdalisue/vim-pager

- - - - -

# machakann/vim-highlightedyank
# nathanaelkane/vim-indent-guides
# rbtnn/vimconsole.vim
# rhysd/vim-operator-surround
# ryanoasis/vim-devicons
# thinca/vim-textobj-between
