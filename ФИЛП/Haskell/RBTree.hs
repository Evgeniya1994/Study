data RedBlackTree a = RBLeaf|RBNode (a, Int) (RedBlackTree a) (RedBlackTree a)
	deriving(Eq, Read)
	
buildRBTree [] = RBLeaf
buildRBTree (xs) = buildTree1 (xs) RBLeaf

buildRBTree1 [] t = t
buildRBTree1 (x:xs) t = buildTree1 (xs) (insRBTree t x)

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
	
show' t = show'' t 0
	where
		show'' RBLeaf _  = "\n"
		show'' (RBNode (x, c) l r) n = show'' r (n+2) ++ (replicate n ' ') ++ (show x) ++ show'' l (n+2)
instance Show a => Show (RedBlackTree a) where
	show = show'