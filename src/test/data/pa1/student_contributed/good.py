# good.py - Exercício de recursos de sintaxe para o analisador ChocoPy
# Este arquivo inclui exemplos de:
#   - Declarações de variáveis globais (var_def)
#   - Definições de funções com e sem anotação de tipo de retorno
#   - Expressões condicionais (if-else) e aritméticas
#   - Estruturas de controle de fluxo: if/elif/else, while e for
#   - Definições e uso de classes e métodos
#   - Declarações de global e nonlocal
#   - Uso de listas literais, indexação e chamadas de funções/métodos

# Declarações globais (note que para var_def o lado direito deve ser um literal)
x: int = 10
flag: bool = True

def add(a: int, b: int) -> int:
    # Função simples para somar dois números.
    return a + b

def complex_expr(a: int, b: int) -> int:
    # Usa expressão condicional (ternária) e aritmética.
    # Neste contexto a expressão condicional (if-else) é utilizada em uma atribuição.
    # Como declarações com tipos (var_def) só permitem literais, esta atribuição é
    # feita via uma atribuição simples a uma variável previamente declarada.
    max_val = a if a > b else b
    nested = 100 if (a + b) > 20 else (200 if (a + b) == 20 else 300)
    return max_val + nested

def loop_and_conditional():
    # Declaração inicial (var_def) e posterior atribuição (assignment statement)
    total: int = 0
    # For loop sobre uma lista literal
    for i in [1, 2, 3, 4, 5]:
        total = total + i
    # Estrutura condicional encadeada
    if total > 15:
        total = total - 5
    elif total == 15:
        total = total + 5
    else:
        total = total * 2
    return total

def test_while_loop() -> int:
    # Exemplo de uso da estrutura while
    count: int = 0
    while count < 5:
        count = count + 1
    return count

def recursion_example(n: int) -> int:
    if n <= 1:
        return 1
    else:
        return n * recursion_example(n - 1)

class MyClass(object):
    # A definição de classe utiliza a sintaxe: CLASS id LPAREN id RPAREN COLON
    def __init__(self, value: int) -> None:
        self.value: int = value

    def increment(self) -> None:
        self.value = self.value + 1

    def multiply(self, factor: int) -> int:
        return self.value * factor

def use_class_and_methods() -> int:
    # Demonstra criação e manipulação de objeto.
    obj: MyClass = MyClass(10)
    obj.increment()
    result = obj.multiply(5)
    return result

def test_global_nonlocal() -> int:
    # Exemplo do uso de declarações global e nonlocal
    global x
    counter: int = 0
    def inner() -> int:
        nonlocal counter
        counter = counter + 1
        return counter
    return inner()

def list_indexing() -> int:
    # Criação e acesso a listas literais
    numbers: list = [10, 20, 30, 40]
    first = numbers[0]
    last = numbers[3]
    # Cria nova lista utilizando literais
    new_list: list = [first, last]
    return new_list[0] + new_list[1]

def main() -> None:
    # Chama todas as funções de teste para exercitar os recursos da linguagem.
    res1: int = add(3, 4)
    res2: int = complex_expr(5, 10)
    res3: int = loop_and_conditional()
    res4: int = test_while_loop()
    res5: int = recursion_example(5)
    res6: int = use_class_and_methods()
    res7: int = test_global_nonlocal()
    res8: int = list_indexing()
    
    # Utilização de chamadas de função (CallExpr) para imprimir resultados.
    print(res1)
    print(res2)
    print(res3)
    print(res4)
    print(res5)
    print(res6)
    print(res7)
    print(res8)

# Ponto de entrada para a execução
main()
