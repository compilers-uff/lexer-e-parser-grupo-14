package chocopy.pa1;
import java_cup.runtime.*;

%%

/*** Do not change the flags below unless you know what you are doing. ***/

%unicode
%line
%column

%class ChocoPyLexer
%public

%cupsym ChocoPyTokens
%cup
%cupdebug

%eofclose false

/*** Do not change the flags above unless you know what you are doing. ***/

/* The following code section is copied verbatim to the
 * generated lexer class. */
%{
    /* The code below includes some convenience methods to create tokens
     * of a given type and optionally a value that the CUP parser can
     * understand. Specifically, a lot of the logic below deals with
     * embedded information about where in the source code a given token
     * was recognized, so that the parser can report errors accurately.
     * (It need not be modified for this project.) */

    /** Producer of token-related values for the parser. */
    final ComplexSymbolFactory symbolFactory = new ComplexSymbolFactory();

    /** Return a terminal symbol of syntactic category TYPE and no
     *  semantic value at the current source location. */
    private Symbol symbol(int type) {
        return symbol(type, yytext());
    }

    /** Return a terminal symbol of syntactic category TYPE and semantic
     *  value VALUE at the current source location. */
    private Symbol symbol(int type, Object value) {
        return symbolFactory.newSymbol(ChocoPyTokens.terminalNames[type], type,
            new ComplexSymbolFactory.Location(yyline + 1, yycolumn + 1),
            new ComplexSymbolFactory.Location(yyline + 1,yycolumn + yylength()),
            value);
    }

	  private StringBuilder stringBuffer = new StringBuilder();
    private int stringStartLine;
    private int stringStartCol;
%}

/* Macros (regexes used in rules below) */

WhiteSpace = [ \t]
LineBreak  = \r|\n|\r\n
IntegerLiteral = 0 | [1-9][0-9]*
Letter = [a-zA-Z_]
Digit  = [0-9]
Identifier = {Letter}({Letter}|{Digit})*

%state STRING

%%


<YYINITIAL> {

  /* Delimiters. */
  {LineBreak}                 { return symbol(ChocoPyTokens.NEWLINE); }

  /* Literals. */
  {IntegerLiteral}            { return symbol(ChocoPyTokens.NUMBER,
                                                 Integer.parseInt(yytext())); }

  /* Operators. */
  "+"                         { return symbol(ChocoPyTokens.PLUS, yytext()); }

  /* Whitespace. */
  {WhiteSpace}                { /* ignore */ }
	
	"True"  { return symbol(ChocoPyTokens.TRUE, true); }
	"False" { return symbol(ChocoPyTokens.FALSE, false); }
	"None"  { return symbol(ChocoPyTokens.NONE); }
	"[" { return symbol(ChocoPyTokens.LBRACK); }
	"]" { return symbol(ChocoPyTokens.RBRACK); }
	"," { return symbol(ChocoPyTokens.COMMA); }
	\" {
      stringBuffer.setLength(0);
      stringStartLine = yyline + 1;
      stringStartCol  = yycolumn + 1;
      yybegin(STRING);
  }

  "-" { return symbol(ChocoPyTokens.MINUS, yytext()); }

  "if"    { return symbol(ChocoPyTokens.IF); }
  "else"  { return symbol(ChocoPyTokens.ELSE); }
  ">"     { return symbol(ChocoPyTokens.GREATER, yytext()); }
  "<"   { return symbol(ChocoPyTokens.LESS, yytext()); }


  {Identifier}   { return symbol(ChocoPyTokens.ID, yytext()); }
}

<STRING> {

  \\\"                     { stringBuffer.append('"'); }
  \\\\                     { stringBuffer.append('\\'); }
  \\n                      { stringBuffer.append('\n'); }
  \\t                      { stringBuffer.append('\t'); }
  \" {
      yybegin(YYINITIAL);
      return symbolFactory.newSymbol(
        "STRING",
        ChocoPyTokens.STRING,
        new ComplexSymbolFactory.Location(stringStartLine, stringStartCol),
        new ComplexSymbolFactory.Location(yyline + 1, yycolumn + 1),
        stringBuffer.toString()
      );
  }
  [^\\\"\n]                { stringBuffer.append(yytext()); }
  \n                       { return symbol(ChocoPyTokens.UNRECOGNIZED); }
  .                        { return symbol(ChocoPyTokens.UNRECOGNIZED); }
}

<<EOF>>                       { return symbol(ChocoPyTokens.EOF); }

/* Error fallback. */
[^]                           { return symbol(ChocoPyTokens.UNRECOGNIZED); }
