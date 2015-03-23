#!/usr/bin/env runhaskell

-- | Transcribing DNA into RNA
-- Usage: RNA <dataset.txt>

import System.Environment(getArgs)
import qualified Data.ByteString.Char8 as C

main = do
	(file:_) <- getArgs
	rna <- C.readFile file
	C.putStrLn $ C.map t2u . head . C.lines $ rna
		where t2u x = if x == 'T' then 'U' else x