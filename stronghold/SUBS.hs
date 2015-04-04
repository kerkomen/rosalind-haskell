#!/usr/bin/env runhaskell

-- | Finding a Motif in DNA
-- Usage: SUBS <dataset.txt>

{-# LANGUAGE OverloadedStrings #-}

import System.Environment(getArgs)
import Data.List(intercalate)
import qualified Data.ByteString.Char8 as C
import qualified Data.ByteString.Search.KMP as KMP

main = do
	(file:_)       <- getArgs
	seqs           <- C.readFile file  -- read and process the sequence
	let (text:pattern:_)     = C.lines seqs
	putStrLn $ intercalate " " $ map (show . (1+)) $ KMP.indices pattern text