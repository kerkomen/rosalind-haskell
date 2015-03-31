#!/usr/bin/env runhaskell

-- | Counting Point Mutations
-- Usage: HAMM <dataset.txt>

import System.Environment(getArgs)
import qualified Data.ByteString.Char8 as C

hamming seqx seqy
	| seqx == C.empty = 0
	| otherwise       = (if x == y then 0 else 1) + hamming xs ys
		where
			(x, y)   = (C.head seqx, C.head seqy)
			(xs, ys) = (C.tail seqx, C.tail seqy)

main = do
	(file:_) <- getArgs
	fasta <- C.readFile file
	let (s:t:_) = C.lines fasta
	putStrLn $ show $ hamming s t