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
LineTerminator = \r|\n|\r\n|[\u2028\u2029\u000A\u000B\u000C\u000D\u0085] | \u000D\u000A
InputCharacter = [^\r\n]

WhiteSpace = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} |
          {DocumentationComment}
PCLCommentChar = [^*)] | ")"+[^*)] | "*"+[^*)] | [^}\n]*"}"
PCLComment = ~"*)"

TraditionalComment = [^*] ~"*)" | "*"+ ")" | ~"}"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "*"+ [^(*] ~"*)"

lbrace			= \{
rbrace			= ~"}"
nobrace			= [^{}]
comment_body_brace	= {nobrace}*

lparenthesis    = "(*"
rparenthesis	= ~"*)"
noparenthesis	= [^(**)]
comment_body_parenthesis = {noparenthesis}*

/* identifiers */
Identifier = [:jletter:][:jletterdigit:]{0,126}

/* integer literals */
DecIntegerLiteral = 0 | [1-9][0-9]*
DecLongLiteral    = {DecIntegerLiteral} [lL]

/* floating point literals */
FloatLiteral  = ({FLit1}) {Exponent}? [fF]
DoubleLiteral = ({FLit1}) {Exponent}?

FLit1    = [0-9]+ \. [0-9]+
FLit2    = \. [0-9]+
FLit3    = [0-9]+
Exponent = [eE] [+-]? [0-9]+

/* string and character literals */
StringCharacter = [^\"\\]
SingleCharacter = [^\r\n\'\\]

%state STRING, CHARLITERAL, COMMENT

%%

<YYINITIAL> {

  /* keywords */
    "ARRAY"                       { return symbol(ARRAY      , yytext()); }
    "BEGIN"                       { return symbol(BEGIN      , yytext()); }
    "BOOLEAN"                     { return symbol(BOOLEAN    , yytext()); }
    "BYTE"                        { return symbol(BYTE       , yytext()); }
    "CASE"                        { return symbol(CASE       , yytext()); }
    "CHAR"                        { return symbol(CHAR       , yytext()); }
    "CONST"                       { return symbol(CONST      , yytext()); }
    "DO"                          { return symbol(DO         , yytext()); }
    "DOWNTO"                      { return symbol(DOWNTO     , yytext()); }
    "ELSE"                        { return symbol(ELSE       , yytext()); }
    "END"                         { return symbol(END        , yytext()); }
    "FALSE"                       { return symbol(FALSE      , yytext()); }
    "FILE"                        { return symbol(FILE       , yytext()); }
    "FOR"                         { return symbol(FOR        , yytext()); }
    "FORWARD"                     { return symbol(FORWARD    , yytext()); }
    "FUNCTION"                    { return symbol(FUNCTION  , yytext()); }
    "GOTO"                        { return symbol(GOTO       , yytext()); }
    "IF"                          { return symbol(IF         , yytext()); }
    "IN"                          { return symbol(IN         , yytext()); }
    "INLINE"                      { return symbol(INLINE     , yytext()); }
    "INT"                         { return symbol(INT        , yytext()); }
    "LABEL"                       { return symbol(LABEL      , yytext()); }
    "LONGINT"                     { return symbol(LONGINT    , yytext()); }
    "NIL"                         { return symbol(NIL        , yytext()); }
    "OF"                          { return symbol(OF         , yytext()); }
    "PACKED"                      { return symbol(PACKED     , yytext()); }
    "PROCEDURE"                   { return symbol(PROCEDURE , yytext()); }
    "PROGRAM"                     { return symbol(PROGRAM    , yytext()); }
    "READ"                        { return symbol(READ       , yytext()); }
    "REAL"                        { return symbol(REAL       , yytext()); }
    "RECORD"                      { return symbol(RECORD     , yytext()); }
    "REPEAT"                      { return symbol(REPEAT     , yytext()); }
    "SET"                         { return symbol(SET        , yytext()); }
    "SHORTINT"                    { return symbol(SHORTINT  , yytext()); }
    "STRING"                      { return symbol(STRING     , yytext()); }
    "THEN"                        { return symbol(THEN       , yytext()); }
    "TO"                          { return symbol(TO         , yytext()); }
    "TRUE"                        { return symbol(TRUE       , yytext()); }
    "TYPE"                        { return symbol(TYPE       , yytext()); }
    "UNTIL"                       { return symbol(UNTIL      , yytext()); }
    "VAR"                         { return symbol(VAR        , yytext()); }
    "WHILE"                       { return symbol(WHILE      , yytext()); }
    "WITH"                        { return symbol(WITH       , yytext()); }
    "WRITE"                       { return symbol(WRITE      , yytext()); }

  /* OPERADORES */
  "AND"                          { return symbol(AND,yytext()); }
  "NOT"                          { return symbol(NOT,yytext()); }
  "OR"                           { return symbol(OR,yytext()); }
  "XOR"                          { return symbol(XOR,yytext()); }
  "DIV"                          { return symbol(DIV,yytext()); }
  "MOD"                          { return symbol(MOD,yytext()); }

    ","                            { return symbol(COMMA      , yytext()); } //valid
    ";"                            { return symbol(SEMICOLON  , yytext()); } //valid
    "++"                           { return symbol(PLUSPLUS   , yytext()); } //valid
    "--"                           { return symbol(MINUSMINUS , yytext()); } //valid
    ">="                           { return symbol(GTEQ       , yytext()); } //valid
    ">"                            { return symbol(GT         , yytext()); } //valid
    "<="                           { return symbol(LTEQ       , yytext()); } //valid
    "<"                            { return symbol(LT         , yytext()); } //valid
    "<>"                           { return symbol(NEQ        , yytext()); } //valid
    "="                            { return symbol(EQ         , yytext()); } //valid
    "+"                            { return symbol(PLUS       , yytext()); } //valid
    "-"                            { return symbol(MINUS      , yytext()); } //valid
    "*"                            { return symbol(MULT       , yytext()); } //valid
    "/"                            { return symbol(DIV_SYM    , yytext()); } //valid
    "("                            { return symbol(LPAREN     , yytext()); } //valid
    ")"                            { return symbol(RPAREN     , yytext()); } //valid
    "["                            { return symbol(LBRACK     , yytext()); } //valid
    "]"                            { return symbol(RBRACK     , yytext()); } //valid
    ":="                           { return symbol(ASSIGN     , yytext()); } //valid
    "."                            { return symbol(DOT        , yytext()); } //valid
    ":"                            { return symbol(COLON      , yytext()); } //valid
    "+="                           { return symbol(PLUSEQ     , yytext()); } //valid
    "-="                           { return symbol(MINUSEQ    , yytext()); } //valid
    "*="                           { return symbol(MULTEQ     , yytext()); } //valid
    "/="                           { return symbol(DIVEQ      , yytext()); } //valid
    ">>"                           { return symbol(RSHIFT     , yytext()); } //valid
    "<<"                           { return symbol(LSHIFT     , yytext()); } //valid
    "<<="                          { return symbol(LSHIFTEQ   , yytext()); } //valid
    ">>="                          { return symbol(RSHIFTEQ   , yytext()); } //valid

  /* string literal */
  \"                             { yybegin(STRING); string.setLength(0); }

  /* character literal */
  \'                             { yybegin(CHARLITERAL); }
  \#{DecIntegerLiteral}          { return symbol(CHARACTER_LITERAL, yytext()); }

  /* numeric literals */

  /* This is matched together with the minus, because the number is too big to
     be represented by a positive integer. */
  "-2147483648"                  { return symbol(INTEGER_LITERAL, new Integer(Integer.MIN_VALUE)); }

  {DecIntegerLiteral}            { return symbol(INTEGER_LITERAL, new Integer(yytext())); }
  {DecLongLiteral}               { return symbol(INTEGER_LITERAL, new Long(yytext().substring(0,yylength()-1))); }

  {FloatLiteral}                 { return symbol(FLOATING_POINT_LITERAL, new Float(yytext().substring(0,yylength()-1))); }
  {DoubleLiteral}                { return symbol(FLOATING_POINT_LITERAL, new Double(yytext())); }
  {DoubleLiteral}[dD]            { return symbol(FLOATING_POINT_LITERAL, new Double(yytext().substring(0,yylength()-1))); }

  /* comments */
  {lparenthesis}                 { yybegin(COMMENT); }
  {lbrace}                       { yybegin(COMMENT); }
  {EndOfLineComment}             { /* ignore */ }
  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }

  /* identifiers */
  {Identifier}                   { return symbol(IDENTIFIER, yytext()); }
}

<COMMENT> {

  {lbrace}						{  }
  {rbrace}						{ yybegin(YYINITIAL); }
  {comment_body_brace}				{ }

  {lparenthesis}						{  }
  {rparenthesis}						{ yybegin(YYINITIAL); }
  {comment_body_parenthesis}				{ }

  //{PCLComment}                   { /* ignore */ }

  <<EOF>>                        { printError("Unterminated comment at end of file"); return symbol(EOF); }
}

<STRING> {
  \"                             { yybegin(YYINITIAL); return symbol(STRING_LITERAL, string.toString()); }

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


  /* error cases */
  \\.                            { printError("Illegal escape sequence \""+yytext()+"\""); }
  {LineTerminator}               { printError("Unterminated string at end of line"); }
  <<EOF>>                        { printError("Unterminated string at end of file"); return symbol(EOF); }
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


  /* error cases */
  \\.                            { printError("Illegal escape sequence \""+yytext()+"\""); }
  {LineTerminator}               { printError("Unterminated character literal at end of line"); }
  <<EOF>>                        { printError("Unterminated character at end of file"); return symbol(EOF); }
}

/* error fallback */
[^]                              { printError("Illegal character \""+yytext()+
                                                              "\" at line "+(yyline+1)+", column "+(yycolumn+1)); }
<<EOF>>                          { return symbol(EOF); }