<!--

```haskell
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}

module LastHalf where

import Data.Ratio (Rational, (%), numerator, denominator)
import Prelude hiding (Semigroup(..))

newtype Sum a = Sum
    { unSum :: a
    } deriving (Show, Eq)

newtype Product a = Product
    { unProduct :: a
    } deriving (Show, Eq)

deriving instance Num a => Num (Sum a)
deriving instance Num a => Num (Product a)

newtype And = And
    { unAnd :: Bool
    } deriving (Show, Eq)

newtype Or = Or
    { unOr :: Bool
    } deriving (Show, Eq)

newtype Xor = Xor
    { unXor :: Bool
    } deriving (Show, Eq)
```

-->

!INCLUDE "rng.md"

- - - - -

!INCLUDE "ring.md"

- - - - -

!INCLUDE "morphism-monoid.md"

- - - - -

!INCLUDE "field.md"

- - - - -

!INCLUDE "conclusion.md"
