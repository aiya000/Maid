
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}

module FirstHalf where

import Control.Monad (MonadPlus(..), guard)
import Data.Numbers.Primes (primes)
import Data.Ratio (Rational, (%), numerator, denominator)
import Prelude hiding (Semigroup(..), Monoid(..))

class Magma a where
    (<>) :: a -> a -> a

instance Magma Int where
    (<>) = (+)

instance Magma [a] where
    (<>) = (++)
instance Magma Bool where
    (<>) = (&&)

instance Magma Float where
    (<>) = (+)

instance Magma () where
    () <> () = ()
concatL :: Magma a => a -> [a] -> a
concatL = foldl (<>)

concatR :: Magma a => a -> [a] -> a
concatR = foldr (<>)
-- 和 ↓
newtype Sum a = Sum
    { unSum :: a
    } deriving (Show, Eq)
-- 積 ↓
newtype Product a = Product
    { unProduct :: a
    } deriving (Show, Eq)
deriving instance Num a => Num (Sum a)
deriving instance Num a => Num (Product a)

instance Num a => Magma (Sum a) where
    (<>) = (+)

instance Num a => Magma (Product a) where
    (<>) = (*)
newtype And = And
    { unAnd :: Bool
    } deriving (Show, Eq)

instance Magma And where
    And x <> And y = And $ x && y
newtype Or = Or
    { unOr :: Bool
    } deriving (Show, Eq)

instance Magma Or where
    Or x <> Or y = Or $ x || y
newtype Xor = Xor
    { unXor :: Bool
    } deriving (Show, Eq)

instance Magma Xor where
    Xor True  <> Xor False = Xor True
    Xor False <> Xor True  = Xor True
    _ <> _ = Xor False
associativeLaw :: (Semigroup a, Eq a) =>
                  a -> a -> a -> Bool
associativeLaw x y z =
  (x <> y) <> z == x <> (y <> z)
class Magma a => Semigroup a

instance Semigroup (Sum Integer)     -- 10 + 20
instance Semigroup (Product Integer) -- 10 * 20
instance Semigroup (Sum Rational)
instance Semigroup (Product Rational)
 -- (10%20) + (30%40)
 -- (10%20) * (30%40)
instance Semigroup [a]
instance Semigroup And
instance Semigroup Or
instance Semigroup Xor
instance Semigroup ()
concat :: Semigroup a => a -> [a] -> a
concat = foldl (<>)
emptyLaw :: (Monoid a, Eq a) => a -> Bool
emptyLaw x =
  (empty <> x == x) && (x == x <> empty)
class Semigroup a => Monoid a where
  empty :: a

instance Monoid (Sum Integer) where
  empty = Sum 0

instance Monoid And where
  empty = And True
mconcat :: Monoid a => [a] -> a
mconcat = foldl (<>) empty
sum :: [Sum Integer] -> Sum Integer
sum = mconcat
all :: [And] -> And
all = mconcat
instance Monoid (Product Integer) where
  empty = Product 1

instance Monoid (Product Rational) where
  empty = Product $ 1 % 1

instance Monoid [a] where
  empty = []
instance Monoid (Sum Rational) where
  empty = Sum $ 0 % 1

instance Monoid Or where
  empty = Or False

instance Monoid Xor where
  empty = Xor False
instance Monoid () where
  empty = ()
twinPrimes :: [(Int, Int)]
twinPrimes = do
    (x, y) <- zip primes (tail primes)
    guard $ y - x == 2
    return (x, y)
-- [(3,5),(5,7),(11,13),(17,19),(29,31),(41,43), ...]
inverseLaw :: (Group a, Eq a) => a -> Bool
inverseLaw x =
  (x <> inverse x == empty) && (empty == inverse x <> x)
class Monoid a => Group a where
  inverse :: a -> a

instance Group (Sum Integer) where
  inverse = negate

instance Group Xor where
  inverse = id
instance Group (Sum Rational) where
  inverse = negate

instance Group () where
  inverse () = ()
commutativeLaw :: (Abelian a, Eq a) =>
                  a -> a -> Bool
commutativeLaw x y =
  x <> y == y <> x
class Semigroup a => Abelian a

instance Abelian (Sum Integer)
instance Abelian (Product Integer)
instance Abelian (Sum Rational)
instance Abelian (Product Rational)
instance Abelian And
instance Abelian Or
instance Abelian Xor
instance Abelian ()
