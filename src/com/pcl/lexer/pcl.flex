package com.pcl.lexer;
import java.io.*;
import java_cup.runtime.ComplexSymbolFactory.ComplexSymbol;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.Symbol;
import java.util.*;
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
    private int commentDepth = 0;
    StringBuilder string = new StringBuilder();

    ComplexSymbolFactory symbolFactory;
    public Scanner(java.io.Reader in, ComplexSymbolFactory sf){
        this(in);
        symbolFactory = sf;
    }

    private Symbol symbol(String name, int sym) {
        return symbolFactory.newSymbol(name, sym, new Location(yyline+1,yycolumn+1,yychar), new Location(yyline+1,yycolumn+yylength(),yychar+yylength()));
    }

    private Symbol symbol(String name, int sym, Object val) {
        Location left = new Location(yyline+1,yycolumn+1,yychar);
        Location right= new Location(yyline+1,yycolumn+yylength(), yychar+yylength());
        return symbolFactory.newSymbol(name, sym, left, right,val);
    }
    private Symbol symbol(String name, int sym, Object val,int buflength) {
        Location left = new Location(yyline+1,yycolumn+yylength()-buflength,yychar+yylength()-buflength);
        Location right= new Location(yyline+1,yycolumn+yylength(), yychar+yylength());
        return symbolFactory.newSymbol(name, sym, left, right,val);
    }


    /*private Symbol symbol(int type) {
    return new PclSymbol(type, yyline+1, yycolumn+1);
    }

    private Symbol symbol(int type, Object value) {
    return new PclSymbol(type, yyline+1, yycolumn+1, value);
    }*/

    private void printError(String type){
    System.out.println("Error: line:" + (yyline+1) + " col:" + (yycolumn+1) + " type:" + type);
    }

    public java_cup.runtime.Symbol custom_debug_next_token() throws java.io.IOException {
      java_cup.runtime.Symbol s = next_token();
      //System.out.println( "line:" + (yyline+1) + " col:" + (yycolumn+1) + " --"+ yytext() + "--" + getTokenName(s.sym) + "--");
      return s;
    }


    public String getTokenNamePrime(int token) {
        return getTokenName(token);
    }


%}

%eofval{
     return symbolFactory.newSymbol("EOF", EOF, new Location(yyline+1,yycolumn+1,yychar), new Location(yyline+1,yycolumn+1,yychar+1));
%eofval}


/* main character classes */
LineTerminator    = \r|\n|\r\n|[\u2028\u2029\u000A\u000B\u000C\u000D\u0085] | \u000D\u000A
InputCharacter    = [^\r\n]

WhiteSpace        = {LineTerminator} | [ \t\f] | " "

/* comments */
EndOfLineComment  = "//" {InputCharacter}* {LineTerminator}?

/* identifiers */
Identifier        = [:jletter:][:jletterdigit:]{0,126}

/* integer literals */
DecIntegerLiteral = 0 | [1-9][0-9]*
DecLongLiteral    = {DecIntegerLiteral} [lL]

/* floating point literals */
FloatLiteral      = ({FLit1}) {Exponent}? [fF]
DoubleLiteral     = ({FLit1}) {Exponent}?

FLit1             = [0-9]+ \. [0-9]+
Exponent          = [eE] [+-]? [0-9]+

