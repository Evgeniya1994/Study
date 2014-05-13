import System.IO
import Control.Cancurrent
f :: [String] -> String -> IO String
f [] x = return x
f (x:xs) y = if length x > length y then
				f xs x
			else f xs y
	
main = do
	f <- openFile "in.txt" WriteMode
	hPutStr f "looooool\ndkdghdgh"
	hClose f
	s <- readFile "in.txt"
	let ss = lines s
	f ss []