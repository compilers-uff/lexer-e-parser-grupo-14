# bad.py — mistura erros léxicos e sintáticos

def foo(x)    # ← falta “:”
    @          # ← caractere inválido: lex error
    if x > 10  # ← falta “:”
        print("grande")
    else       # ← falta “:”
        print("pequeno"   # ← parêntese não fechado: syntax error

bar = 5 ** * 2  # ← “** *” não faz sentido: syntax error
