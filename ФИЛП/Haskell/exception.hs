import Control.Exception as Ex
import System.IO
import Data.Maybe

fileSize :: String -> IO (Maybe Integer)
fileSize name = getSize `Ex.catch` handler
	where
	getSize = Ex.bracket
		(openFile name ReadMode)
		hClose
		(\h -> do {n <- hFileSize h; return (Just n)})
	handler :: Ex.SomeException -> IO (Maybe Integer)
	handler ex = return Nothing
		
main = do
	n <- fileSize "in.txt"
	result n
	n1 <- fileSize "in.txt"
	result n1
	where
		result n = putStrLn (if n == Nothing
			then "File not found"
			else ("File not found" ++ (show $ fromJust n)))