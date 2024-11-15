module Compiler
(
    acomp,
    bcomp,
    ccomp
) where

import Machine
import Interpreter

--TODO Task 3.1
acomp :: AExp -> [Instr]
acomp (N n) = [LOADI n]
acomp (V v) = [LOAD v]
acomp (Plus a b) = acomp (a) ++ acomp(b) ++ [ADD]

--TODO Task 3.2
bcomp :: BExp -> Bool -> Int -> [Instr]
bcomp (Bc a) (bool) (n) | (a == bool) = [JMP n] 
                      | (a /= bool) = []
bcomp (Not a) (bool) (n) = bcomp a (not bool) n
bcomp (And a b) (bool) (n) = a1 ++ b1
                where b1 = bcomp (b) (bool) (n)
                      a1 = bcomp (a) (False) (if (bool == True) then length b1 else length b1+n)

bcomp (Less a b) (bool) (n) | (bool == True) = acomp(a) ++ acomp(b) ++ [JMPLESS n]
                            | (bool == False) = acomp(a) ++ acomp(b) ++ [JMPGE n]


--TODO Task 3.3
ccomp :: Com -> [Instr]
ccomp SKIP = []
ccomp (Assign a b) = acomp (b) ++ [STORE a]
ccomp (Seq a b) = ccomp(a) ++ ccomp(b)
ccomp (If bool a b) = c ++ a1 ++ ([JMP (length b1)] ++ b1)
                    where a1 = ccomp (a)
                          b1 = ccomp (b)
                          c = bcomp (bool) (False) (length a1 + 1)
ccomp (While bool a) = a2 ++ a1 ++ [JMP (-(length a1 + length a2 + 1))]
                    where a1 = ccomp (a)
                          a2 = bcomp (bool) (False) (length a1 + 1)



