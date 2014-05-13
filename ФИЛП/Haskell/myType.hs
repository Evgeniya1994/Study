data Day = Mon|Tus|Wed|Thu|Fri|Sat|Sun
	deriving(Eq, Ord, Bounded, Read, Show)
fromEnum' Mon = 0
fromEnum' Tus = 1	
fromEnum' Wed = 2	
fromEnum' Thu = 3	
fromEnum' Fri = 4	
fromEnum' Sat = 5	
fromEnum' Sun = 6
toEnum' 0 = Mon
toEnum' 1 = Tus
toEnum' 2 = Wed
toEnum' 3 = Thu
toEnum' 4 = Fri
toEnum' 5 = Sat
toEnum' 6 = Sun
succ' :: Day -> Day
succ' d = toEnum $ mod (succ $ fromEnum d) 7
pred' :: Day -> Day
pred' d = toEnum $ mod (pred $ fromEnum d) 7

instance Enum Day where 
	fromEnum = fromEnum'
	toEnum = toEnum'
	succ = succ'
	pred = pred'
week :: Day -> Day -> [Day]
week x y = if x /= y then (x:(week (succ' x) y))
	else [x]
data Person = MkPerson {name::String, age::Int}
	deriving(Eq, Show)
birthday :: Person -> Person
birthday p = MkPerson (name p) (1 + age p)
