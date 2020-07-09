-- Usando el teorema de fusión podemos expresar a `length . cp` como:
    length . cp = foldr h b

-- Teniendo que:
    length [[]] = b
    length (op xs xss) = h xs (length xss)

-- La primera ecuación da `b = 1` y como
    length (op xs xss) = length xs * length xss

-- la segunda ecuación da
    h = (*) . length

-------------------------------

-- Usando el teorema de fusión podemos expresar a `map length` como:
    map length = foldr f []

-- Donde `f xs ns = length xs:ns`. Una definición más corta es
    f = (:) . length

-------------------------------

-- Tenemos que:
    product . map length = foldr h b

-- Siempre y cuando `product` se estricto y
    product [] = b
    product (length xs:ns) = h xs (product ns)

-- La primera ecuación da `b = 1`, y como
    product (length xs:ns) = length xs * product ns

-- La segunda ecuación da
    h = (*) . length

-------------------------------

-- Las dos definiciones de `h` y `b` son idénticas
