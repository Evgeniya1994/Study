import Network
import System.IO
import Control.Concurrent
main = withSocketsDo $ do
		sock <- listenOn(PortNumber 8080)
		workWith sock
		sClose sock
workWith sock = do
		(h, n, p) <- accept sock
		hSetBuffering h LineBuffering
		forkIO $ talk h
		workWith sock
talk h = do
		s <- hGetLine h
		hPutStrLn h s
		hClose h
