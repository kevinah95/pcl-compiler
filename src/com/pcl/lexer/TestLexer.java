package com.pcl.lexer;
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 2004-2015  Gerwin Klein <lsf@jflex.de>                    *
 * All rights reserved.                                                    *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

import java_cup.runtime.Symbol;
import jflex.LexScan;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Arrays;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Hashtable;


/**
 * Simple test driver for the java lexer. Just runs it on some
 * input files and produces debug output. Needs symbol class from
 * parser. 
 */
public class TestLexer {

  /** some numerals to for lexer testing */
  /*int intDec = 37;
  long longDec = 37l;
  int intHex = 0x0001;
  long longHex = 0xFFFFl;
  int intOct = 0377;
  long longOc = 007l;
  int smallest = -2147483648;*/



  public static void main(String argv[]) {

    /*Hashtable table = new Hashtable();
    table.put("VALOR","90");
    table.put("VaLor","90");*/
    //Collections.list(table.keys()).forEach(num -> System.out.println(num));

    TokenTable tokenTable = new TokenTable();

    for (int i = 0; i < argv.length; i++) {
      System.out.println(argv[i]);
      try {
        System.out.println("Lexing ["+argv[i]+"]");
        Scanner scanner = new Scanner(new FileReader(argv[i]));
        Symbol s;
        do {
          s = scanner.debug_next_token();
          //System.out.println("token: "+s);
          tokenTable.agregarFila((PclSymbol) s);
          //System.out.println("s.sym = " + getTokenName(s.sym));
        } while (s.sym != sym.EOF);
        
        System.out.println("No errors.");
        tokenTable.imprimirTable();
      }
      catch (Exception e) {
        e.printStackTrace(System.out);
        System.exit(1);
      }
    }
  }
}
