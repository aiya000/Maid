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
distributiveLaw :: (Rng a, Eq a) => a -> a -> a -> Bool
distributiveLaw x y z =
  x >< (y <> z) == x >< y <> x >< z
    &&
  (y <> z) >< x == y >< x <> z >< x
class Rng a where
    (<>)     :: a -> a -> a
    emptyA   :: a
    inverseA :: a -> a
    (><)     :: a -> a -> a

infixl 6 <>
infixl 7 ><
-- 10 * (20 + 30)  =  (10*20) + (10*30)
--                 =  500
instance Rng Integer where
    (<>)     = (+)
    emptyA   = 0
    inverseA = negate
    (><)     = (*)
instance Rng Rational where
    (<>)       = (+)
    emptyA     = 0 % 1
    inverseA x = denominator x % numerator x
    (><)       = (*)
-- True && (False `xor` True)
--      = (True&&False) `xor` (True&&True)
--      = True
instance Rng Bool where
    (<>)     = xor
    emptyA   = False
    inverseA = id
    (><)     = (&&)
xor :: Bool -> Bool -> Bool
xor True False = True
xor False True = True
xor _ _ = False
instance Rng () where
    () <> ()    = ()
    emptyA      = ()
    inverseA () = ()
    () >< ()    = ()
