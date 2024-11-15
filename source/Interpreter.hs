module Interpreter
(
    AExp(..),
    BExp(..),
    Com (..),
    aval,
    bval,
    eval
) where

import Data.Map
import Machine


--TODO Task 2.1
data AExp =
    N Val
    | V Vname
    | Plus AExp AExp
    deriving (Eq, Read, Show)

--TODO Task 2.2
aval :: AExp -> State -> Val
aval (N n) s = n
aval (V v) s  = s!v 
aval (Plus a b) s = aval a s + aval b s

--TODO Task 2.1
data BExp =
    Bc Bool 
    | Not BExp
    | And BExp BExp
    | Less AExp AExp
    deriving (Eq, Read, Show)

--TODO Task 2.3
bval :: BExp -> State -> Bool
bval (Bc v) s = v
bval (Not a) s = not (bval a s) 
bval (And a b) s = and[bval a s,bval b s]
bval (Less a b) s = (aval a s < aval b s)

--TODO Task 2.1
data Com =
    Assign Vname AExp 
    | Seq Com Com 
    | If BExp Com Com
    | While BExp Com 
    | SKIP 
    deriving (Eq, Read, Show)

--TODO Task 2.4
eval :: Com -> State -> State
eval (SKIP) (s) = s

eval (Assign vn v) s = insert vn (aval (v) s) s

eval (Seq (a) (b)) (s) = eval (b) (eval (a) (s))

eval (If bool a b) s| (bval bool s == True) = eval a s 
                 | (bval bool s == False) = eval b s

eval (While bool a) s | (bval bool s == True) = eval (While bool a) (eval a s) 
                    | (bval bool s == False) = s