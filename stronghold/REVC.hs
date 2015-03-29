#!/usr/bin/env runhaskell

-- | Complementing a Strand of DNA
-- Usage: REVC <dataset.txt>

import System.Environment(getArgs)
import qualified Data.ByteString.Char8 as C

main = do
	(file:_) <- getArgs
	dna <- C.readFile file
	C.putStrLn $ C.reverse . C.map complement . head . C.lines $ dna
		where complement x
			| x == 'A' = 'T'
			| x == 'T' = 'A'
			| x == 'G' = 'C'
			| x == 'C' = 'G'