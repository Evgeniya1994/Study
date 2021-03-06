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
	
show'' :: Show a => BinTree a -> String
show'' t = show''' t 0
	where
		show''' Leaf _  = "\n"
		show''' (Node x l r) n = show''' r (n+2) ++ (replicate n ' ') ++ (show x) ++ show''' l (n+2)
instance Show a => Show (BinTree a) where
	show = show''
	
buildTree :: Ord a => [a] -> BinTree a
buildTree [] = Leaf
buildTree (xs) = buildTree1 (xs) Leaf

buildTree1 :: Ord a => [a] -> BinTree a -> BinTree a
buildTree1 [] t = t
buildTree1 (x:xs) t = buildTree1 (xs) (insTree t x)

treeToList :: BinTree a -> [a]
treeToList Leaf = []
treeToList (Node x l r) = (treeToList l) ++ [x] ++ (treeToList r)

data RedBlackTree a = RBLeaf|RBNode (a, Int) (RedBlackTree a) (RedBlackTree a)
	deriving(Eq, Read)
	
show' t = show'' t 0
	where
		show'' RBLeaf _  = "\n"
		show'' (RBNode (x, c) l r) n = show'' r (n+2) ++ (replicate n ' ') ++ (show x) ++ show'' l (n+2)
instance Show a => Show (RedBlackTree a) where
	show = show'
	
buildRBTree [] = RBLeaf
buildRBTree (xs) = buildRBTree1 (xs) RBLeaf

buildRBTree1 [] t = t
buildRBTree1 (x:xs) t = buildRBTree1 (xs) (insRBTree t x)

-- нет "дяди"
move t@(RBNode (x1, 0) (RBNode (x2, 1) (RBNode (p, 1) a b) c) RBLeaf) =
	(RBNode (x2, 0) (RBNode (p, 1) a b) (RBNode (x1, 1) c RBLeaf))

move t@(RBNode (x1, 0) (RBNode (x2, 1) c (RBNode (p, 1) a b)) RBLeaf) =
	move (RBNode (x1, 0) (RBNode (p, 1) (RBNode (x2, 1) c a) b) RBLeaf)

move t@(RBNode (x1, 0) RBLeaf (RBNode (x3, 1) (RBNode (p, 1) a b) c)) =
	move (RBNode (x1, 0) RBLeaf (RBNode (p, 1) a (RBNode (x3, 1) b c)))

move t@(RBNode (x1, 0) RBLeaf (RBNode (x3, 1) c (RBNode (p, 1) a b))) =
	(RBNode (x3, 0) (RBNode (x1, 1) RBLeaf c) (RBNode (p, 1) a b))

-- красный "дядя"
move t@(RBNode (x1, 0) (RBNode (x2, 1) (RBNode (p, 1) a b) c) (RBNode (x3, 1) d e)) =
	(RBNode (x1, 1) (RBNode (x2, 0) (RBNode (p, 1) a b) c) (RBNode (x3, 0) d e))

move t@(RBNode (x1, 0) (RBNode (x2, 1) c (RBNode (p, 1) a b)) (RBNode (x3, 1) d e)) = 
	(RBNode (x1, 1) (RBNode (x2, 0) c (RBNode (p, 1) a b)) (RBNode (x3, 0) d e))
	
move t@(RBNode (x1, 0) (RBNode (x2, 1) a b) (RBNode (x3, 1) (RBNode (p, 1) c d) e)) = 
	(RBNode (x1, 1) (RBNode (x2, 0) a b) (RBNode (x3, 0) (RBNode (p, 1) c d) e))

move t@(RBNode (x1, 0) (RBNode (x2, 1) a b) (RBNode (x3, 1) e (RBNode (p, 1) c d))) = 
	(RBNode (x1, 1) (RBNode (x2, 0) a b) (RBNode (x3, 0) e (RBNode (p, 1) c d)))

-- черный "дядя"
move t@(RBNode (x1, 0) (RBNode (x2, 1) (RBNode (p, 1) a b) c) (RBNode (x3, 0) d e)) =
	(RBNode (x2, 0) (RBNode (p, 1) a b) (RBNode (x1, 1) c (RBNode (x3, 0) d e)))
	
move t@(RBNode (x1, 0) (RBNode (x2, 1) c (RBNode (p, 1) a b)) (RBNode (x3, 0) d e)) =
	move (RBNode (x1, 0) (RBNode (p, 1) (RBNode (x2, 1) c a) b) (RBNode (x3, 0) d e))

move t@(RBNode (x1, 0) (RBNode (x2, 0) a b) (RBNode (x3, 1) c (RBNode (p, 1) d e))) =
	(RBNode (x3, 0) (RBNode (x1, 1) (RBNode (x2, 0) a b) c) (RBNode (p, 1) d e))
	
move t@(RBNode (x1, 0) (RBNode (x2, 0) a b) (RBNode (x3, 1) (RBNode (p, 1) d e) c)) =
	move (RBNode (x1, 0) (RBNode (x2, 0) a b) (RBNode (p, 1) d (RBNode (x3, 1) e c)))

move t = t

rootBlack t@(RBNode (x, 0) l r) = t
rootBlack t@(RBNode (x, 1) l r) = (RBNode (x, 0) l r)

insRBTree t x = rootBlack (insRBTree1 t x)

insRBTree1 RBLeaf x = (RBNode (x, 1) RBLeaf RBLeaf)
insRBTree1 t@(RBNode (y, c) l r) x =
	if y == x then t
	else if y < x then move (RBNode (y, c) l (insRBTree1 r x))
	else move (RBNode (y, c) (insRBTree1 l x) r)
	