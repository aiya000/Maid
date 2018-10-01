# Semigroupとは？ Monoid？ 環？
## Haskell Day 2018
## aiya000
## 🤟🙄🤟

- - - - -

## 僕
![profile-image](profile.png)

- 名前: **aiya000** (あいや)
- Twitter: [pubilc\_ai000ya](https://twitter.com/public_ai000ya)
- GitHub: [aiya000](https://github.com/aiya000)

- - - - -

## このスライドで学べること

- ちょっとした前提知識
    - 集合
- 代数の素朴な定義
    - マグマ・**半群**・**モノイド**・**群**
    - 擬環・**環**・**体**

- - - - -

# ちょっとした
# 前提知識

- - - - -

# 集合

- - - - -

## ちょっとした前提知識 - 集合

集合X は xとyとz を **含む**

```
X = { x, y, z }
```

:point_up: こういうやつ

- - - - -

## ちょっとした前提知識 - 集合

集合Int は
**-1より下**,
-1, 0, 1,
**1より上**
を含む

```
X = { x, y, z }
```

- - - - -

## 半群

- マグマであって半群でない例
    - Double, Float（浮動小数点数）
    - ``

<!-- 結合法則の最適化 -->
<!-- http://www.kmonos.net/wlog/121.html -->
