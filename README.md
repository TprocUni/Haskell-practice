# Haskell-practice
This Haskell framework implements a compiler and interpreter for a stack-based virtual machine, supporting arithmetic and boolean expressions, state management, and command execution.



### Key Modules and Features

#### 1. `Machine.hs` – Stack-Based Virtual Machine
Defines the machine's core:
- **Instructions**: `LOAD`, `STORE`, `ADD`, `JMP`, etc.
- **Execution**:
  - `iexec`: Executes a single instruction.
  - `exec`: Executes a sequence of instructions.
- **State**: Maps variables to values.

#### 2. `Interpreter.hs` – Expression and Command Evaluation
Implements:
- **Arithmetic Expressions (`AExp`)**: Evaluates with `aval`.
- **Boolean Expressions (`BExp`)**: Evaluates with `bval`.
- **Commands (`Com`)**: Executes with `eval` (e.g., `Assign`, `If`, `While`).

#### 3. `Compiler.hs` – Compilation to Instructions
Converts high-level constructs into machine instructions:
- `acomp`: Compiles arithmetic expressions.
- `bcomp`: Compiles boolean expressions.
- `ccomp`: Compiles commands like `If` and `While`.

---

### Workflow Example
1. **Compile**:
   ```haskell
   acomp (Plus (V "x") (N 3)) 
   -- Output: [LOAD "x", LOADI 3, ADD]
