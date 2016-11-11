package com.pcl.lexer;
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 2004-2015  Gerwin Klein <lsf@jflex.de>                    *
 * All rights reserved.                                                    *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */



import java_cup.runtime.Symbol;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;


/**
 * Simple test driver for the java lexer. Just runs it on some
 * input files and produces debug output. Needs symbol class from
 * parser.
 */
public class TestLexer {

  /** some numerals to for lexer testing */
  public static void main(String argv[]) {
    boolean control = true;
    boolean withArgv = argv.length != 0;
    boolean firstUse = true;
    while(control){

      BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
      String opc;
      String dir;
      TokenTable tokenTable = new TokenTable();
      try{
        if(withArgv && firstUse){
          opc = "1";
        }else{
          System.out.println("\n1. Scan pcl file...");
          System.out.println("2. Exit");
          System.out.print("->");
          opc = br.readLine();
        }

        if (opc.equals("1")){
          if(withArgv && firstUse){
            dir = argv[0];
          }else{
            System.out.println("Write pcl file url");
            System.out.print("->");
            dir = br.readLine();
          }

          try {
            System.out.println("Lexing ["+dir+"]");
            Scanner scanner = new Scanner(new FileReader(dir));
            Symbol s;
            do {
              s = scanner.custom_debug_next_token();
              //System.out.println("token: "+s);
              tokenTable.agregarFila((PclSymbol) s);
              //System.out.println("s.sym = " + getTokenName(s.sym));
            } while (s.sym != sym.EOF);

            //System.out.println("No errors.");
            tokenTable.imprimirTable();
          }
          catch (Exception e) {
            System.out.println("Invalid URL. Try again!");
          }

          try {
            parser p = new parser(new Scanner(new FileReader(dir)));
            Object result = p.debug_parse().value;

          } catch (Exception e) {
          /* do cleanup here -- possibly rethrow e */
            e.printStackTrace();
          }

        }
        else if(opc.equals("2")){
          control = false;
        }
        else{
          System.out.println("Invalid choice. Try again!");
        }
      }
      catch(IOException ioe){
        System.out.println("IO error trying to read. Try again!");
      }
      firstUse = false;
    }

  }
}
