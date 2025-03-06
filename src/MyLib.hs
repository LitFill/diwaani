module MyLib (Writer(..)) where

{-| this all could be written in 5 lines like so:

data Writer a where Writer :: {logs :: [String], val :: a} -> Writer a
instance Functor Writer where fmap f (Writer logs val) = Writer logs (f val)
instance Applicative Writer where pure = Writer []; Writer l1 f <*> Writer l2 v = Writer (l1 ++ l2) (f v)
instance Monad Writer where Writer l1 v1 >>= f = let Writer l2 v2 = f v1 in Writer (l1 ++ l2) v2
instance Show a => Show (Writer a) where show = unlines . logs
-}

data Writer a where
    Writer :: {logs :: [String], val :: a} -> Writer a

instance Functor Writer where
    fmap f (Writer logs val) = Writer logs (f val)
    {-# INLINABLE fmap #-}

instance Applicative Writer where
    pure = Writer []
    {-# INLINABLE pure #-}

    Writer l1 f <*> Writer l2 v =
        Writer (l1 ++ l2) (f v)
    {-# INLINABLE (<*>) #-}

instance Monad Writer where
    Writer l1 v1 >>= f =
        let Writer l2 v2 = f v1
         in Writer (l1 ++ l2) v2

instance Show a => Show (Writer a) where
    show = unlines . logs
    {-# INLINABLE show #-}

--- >>> show (Writer ["empty"] ())
-- "empty\n"

-- >>> show (pure 35 >>= (\x -> let res = 34 + x in Writer ["Adding 34 to " ++ show x ++ " to get " ++ show res] res))
-- "Adding 34 to 35 to get 69\n"

