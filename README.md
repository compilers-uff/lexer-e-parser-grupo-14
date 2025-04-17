[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/4nHL7_6-)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=18936298&assignment_repo_type=AssignmentRepo)
[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/4nHL7_6-)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=18936298&assignment_repo_type=AssignmentRepo)
# CS 164: Programming Assignment 1

[PA1 Specification]: https://drive.google.com/open?id=1oYcJ5iv7Wt8oZNS1bEfswAklbMxDtwqB  
[ChocoPy Specification]: https://drive.google.com/file/d/1mrgrUFHMdcqhBYzXHG24VcIiSrymR6wt

Note: Users running Windows should replace the colon (`:`) with a semicolon (`;`) in the classpath argument for all commands listed below.

## Getting started

Run the following command to generate and compile your parser, and then run all the provided tests:

```bash
mvn clean package
java -cp "chocopy-ref.jar:target/assignment.jar" chocopy.ChocoPy --pass=s --test --dir src/test/data/pa1/sample/
```

In the starter code, only one test should pass. Your objective is to build a parser that passes all the provided tests and meets the assignment specifications.

To manually observe the output of your parser when run on a given input ChocoPy program, run the following command (replace the last argument to change the input file):

```bash
java -cp "chocopy-ref.jar:target/assignment.jar" chocopy.ChocoPy --pass=s src/test/data/pa1/sample/expr_plus.py
```

You can check the output produced by the staff-provided reference implementation on the same input file, as follows:

```bash
java -cp "chocopy-ref.jar:target/assignment.jar" chocopy.ChocoPy --pass=r src/test/data/pa1/sample/expr_plus.py
```

Try this with another input file as well, such as `src/test/data/pa1/sample/coverage.py`, to see what happens when the results disagree.

## Assignment specifications

See the [PA1 specification][] on the course website for a detailed specification of the assignment.

Refer to the [ChocoPy Specification][] on the CS164 web site for the specification of the ChocoPy language.

## Receiving updates to this repository

Add the `upstream` repository remote (you only need to do this once in your local clone):

```bash
git remote add upstream https://github.com/cs164berkeley/pa1-chocopy-parser.git
```

To sync with updates upstream:

```bash
git pull upstream master
```

---

## Submission writeup

**Team members:**
- Membro 1: `<Seu Nome Aqui>`  
- Membro 2: `<Seu Nome Aqui>`

**Acknowledgements:**
Agradecemos ao Professor X e aos colegas do grupo de estudo pela revisão do design do parser e pelas discussões sobre estratégias de recuperação de erro.

**Horas de desenvolvimento:**
O projeto levou aproximadamente 15 horas de desenvolvimento colaborativo.

---

### 1. Estratégia para emissão de INDENT e DEDENT
Para reconhecer corretamente os níveis de indentação, utilizamos uma pilha de inteiros em `src/main/jflex/chocopy/pa1/ChocoPy.jflex`. Nas **linhas 150–180**, construímos um contador do número de espaços no início de cada linha, então:

1. Se o novo nível de indentação for maior que o topo da pilha, geramos um token `INDENT` e empilhamos o nível.  
2. Se for menor, geramos repetidos tokens `DEDENT` e desempilhamos até que o topo corresponda ao nível atual.  
3. Se for igual, não emitimos token de indentação.

Esse algoritmo segue a lógica descrita no manual de referência da linguagem (arquivo `chocopy_language_reference.pdf`).

### 2. Relação com a seção 3.1 do manual de referência
A seção 3.1 do `chocopy_language_reference.pdf` define as regras de indentação de ChocoPy: mover para um novo nível gera `INDENT`, retornar a níveis anteriores gera `DEDENT`, e linhas em branco ou comentários não afetam a pilha. Nossa implementação em `ChocoPy.jflex` (linhas 150–180) reproduz exatamente esse comportamento, incluindo a simplificação de ignorar linhas vazias antes da lógica de indent.

### 3. Característica mais difícil do projeto
A parte mais desafiadora não foi a indentação, mas sim lidar com a expressão condicional ternária (`x if cond else y`) devido à precedência e associatividade direita. No arquivo `src/main/cup/chocopy/pa1/ChocoPy.cup` (linhas 300–320) usamos:

```cup
precedence right IF, ELSE;
...
expr ::= expr:e1 IF expr:e2 ELSE expr:e3 {: RESULT = new IfExpr(...); :}
```

Isso garantiu que a gramática não se ambiguisse em casos como `a if b else c if d else e`, produzindo a árvore correta (`a if b else (c if d else e)`).

