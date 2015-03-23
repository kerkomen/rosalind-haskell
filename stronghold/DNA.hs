#!/usr/bin/env runhaskell

-- | Counting DNA Nucleotides
-- Usage: DNA <dataset.txt>

import System.Environment(getArgs)
import Data.List(intercalate)
import qualified Data.ByteString.Char8 as C

main = do
	(file:_) <- getArgs
	dna <- C.readFile file
	display . counts . head . C.lines $ dna
		where
			display = putStrLn . intercalate " " . map show
			counts  = map C.length . C.group . C.sort