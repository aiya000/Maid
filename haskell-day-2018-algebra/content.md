<!--

```haskell

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}

module HaskellDay where

import Control.Monad (MonadPlus(..), guard)
import Data.Numbers.Primes (primes)
import Data.Ratio (Rational, (%), numerator, denominator)
import Prelude hiding (Semigroup(..), Monoid(..))

```

-->

　
# **Semigroupとは？ Monoid？ 環？**
　
### Haskell Day 2018 🤟🙄🤟 aiya000
### https://aiya000.github.io/Maid/haskell-day-2018-algebra

<aside class="notes">
今日は「Semigroupとは？ Monoid？ 環？」ということで、
Haskellでの、
代数という概念についての紹介をさせていただきます。
よろしくお願いします！
</aside>

- - - - -

!INCLUDE "introduction.md"

- - - - -

# 代数の素朴な定義

- - - - -

!INCLUDE "magma.md"

- - - - -

!INCLUDE "instances.md"

- - - - -

!INCLUDE "semigroup.md"

- - - - -

!INCLUDE "monoid.md"

- - - - -

!INCLUDE "monad-plus.md"

- - - - -

!INCLUDE "group.md"

- - - - -

!INCLUDE "summary-first-half.md"

- - - - -

!INCLUDE "rng.md"

- - - - -

!INCLUDE "morphism-monoid.md"

- - - - -

!INCLUDE "ring.md"

- - - - -

!INCLUDE "field.md"

- - - - -

!INCLUDE "conclusion.md"

- - - - -

# おわり

- - - - -

## 宣伝

「今回話したこと + もうちょっとわかりやすい説明」を教えてくれる本
🤟🙄🤟

<!-- TODO: ここにURL -->
