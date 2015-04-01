#!/usr/bin/env runhaskell

-- | Translating RNA into Protein
-- Usage: PROT <dataset.txt>

{-# LANGUAGE OverloadedStrings #-}

import System.Environment(getArgs)
import qualified Data.ByteString.Char8 as C
import qualified Data.Map as Map
import Control.Monad(liftM2, liftM)

translate codons seq
	| C.length seq < 3 = Just []
	| otherwise        = if validAA aa
						 	then ( liftM2 (:) aa (translate codons $ C.drop 3 seq) )
							else Just []
	where
		aa = Map.lookup (C.take 3 seq) codons
		validAA aminoacid
			| aminoacid /= Nothing && aminoacid /= Just "Stop" = True
			| otherwise = False

parseCodonsFile f = Map.fromList $ map (tuplify2 . C.words) . C.lines $ f
	where tuplify2 = \(x:y:[]) -> (x,y)

main = do
	codonsFile     <- C.readFile "rna_codon_table.txt"  -- read and parse codons table
	let codons      = parseCodonsFile codonsFile
	let translate'  = translate codons
	(file:_)       <- getArgs
	rna            <- C.readFile file  -- read and process the sequence
	let (s:_)       = C.lines rna
	let Just result = liftM C.concat $ translate' s
	C.putStrLn result