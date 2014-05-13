import Network.Socket
import Control.Exception
import Control.Monad (unless)
main = withSocketsDo $ do
		sock <- getSocket
		handler sock
		sClose sock
getSocket = do
		(sa:_) <- getAddrInfo (Just (defaultHints { addrFlags = [AI_PASSIVE]})) Nothing (Just "3000")
		s <- socket (addrFamily sa) Datagram defaultProtocol
		bindSocket s (addrAddress sa)
		return s
handler :: Socket -> IO ()
handler conn = do
		(msg, n, d) <- recvFrom conn 1024
		putStrLn $ "<" ++ msg
		unless (null msg) $ sendTo conn msg d >> handler conn
		