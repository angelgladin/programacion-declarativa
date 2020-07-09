-- |
-- Author : Ángel Iván Gladín García
--

data Expr = Num Int
          | Var Int
          | Div Expr Expr
              deriving (Show)

type Value = Int

type Env = [(Int, Value)]

data Exception = DivisionPorCero
               | VariableNoDefinida
               | MalaSuerte
                   deriving (Show)

data ExprErr a = Raise Exception
               | Return a
                   deriving (Show)

instance Functor ExprErr where
        fmap f (Return x) = Return (f x)

instance Applicative ExprErr where
        pure = Return
        (Return f) <*> (Return x) = Return (f x)

instance Monad ExprErr where
        return = Return
        (>>=) = bindExprErr

bindExprErr :: ExprErr a -> (a -> ExprErr b) -> ExprErr b
bindExprErr (Return x) f = f x
bindExprErr (Raise e) f = Raise e

evalEx :: Expr -> Env -> ExprErr Int
evalEx (Var v) [] = Raise VariableNoDefinida
evalEx (Var v) ((id, val) : xs)
  = if v == id then evalEx (Num val) xs else evalEx (Var v) xs
evalEx (Num n) _ = if n == 13 then Raise MalaSuerte else return n
evalEx (Div _ (Num 0)) l = Raise DivisionPorCero
evalEx (Div e1 e2) l
  = do v1 <- evalEx e1 l
       v2 <- evalEx e2 l
       let r = (div v1 v2)
       if r == 13 then Raise MalaSuerte else return (div v1 v2)
