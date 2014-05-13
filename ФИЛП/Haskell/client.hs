import Network
import System.IO
main = withSocketsDo $ do
		h <- connectTo "172.16.12.166" (PortNumber 8080)
		hSetBuffering h LineBuffering
		s <- getLine
		hPutStrLn h s
		t <- hGetLine h
		putStrLn t
		hClose h