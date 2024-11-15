module Machine
(      
        Vname,
        Val,
        State,
        Instr (..),
        Stack,
        Config,
        iexec,
        exec
) where

import Data.Map

--TODO Task 1.1
--type Vname is alist of characters -> string
type Vname = String
--TODO Task 1.2
--type Val holds an integer value 
type Val = Int
--TODO Task 1.3
--type State maps value Val to variable name Vname
type State = Map Vname Val

--TODO Task 1.4
--Defines available instructions in a data type
data Instr =
        LOADI Int
        | LOAD String  
        | ADD  
        | STORE String
        | JMP Int
        | JMPLESS Int
        | JMPGE Int
        deriving (Eq, Read, Show)

--TODO Task 1.5
--creating a stack type and implementing subsequent operation
type Stack = [Int]

--new stack operation
newStack :: Stack
newStack = []

--TODO Task 1.6
type Config = (Int, State, Stack)

--TODO Task 1.7
--x = value to be loaded, c = counter, v = variable, vp = variable pair, vn = variable name, s = stack
iexec :: Instr -> Config -> Config
iexec (LOADI x) (c,vp,s) = (c+1,vp,x:s)
iexec (LOAD v) (c,vp,s) = (c+1,vp,vp!v:s)
iexec ADD (c,vp,s1:s2:s) = (c+1,vp,s1+s2:s)
iexec (STORE vn) (c,vp,s1:s) = (c+1,insert vn s1 vp,s)
iexec (JMP x) (c,vp,s) = (c+1+x,vp,s)
iexec (JMPLESS x) (c,vp,s1:s2:s) = 
        if s1>s2 then (c+1+x,vp,s)
        else (c+1,vp,s)
iexec (JMPGE x) (c,vp,s1:s2:s) =
        if s2>=s1 then (c+1+x,vp,s)
        else (c+1,vp,s)

--TODO Task 1.8
exec :: [Instr] -> Config -> Config
exec [x] (c,vp,s)  = iexec x (c,vp,s)
exec (x:xs) (c,vp,s) = exec xs (iexec x (c,vp,s))
