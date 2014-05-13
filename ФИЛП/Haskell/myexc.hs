{-# LANGUAGE DeriveDataTypeable, ScopedTypeVariables #-}
import Control.Exception as Ex
import System.IO
import Data.Maybe
import Data.Typeable

data MyException = MyException String
	deriving (Show, Typeable)
instance Exception MyException

myDiv x y = if y /= 0 then div x y
			else Ex.throw (MyException "div by zero")
handler (Ex.SomeException e) = do
	let t = show $ typeOf e
	putStrLn(if t == "MyException" then "lol" else "ok")
test x y = (print $ myDiv x y) 'Ex.catch' handler
main = do 
	test 1 0
	test 20 20