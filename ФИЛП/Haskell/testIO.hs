getlines :: Int -> IO Int
getlines x = do
	s <- getLine
	ss <- Read s
	if ss == x then print "правильно"
	else if ss > x then 
		print "меньше" 
		getlines x
	else 
		print "больше"
		getlines x
main = do
	let x = 9
	n <- getlines x
	print n