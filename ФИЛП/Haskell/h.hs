{-roots :: Double -> Double -> Double -> (Double, Double, Double)
roots a b c = if d < 0 then error "d<0" else (x1, x2)
    where 
        d = b*b-4*a*b*b
		sd = sqrt d
		x1 = (-b+sd)/(2*a)
		x2 = (-b-sd)/(2*a)
		-}
fact :: Int->Integer
fact 0=1
fact n = if n<0 then error "Bad n" else (toInteger n) * fact(n-1) 
-- test :: [Int] -> Int -> Int
--test :: (Eq a) => [a] -> a -> Int
test [] _ = 0
test (x:xs) y = 
    if x==y then 1 + test xs y
	    else test xs y
		
cnt :: [Int] -> Int -> Int
cnt [] _ = 0
cnt (x:xs) y = 
    if x==y then 1 + cnt xs y
	    else cnt xs y
main = print (test [1, 2, 3, 1, 1, 1, 1, 1, 8, 345, 45, 57, 1] 1)

divisors :: Int -> [Int]
divisors n = [x | x <- [2..(n-1)], mod n x == 0]
prime n = divisors n == []

-- primes = [n | n <- [2..], prime n]

sieve [] = []
sieve (x:xs) = x : sieve [y | y <- xs, mod y x /= 0]
primes = sieve [2..]
    -- take 100 primes
    -- take 100 drop (100 primes)
	
hanoi :: Int -> Int -> Int -> Int -> [(Int, Int)]
hanoi x y z 1 = [(x, z)]
hanoi x y z n = hanoi x z y (n-1) ++ (x, z) : hanoi y x z (n-1)

rev :: [a] -> [a]
rev []=[]
rev (x:xs) = rev xs ++ [x]
rev1 []=[]
rev1 xs = rev1' xs []
rev1' [] xs = xs
rev1' (x:xs) ys = rev1' xs (x:ys)
qsort []=[]
qsort (x:xs) = qsort[y | y <- xs, y<=x] ++ (x : qsort [y | y <- xs y>x])