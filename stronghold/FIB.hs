#!/usr/bin/env runhaskell

-- | Rabbits and Recurrence Relations
-- Usage: FIB <dataset.txt>
 
fib' :: Num b => b -> [b]
fib' k = 1 : 1 : [x*k+y | (x,y) <- zip (fib' k) (tail $ fib' k)]

rab :: Num a => Int -> a -> a
rab n k = fib' k !! (n-1)

main = do
	line         <- getLine
	let (n:k:_)   = words line
	putStrLn $ show $ rab (read n :: Int) (read k :: Int)