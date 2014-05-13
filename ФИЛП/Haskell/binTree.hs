data BinTree a = Leaf|Node a (BinTree a) (BinTree a)
	deriving(Eq, Read)
nodes :: BinTree a -> Int
nodes Leaf = 0
nodes (Node x l r) = 1 + nodes l + nodes r

height :: BinTree a -> Int
height Leaf = 0
height (Node x l r) = 1 + max (height l) (height r)

insTree :: Ord a => BinTree a -> a -> BinTree a
insTree Leaf x = (Node x Leaf Leaf)
insTree t@(Node y l r) x =
	if y == x then t
	else if y < x then Node y l (insTree r x)
	else Node y (insTree l x) r
	
show' :: Show a => BinTree a -> String
show' t = show'' t 0
	where
		show'' Leaf _  = "\n"
		show'' (Node x l r) n = show'' l (n+2) ++ (replicate n ' ') ++ (show x) ++ show'' r (n+2)
instance Show a => Show (BinTree a) where
	show = show'