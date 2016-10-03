package com.pcl.lexer;
import java_cup.runtime.*;
%%

%public
%class Scanner
%implements sym

%unicode

%line
%column

%cup
%cupdebug

%{
  StringBuilder string = new StringBuilder();

  private Symbol symbol(int type) {
    return new PclSymbol(type, yyline+1, yycolumn+1);
  }

  private Symbol symbol(int type, Object value) {
    return new PclSymbol(type, yyline+1, yycolumn+1, value);
  }

  private void printError(String type){
    System.out.println("Error: line:" + (yyline+1) + " col:" + (yycolumn+1) + " type:" + type);
  }

  public java_cup.runtime.Symbol custom_debug_next_token() throws java.io.IOException {
      java_cup.runtime.Symbol s = next_token();
      //System.out.println( "line:" + (yyline+1) + " col:" + (yycolumn+1) + " --"+ yytext() + "--" + getTokenName(s.sym) + "--");
      return s;
  }


%}

/* main character classes */
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

WhiteSpace = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} |
          {DocumentationComment}

TraditionalComment = "(*" [^*] ~"*)" | "(*" "*"+ ")" | "{" ~"}"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "(*" "*"+ [^(*] ~"*)"

/* identifiers */
Identifier = [:jletter:][:jletterdigit:]{1,126}

/* integer literals */
DecIntegerLiteral = 0 | [1-9][0-9]*
DecLongLiteral    = {DecIntegerLiteral} [lL]

/***HexIntegerLiteral = 0 [xX] 0* {HexDigit} {1,8}
HexLongLiteral    = 0 [xX] 0* {HexDigit} {1,16} [lL]
HexDigit          = [0-9a-fA-F]

OctIntegerLiteral = 0+ [1-3]? {OctDigit} {1,15}
OctLongLiteral    = 0+ 1? {OctDigit} {1,21} [lL]
OctDigit          = [0-7]***/

/* floating point literals */
FloatLiteral  = ({FLit1}|{FLit2}|{FLit3}) {Exponent}? [fF]
DoubleLiteral = ({FLit1}|{FLit2}|{FLit3}) {Exponent}?

FLit1    = [0-9]+ \. [0-9]*
FLit2    = \. [0-9]+
FLit3    = [0-9]+
Exponent = [eE] [+-]? [0-9]+

/* string and character literals */
StringCharacter = [^\"\\]
SingleCharacter = [^\r\n\'\\]

%state STRING, CHARLITERAL

%%

<YYINITIAL> {

  /* keywords */
  "ARRAY"                        { return symbol(PALABRA_RESERVADA,yytext()); }
  "BEGIN"                        { return symbol(PALABRA_RESERVADA,yytext()); }
  "BOOLEAN"                      { return symbol(PALABRA_RESERVADA,yytext()); }
  "BYTE"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "CASE"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "CHAR"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "CONST"                        { return symbol(PALABRA_RESERVADA,yytext()); }
  "DO"                           { return symbol(PALABRA_RESERVADA,yytext()); }
  "DOWNTO"                       { return symbol(PALABRA_RESERVADA,yytext()); }
  "ELSE"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "END"                          { return symbol(PALABRA_RESERVADA,yytext()); }
  "FALSE"                        { return symbol(PALABRA_RESERVADA,yytext()); }
  "FILE"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "FOR"                          { return symbol(PALABRA_RESERVADA,yytext()); }
  "FORWARD"                      { return symbol(PALABRA_RESERVADA,yytext()); }
  "FUNCTION"                     { return symbol(PALABRA_RESERVADA,yytext()); }
  "GOTO"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "IF"                           { return symbol(PALABRA_RESERVADA,yytext()); }
  "IN"                           { return symbol(PALABRA_RESERVADA,yytext()); }
  "INLINE"                       { return symbol(PALABRA_RESERVADA,yytext()); }
  "INT"                          { return symbol(PALABRA_RESERVADA,yytext()); }
  "LABEL"                        { return symbol(PALABRA_RESERVADA,yytext()); }
  "LONGINT"                      { return symbol(PALABRA_RESERVADA,yytext()); }
  "NIL"                          { return symbol(PALABRA_RESERVADA,yytext()); }
  "OF"                           { return symbol(PALABRA_RESERVADA,yytext()); }
  "PACKED"                       { return symbol(PALABRA_RESERVADA,yytext()); }
  "PROCEDURE"                    { return symbol(PALABRA_RESERVADA,yytext()); }
  "PROGRAM"                      { return symbol(PALABRA_RESERVADA,yytext()); }
  "READ"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "REAL"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "RECORD"                       { return symbol(PALABRA_RESERVADA,yytext()); }
  "REPEAT"                       { return symbol(PALABRA_RESERVADA,yytext()); }
  "SET"                          { return symbol(PALABRA_RESERVADA,yytext()); }
  "SHORTINT"                     { return symbol(PALABRA_RESERVADA,yytext()); }
  "STRING"                       { return symbol(PALABRA_RESERVADA,yytext()); }
  "THEN"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "TO"                           { return symbol(PALABRA_RESERVADA,yytext()); }
  "TRUE"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "TYPE"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "UNTIL"                        { return symbol(PALABRA_RESERVADA,yytext()); }
  "VAR"                          { return symbol(PALABRA_RESERVADA,yytext()); }
  "WHILE"                        { return symbol(PALABRA_RESERVADA,yytext()); }
  "WITH"                         { return symbol(PALABRA_RESERVADA,yytext()); }
  "WRITE"                        { return symbol(PALABRA_RESERVADA,yytext()); }



  /* OPERADORES */
  "AND"                          { return symbol(OPERADOR,yytext()); }
  "NOT"                          { return symbol(OPERADOR,yytext()); }
  "OR"                           { return symbol(OPERADOR,yytext()); }
  "XOR"                          { return symbol(OPERADOR,yytext()); }
  "DIV"                          { return symbol(OPERADOR,yytext()); }
  "MOD"                          { return symbol(OPERADOR,yytext()); }

  ","                            { return symbol(OPERADOR,yytext()); } //valid
  ";"                            { return symbol(OPERADOR,yytext()); } //valid
  "++"                           { return symbol(OPERADOR,yytext()); } //valid
  "--"                           { return symbol(OPERADOR,yytext()); } //valid
  ">="                           { return symbol(OPERADOR,yytext()); } //valid
  ">"                            { return symbol(OPERADOR,yytext()); } //valid
  "<="                           { return symbol(OPERADOR,yytext()); } //valid
  "<"                            { return symbol(OPERADOR,yytext()); } //valid
  "<>"                           { return symbol(OPERADOR,yytext()); } //valid
  "="                            { return symbol(OPERADOR,yytext()); } //valid
  "+"                            { return symbol(OPERADOR,yytext()); } //valid
  "-"                            { return symbol(OPERADOR,yytext()); } //valid
  "*"                            { return symbol(OPERADOR,yytext()); } //valid
  "/"                            { return symbol(OPERADOR,yytext()); } //valid
  "("                            { return symbol(OPERADOR,yytext()); } //valid
  ")"                            { return symbol(OPERADOR,yytext()); } //valid
  "["                            { return symbol(OPERADOR,yytext()); } //valid
  "]"                            { return symbol(OPERADOR,yytext()); } //valid
  ":="                           { return symbol(OPERADOR,yytext()); } //valid
  "."                            { return symbol(OPERADOR,yytext()); } //valid
  ":"                            { return symbol(OPERADOR,yytext()); } //valid
  "+="                           { return symbol(OPERADOR,yytext()); } //valid
  "-="                           { return symbol(OPERADOR,yytext()); } //valid
  "*="                           { return symbol(OPERADOR,yytext()); } //valid
  "/="                           { return symbol(OPERADOR,yytext()); } //valid
  ">>"                           { return symbol(OPERADOR,yytext()); } //valid
  "<<"                           { return symbol(OPERADOR,yytext()); } //valid
  "<<="                          { return symbol(OPERADOR,yytext()); } //valid
  ">>="                          { return symbol(OPERADOR,yytext()); } //valid

  /* string literal */
  \"                             { yybegin(STRING); string.setLength(0); }

  /* character literal */
  \'                             { yybegin(CHARLITERAL); }

  /* numeric literals */

  /* This is matched together with the minus, because the number is too big to
     be represented by a positive integer. */
  "-2147483648"                  { return symbol(INTEGER_LITERAL, new Integer(Integer.MIN_VALUE)); }

  {DecIntegerLiteral}            { return symbol(INTEGER_LITERAL, new Integer(yytext())); }
  {DecLongLiteral}               { return symbol(INTEGER_LITERAL, new Long(yytext().substring(0,yylength()-1))); }

  /***{HexIntegerLiteral}            { return symbol(INTEGER_LITERAL, new Integer((int) parseLong(2, yylength(), 16))); }
  {HexLongLiteral}               { return symbol(INTEGER_LITERAL, new Long(parseLong(2, yylength()-1, 16))); }

  {OctIntegerLiteral}            { return symbol(INTEGER_LITERAL, new Integer((int) parseLong(0, yylength(), 8))); }
  {OctLongLiteral}               { return symbol(INTEGER_LITERAL, new Long(parseLong(0, yylength()-1, 8))); }***/

  {FloatLiteral}                 { return symbol(FLOATING_POINT_LITERAL, new Float(yytext().substring(0,yylength()-1))); }
  {DoubleLiteral}                { return symbol(FLOATING_POINT_LITERAL, new Double(yytext())); }
  {DoubleLiteral}[dD]            { return symbol(FLOATING_POINT_LITERAL, new Double(yytext().substring(0,yylength()-1))); }

  /* comments */
  {Comment}                      { /* ignore */ }

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }

  /* identifiers */
  {Identifier}                   { return symbol(IDENTIFICADOR, yytext()); }
}

<STRING> {
  \"                             { yybegin(YYINITIAL); return symbol(STRING_LITERAL, string.toString()); }
  "#"{DecIntegerLiteral}         { string.append( (char)Integer.parseInt(yytext().substring(1)) ); }
  {StringCharacter}\"            { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL,yytext().charAt(0)); }
  {StringCharacter}+             { string.append( yytext() ); }


  /* escape sequences */
  "\\b"                          { string.append( '\b' ); }
  "\\t"                          { string.append( '\t' ); }
 //"\\n"                          { string.append( '\n' ); }
 // "\\f"                          { string.append( '\f' ); }
 // "\\r"                          { string.append( '\r' ); }
  "\\\""                         { string.append( '\"' ); }
  "\\'"                          { string.append( '\'' ); }
  "\\\\"                         { string.append( '\\' ); }
  /***\\[0-3]?{OctDigit}?{OctDigit}  { char val = (char) Integer.parseInt(yytext().substring(1),8);
                        				   string.append( val ); }***/

  /* error cases */
  \\.                            { printError("Illegal escape sequence \""+yytext()+"\""); }
  {LineTerminator}               { printError("Unterminated string at end of line"); }
}

<CHARLITERAL> {
  {SingleCharacter}\'            { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, yytext().charAt(0)); }
  /* escape sequences */
  "\\b"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\b');}
  "\\t"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\t');}
 //"\\n"\'                         { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\n');}
 // "\\f"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\f');}
 // "\\r"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\r');}
  "\\\""\'                       { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\"');}
  "\\'"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\'');}
  "\\\\"\'                       { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\\'); }
  /***\\[0-3]?{OctDigit}?{OctDigit}\' { yybegin(YYINITIAL);
			                              int val = Integer.parseInt(yytext().substring(1,yylength()-1),8);
			                            return symbol(CHARACTER_LITERAL, (char)val); }***/

  /* error cases */
  \\.                            { printError("Illegal escape sequence \""+yytext()+"\""); }
  {LineTerminator}               { printError("Unterminated character literal at end of line"); }
}

/* error fallback */
[^]                              { printError("Illegal character \""+yytext()+
                                                              "\" at line "+yyline+", column "+yycolumn); }
<<EOF>>                          { return symbol(EOF); }