getlines :: Int -> IO Int
getlines x = do
	s <- getLine
	ss <- Read s
	if ss == x then print "���������"
	else if ss > x then 
		print "������" 
		getlines x
	else 
		print "������"
		getlines x
main = do
	let x = 9
	n <- getlines x
	print n