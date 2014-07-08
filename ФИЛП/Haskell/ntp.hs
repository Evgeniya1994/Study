import Prelude hiding (catch)
import Network.Socket hiding (send, sendTo, recv, recvFrom)
import Control.Exception
import System.Timeout
import System.Time
import Data.Char
import Data.Bits (shiftL, shiftR)
import Data.Int (Int64)
import System.Exit (exitSuccess)
import Data.Binary (encode)
import Data.Binary.Get (runGet, skip, getWord64be)
import Data.ByteString.Lazy.Char8 (unpack)
import Network.Socket.ByteString (send, sendTo)
import Data.ByteString.Char8 (pack)
import Data.Time.Clock.POSIX
import Data.Time (UTCTime)
import Network.Socket.ByteString.Lazy
import Data.ByteString.Lazy.Internal
import Data.List
import System.Random

formPackage time = pack (h++transmit) where
	h = [
		'\35','\0','\0','\0',
		'\0','\0','\0','\0',
		'\0','\0','\0','\0',
		'\0','\0','\0','\0',
		'\0','\0','\0','\0','\0','\0','\0','\0',
		'\0','\0','\0','\0','\0','\0','\0','\0',
		'\0','\0','\0','\0','\0','\0','\0','\0'
		]
	transmit = unpack $ encode (fromInteger time :: Int64)
	
main= withSocketsDo $do
	let ipList = ["172.16.12.247","91.226.136.136","88.147.254.232"]
	n <- getStdRandom (randomR (0,length ipList-1)) 
	addrinfos <- getAddrInfo Nothing (Just (ipList!!n)) (Just "123")
	let serveraddr = head addrinfos
	sock<-socket(addrFamily serveraddr) Datagram defaultProtocol
	connect sock(addrAddress serveraddr)
	time <- getTime
	let request = formPackage time
	setSocketOption sock RecvTimeOut 1000
	send sock request
	reply <- try $ recv sock 1024 :: IO (Either IOException ByteString)
	case reply of
		Left exception -> main
		Right dataR -> getPrintTime dataR
	
getPrintTime reply = do
	t4 <- getTime
	let (t1, t2, t3) = runGet getTimesPacket reply
	let time1 = fromIntegral((t1 `shiftR` 32 ) - 2208978000)
	let time2 = fromIntegral((t2 `shiftR` 32 ) - 2208978000)
	let time3 = fromIntegral((t3 `shiftR` 32 ) - 2208978000)
	let time4 = fromIntegral((t4 `shiftR` 32 ) - 2208978000)
	print $ posixSecondsToUTCTime(time3 + ((time2 - time1) + (time3 - time4)) / 2)

getTimesPacket = do
	skip 24
	t1 <- getWord64be
	t2 <- getWord64be
	t3 <- getWord64be
	return (t1,t2,t3)
	
getTime = do
	(TOD sec psec) <- getClockTime
	let res_sec = (2208978000 + sec)
	return (res_sec `shiftL` 32)