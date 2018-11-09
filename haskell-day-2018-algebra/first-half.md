<!--

```haskell

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}

module FirstHalf where

import Control.Monad (MonadPlus(..), guard)
import Data.Numbers.Primes (primes)
import Data.Ratio (Rational, (%), numerator, denominator)
import Prelude hiding (Semigroup(..), Monoid(..))

```

-->

!INCLUDE "magma.md"

- - - - -

!INCLUDE "instances.md"

- - - - -

!INCLUDE "semigroup.md"

- - - - -

!INCLUDE "monoid.md"

- - - - -

!INCLUDE "group.md"

- - - - -

!INCLUDE "abelian.md"

- - - - -

!INCLUDE "half-summary.md"
