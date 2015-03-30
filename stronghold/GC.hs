#!/usr/bin/env runhaskell

-- | Complementing a Strand of DNA
-- Usage: REVC <dataset.txt>

import System.Environment(getArgs)
import qualified Data.ByteString.Char8 as C
import Data.Ord(comparing)
import Data.List(sortBy)

parseFastaMultiline :: C.ByteString -> [(C.ByteString, C.ByteString)]
parseFastaMultiline f = zip (map (C.takeWhile (/='\n')) xs) (map (C.filter (/='\n') . C.dropWhile (/='\n')) xs)
	where xs = filter (\x -> C.length x > 0) . C.split '>' $ f

gcContent :: Fractional a => C.ByteString -> a
gcContent seq = (C.foldr ((+) . ifS) 0.0 seq) / (fromIntegral $ C.length seq)
	where ifS x = if x == 'C' || x == 'G' then 1 else 0

pairs :: [t] -> [(t, t)]
pairs []       = []
pairs (x:[])   = []  -- abnormal case
pairs (x:y:xs) = (x, y) : pairs xs

main = do
	(file:_) <- getArgs
	fasta <- C.readFile file
	let result = last . sortBy (comparing $ gcContent . snd) . parseFastaMultiline $ fasta
	C.putStrLn $ fst result
	putStrLn $ show $ 100.0 * (gcContent . snd $ result)