/* string and character literals */
StringCharacter   = [^\"\\]
SingleCharacter   = [^\r\n\'\\]



%state STRING, CHARLITERAL, COMMENT

%%

<YYINITIAL> {

  /* keywords */
  "ARRAY"     { return symbol("ARRAY"       , ARRAY       , yytext()); }
  "BEGIN"     { return symbol("BEGIN"       , BEGIN       , yytext()); }
  "BOOLEAN"   { return symbol("BOOLEAN"     , BOOLEAN     , yytext()); }
  "BYTE"      { return symbol("BYTE"        , BYTE        , yytext()); }
  "CASE"      { return symbol("CASE"        , CASE        , yytext()); }
  "CHAR"      { return symbol("CHAR"        , CHAR        , yytext()); }
  "CONST"     { return symbol("CONST"       , CONST       , yytext()); }
  "DO"        { return symbol("DO"          , DO          , yytext()); }
  "DOWNTO"    { return symbol("DOWNTO"      , DOWNTO      , yytext()); }
  "ELSE"      { return symbol("ELSE"        , ELSE        , yytext()); }
  "END"       { return symbol("END"         , END         , yytext()); }
  "FILE"      { return symbol("FILE"        , FILE        , yytext()); }
  "FOR"       { return symbol("FOR"         , FOR         , yytext()); }
  "FORWARD"   { return symbol("FORWARD"     , FORWARD     , yytext()); }
  "FUNCTION"  { return symbol("FUNCTION"    , FUNCTION    , yytext()); }
  "GOTO"      { return symbol("GOTO"        , GOTO        , yytext()); }
  "IF"        { return symbol("IF"          , IF          , yytext()); }
  "IN"        { return symbol("IN"          , IN          , yytext()); }
  "INLINE"    { return symbol("INLINE"      , INLINE      , yytext()); }
  "INT"       { return symbol("INT"         , INT         , yytext()); }
  "LABEL"     { return symbol("LABEL"       , LABEL       , yytext()); }
  "LONGINT"   { return symbol("LONGINT"     , LONGINT     , yytext()); }
  "NIL"       { return symbol("NIL"         , NIL         , yytext()); }
  "OF"        { return symbol("OF"          , OF          , yytext()); }
  "PACKED"    { return symbol("PACKED"      , PACKED      , yytext()); }
  "PROCEDURE" { return symbol("PROCEDURE"   , PROCEDURE   , yytext()); }
  "PROGRAM"   { return symbol("PROGRAM"     , PROGRAM     , yytext()); }
  "READ"      { return symbol("READ"        , READ        , yytext()); }
  "REAL"      { return symbol("REAL"        , REAL        , yytext()); }
  "RECORD"    { return symbol("RECORD"      , RECORD      , yytext()); }
  "REPEAT"    { return symbol("REPEAT"      , REPEAT      , yytext()); }
  "SET"       { return symbol("SET"         , SET         , yytext()); }
  "SHORTINT"  { return symbol("SHORTINT"    , SHORTINT    , yytext()); }
  "STRING"    { return symbol("STRING_TYPE" , STRING_TYPE , yytext()); }
  "THEN"      { return symbol("THEN"        , THEN        , yytext()); }
  "TO"        { return symbol("TO"          , TO          , yytext()); }
  "TYPE"      { return symbol("TYPE"        , TYPE        , yytext()); }
  "UNTIL"     { return symbol("UNTIL"       , UNTIL       , yytext()); }
  "VAR"       { return symbol("VAR"         , VAR         , yytext()); }
  "WHILE"     { return symbol("WHILE"       , WHILE       , yytext()); }
  "WITH"      { return symbol("WITH"        , WITH        , yytext()); }
  "WRITE"     { return symbol("WRITE"       , WRITE       , yytext()); }

  /* OPERADORES */
  "AND"       { return symbol("AND" , AND , yytext()); }
  "NOT"       { return symbol("NOT" , NOT , yytext()); }
  "OR"        { return symbol("OR"  , OR  , yytext()); }
  "XOR"       { return symbol("XOR" , XOR , yytext()); }
  "DIV"       { return symbol("DIV" , DIV , yytext()); }
  "MOD"       { return symbol("MOD" , MOD , yytext()); }

  ","         { return symbol("COMMA"      , COMMA      , yytext()); }
  ";"         { return symbol("SEMICOLON"  , SEMICOLON  , yytext()); }
  "++"        { return symbol("PLUSPLUS"   , PLUSPLUS   , yytext()); }
  "--"        { return symbol("MINUSMINUS" , MINUSMINUS , yytext()); }
  ">="        { return symbol("GTEQ"       , GTEQ       , yytext()); }
  ">"         { return symbol("GT"         , GT         , yytext()); }
  "<="        { return symbol("LTEQ"       , LTEQ       , yytext()); }
  "<"         { return symbol("LT"         , LT         , yytext()); }
  "<>"        { return symbol("NEQ"        , NEQ        , yytext()); }
  "="         { return symbol("EQ"         , EQ         , yytext()); }
  "+"         { return symbol("PLUS"       , PLUS       , yytext()); }
  "-"         { return symbol("MINUS"      , MINUS      , yytext()); }
  "*"         { return symbol("MULT"       , MULT       , yytext()); }
  "/"         { return symbol("DIV_SYM"    , DIV_SYM    , yytext()); }
  "("         { return symbol("LPAREN"     , LPAREN     , yytext()); }
  ")"         { return symbol("RPAREN"     , RPAREN     , yytext()); }
  "["         { return symbol("LBRACK"     , LBRACK     , yytext()); }
  "]"         { return symbol("RBRACK"     , RBRACK     , yytext()); }
  ":="        { return symbol("ASSIGN"     , ASSIGN     , yytext()); }
  "."         { return symbol("DOT"        , DOT        , yytext()); }
  ":"         { return symbol("COLON"      , COLON      , yytext()); }
  "+="        { return symbol("PLUSEQ"     , PLUSEQ     , yytext()); }
  "-="        { return symbol("MINUSEQ"    , MINUSEQ    , yytext()); }
  "*="        { return symbol("MULTEQ"     , MULTEQ     , yytext()); }
  "/="        { return symbol("DIVEQ"      , DIVEQ      , yytext()); }
  ">>"        { return symbol("RSHIFT"     , RSHIFT     , yytext()); }
  "<<"        { return symbol("LSHIFT"     , LSHIFT     , yytext()); }
  "<<="       { return symbol("LSHIFTEQ"   , LSHIFTEQ   , yytext()); }
  ">>="       { return symbol("RSHIFTEQ"   , RSHIFTEQ   , yytext()); }

  /* bool literal */
  "TRUE"      { return symbol("BOOLEAN_LITERAL" , BOOLEAN_LITERAL , new Boolean(yytext())); } //TODO change TYPE_LITERALS
  "FALSE"     { return symbol("BOOLEAN_LITERAL" , BOOLEAN_LITERAL , new Boolean(yytext())); }

  /* string literal */
  \"                             { yybegin(STRING); string.setLength(0); }

  /* character literal */
  \'                             { yybegin(CHARLITERAL); }
  \#{DecIntegerLiteral}          { return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL, yytext()); }

  /* numeric literals */
  "-2147483648"                  { return symbol("INTEGER_LITERAL", INTEGER_LITERAL, new Integer(Integer.MIN_VALUE)); }

  {DecIntegerLiteral}            { return symbol("INTEGER_LITERAL", INTEGER_LITERAL, new Integer(yytext())); }
  {DecLongLiteral}               { return symbol("INTEGER_LITERAL", INTEGER_LITERAL, new Long(yytext().substring(0,yylength()-1))); }

  {FloatLiteral}                 { return symbol("FLOATING_POINT_LITERAL", FLOATING_POINT_LITERAL, new Float(yytext().substring(0,yylength()-1))); }
  {DoubleLiteral}                { return symbol("FLOATING_POINT_LITERAL", FLOATING_POINT_LITERAL, new Double(yytext())); }
  {DoubleLiteral}[dD]            { return symbol("FLOATING_POINT_LITERAL", FLOATING_POINT_LITERAL, new Double(yytext().substring(0,yylength()-1))); }

  /* comments */
  {EndOfLineComment}             { /* ignore */ }
  "{"                            { commentDepth++; yybegin(COMMENT); }
  "(*"                           { commentDepth++; yybegin(COMMENT); }
  {LineTerminator}               { /* ignore */ }

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }

  /* identifiers */
  {Identifier}                   { return symbol("IDENTIFIER", IDENTIFIER, yytext()); }
}

<COMMENT> {
  "{"      { commentDepth++; }
  "}"      { commentDepth--;
              if (commentDepth <= 0) yybegin(YYINITIAL);
                             }
  "(*"     { commentDepth++; }
  "*)"     { commentDepth--;
              if (commentDepth <= 0) yybegin(YYINITIAL);
                             }
  <<EOF>>  { printError("Unterminated comment at end of line"); return symbol("EOF", EOF);}

  .|[\r\n] { /* ignore */ }
}

<STRING> {
   \"                  { yybegin(YYINITIAL); return symbol("STRING_LITERAL", STRING_LITERAL, string.toString(), string.length()); }

   {StringCharacter}\" { yybegin(YYINITIAL); return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL,yytext().charAt(0)); }
   {StringCharacter}+  { string.append( yytext() ); }

    /* escape sequences */
   "\\b"               { string.append( '\b' ); }
   "\\t"               { string.append( '\t' ); }
   //"\\n"             { string.append( '\n' ); }
   // "\\f"            { string.append( '\f' ); }
   // "\\r"            { string.append( '\r' ); }
   "\\\""              { string.append( '\"' ); }
   "\\'"               { string.append( '\'' ); }
   "\\\\"              { string.append( '\\' ); }

    /* error cases */
   \\.                 { printError("Illegal escape sequence \""+yytext()+"\""); }
   {LineTerminator}    { printError("Unterminated string at end of line"); }
   <<EOF>>             { printError("Unterminated string at end of file"); return symbol("EOF", EOF); }
}

<CHARLITERAL> {
    \'                 { yybegin(YYINITIAL); return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL, string.toString()); }
   {SingleCharacter}\' { yybegin(YYINITIAL); return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL, yytext().charAt(0)); }
    /* escape sequences */
   "\\b"\'             { yybegin(YYINITIAL); return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL, '\b');}
   "\\t"\'             { yybegin(YYINITIAL); return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL, '\t');}
   //"\\n"\'           { yybegin(YYINITIAL); return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL, '\n');}
   // "\\f"\'          { yybegin(YYINITIAL); return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL, '\f');}
   // "\\r"\'          { yybegin(YYINITIAL); return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL, '\r');}
   "\\\""\'            { yybegin(YYINITIAL); return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL, '\"');}
   "\\'"\'             { yybegin(YYINITIAL); return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL, '\'');}
   "\\\\"\'            { yybegin(YYINITIAL); return symbol("CHARACTER_LITERAL", CHARACTER_LITERAL, '\\'); }


    /* error cases */
   \\.                 { printError("Illegal escape sequence \""+yytext()+"\""); }
   {LineTerminator}    { printError("Unterminated character literal at end of line"); }
   <<EOF>>             { printError("Unterminated character at end of file"); return symbol("EOF", EOF); }
}

/* error fallback */
[^]                              { printError("Illegal character \""+yytext()+
                                                              "\" at line "+(yyline+1)+", column "+(yycolumn+1)); }