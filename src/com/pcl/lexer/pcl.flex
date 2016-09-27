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
StringCharacter = [^\r\n\"\\]
SingleCharacter = [^\r\n\'\\]

%state STRING, CHARLITERAL

%%

<YYINITIAL> {

  /* keywords */
  "AND"                          { return symbol(AND); }

  /* boolean literals */
  "true"                         { return symbol(BOOLEAN_LITERAL, true); } //----------**
  "false"                        { return symbol(BOOLEAN_LITERAL, false); } //----------**

  /* null literal */
  "nil"                         { return symbol(NIL); }


  /* separators */
  "("                            { return symbol(LPAREN); } //valid
  ")"                            { return symbol(RPAREN); } //valid
  "["                            { return symbol(LBRACK); } //valid
  "]"                            { return symbol(RBRACK); } //valid
  ";"                            { return symbol(SEMICOLON); } //valid
  ","                            { return symbol(COMMA); } //valid
  "."                            { return symbol(DOT); } //valid

  /* operators */
  "="                            { return symbol(EQ); } //valid
  ">"                            { return symbol(GT); } //valid
  "<"                            { return symbol(LT); } //valid
  //"!"                            { return symbol(NOT); }
  //"~"                            { return symbol(COMP); }
  //"?"                            { return symbol(QUESTION); }
  ":"                            { return symbol(COLON); } //valid
  //"=="                           { return symbol(EQEQ); }
  "<="                           { return symbol(LTEQ); } //valid
  ">="                           { return symbol(GTEQ); } //valid
  //"!="                           { return symbol(NOTEQ); }
  //"&&"                           { return symbol(ANDAND); }
  //"||"                           { return symbol(OROR); }
  "++"                           { return symbol(PLUSPLUS); } //valid
  "--"                           { return symbol(MINUSMINUS); } //valid
  "+"                            { return symbol(PLUS); } //valid
  "-"                            { return symbol(MINUS); } //valid
  "*"                            { return symbol(MULT); } //valid
  "/"                            { return symbol(DIV); } //valid
  //"&"                            { return symbol(AND); }
  //"|"                            { return symbol(OR); }
  //"^"                            { return symbol(XOR); }
  //"%"                            { return symbol(MOD); }
  "<<"                           { return symbol(LSHIFT); } //valid
  ">>"                           { return symbol(RSHIFT); } //valid
  ">>>"                          { return symbol(URSHIFT); }
  "+="                           { return symbol(PLUSEQ); } //valid
  "-="                           { return symbol(MINUSEQ); } //valid
  "*="                           { return symbol(MULTEQ); } //valid
  "/="                           { return symbol(DIVEQ); } // valid
  //"&="                           { return symbol(ANDEQ); }
  //"|="                           { return symbol(OREQ); }
  //"^="                           { return symbol(XOREQ); }
  //"%="                           { return symbol(MODEQ); }
  "<<="                          { return symbol(LSHIFTEQ); } //valid
  ">>="                          { return symbol(RSHIFTEQ); } //valid
  //">>>="                         { return symbol(URSHIFTEQ); }

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
  {Identifier}                   { return symbol(IDENTIFIER, yytext()); }
}

<STRING> {
  \"                             { yybegin(YYINITIAL); return symbol(STRING_LITERAL, string.toString()); }
  "#"{DecIntegerLiteral}         { string.append( (char)Integer.parseInt(yytext().substring(1)) ); }
  {StringCharacter}+             { string.append( yytext() ); }

  /* escape sequences */
  "\\b"                          { string.append( '\b' ); }
  "\\t"                          { string.append( '\t' ); }
  "\\n"                          { string.append( '\n' ); }
  "\\f"                          { string.append( '\f' ); }
  "\\r"                          { string.append( '\r' ); }
  "\\\""                         { string.append( '\"' ); }
  "\\'"                          { string.append( '\'' ); }
  "\\\\"                         { string.append( '\\' ); }
  /***\\[0-3]?{OctDigit}?{OctDigit}  { char val = (char) Integer.parseInt(yytext().substring(1),8);
                        				   string.append( val ); }***/

  /* error cases */
  \\.                            { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
  {LineTerminator}               { throw new RuntimeException("Unterminated string at end of line"); }
}

<CHARLITERAL> {
  {SingleCharacter}\'            { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, yytext().charAt(0)); }

  /* escape sequences */
  "\\b"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\b');}
  "\\t"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\t');}
  "\\n"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\n');}
  "\\f"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\f');}
  "\\r"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\r');}
  "\\\""\'                       { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\"');}
  "\\'"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\'');}
  "\\\\"\'                       { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\\'); }
  /***\\[0-3]?{OctDigit}?{OctDigit}\' { yybegin(YYINITIAL);
			                              int val = Integer.parseInt(yytext().substring(1,yylength()-1),8);
			                            return symbol(CHARACTER_LITERAL, (char)val); }***/

  /* error cases */
  \\.                            { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
  {LineTerminator}               { throw new RuntimeException("Unterminated character literal at end of line"); }
}

/* error fallback */
[^]                              { throw new RuntimeException("Illegal character \""+yytext()+
                                                              "\" at line "+yyline+", column "+yycolumn); }
<<EOF>>                          { return symbol(EOF); }