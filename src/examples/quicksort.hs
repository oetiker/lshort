quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (p:xs) = quicksort (filter (< p) xs) ++ [p] ++ quicksort (filter (>= p) xs)
