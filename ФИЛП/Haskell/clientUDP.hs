import Network.Socket
import System.IO
import Control.Exception
main = withSocketsDo $ do
		sock <- getSocket
		talk sock
		sClose sock
getSocket = do
		(sa:_) <- getAddrInfo Nothing (Just "127.0.0.1") (Just "3000")
		s <- socket (addrFamily sa) Datagram defaultProtocol
		connect s (addrAddress sa)
		return s
talk :: Socket -> IO ()
talk s = do
		send s "Hello, world!"
		t <- recv s 1024
		putStrLn t