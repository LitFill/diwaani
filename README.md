# diwaani

an implementation of writer monad for logging some operation in 5 lines.

## the monad

```haskell
data Writer a = Writer { logs :: [String], val :: a }
```

## examples

```haskell
square :: Int -> Writer Int
square x =
    let x2 = x * x
     in Writer [show x ++ " squared is " ++ show x2] x2

main :: IO ()
main = do
    print $
        pure 2 >>= square >>= square >>= square
```

this program prints:

```
2 squared is 4
4 squared is 16
16 squared is 256
```
