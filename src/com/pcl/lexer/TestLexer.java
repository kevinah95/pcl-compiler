package com.pcl.lexer;
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 2004-2015  Gerwin Klein <lsf@jflex.de>                    *
 * All rights reserved.                                                    *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ScannerBuffer;
import java_cup.runtime.Symbol;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.concurrent.TimeUnit;


/**
 * Simple test driver for the java lexer. Just runs it on some
 * input files and produces debug output. Needs symbol class from
 * parser.
 */
public class TestLexer {
    String dir;


    private void displayFirstMenu() {
        System.out.println("\n[1] Scan pcl file...");
        System.out.println("[2] Exit");
        System.out.print("->");
    }

    private void displaySecondMenu() {
        System.out.println("Write pcl file url");
        System.out.print("->");
    }

    private void scan() {
        try {
            System.out.println("Lexing [" + dir + "]");
            TokenTable tokenTable = new TokenTable();
            ComplexSymbolFactory csf = new ComplexSymbolFactory();

            Scanner scanner = new Scanner(new BufferedReader(new FileReader(dir)),csf);
            ScannerBuffer lexer = new ScannerBuffer(scanner);
            Symbol s;
            do {
                s = lexer.next_token();
                if(s instanceof ComplexSymbolFactory.ComplexSymbol) {
                    ComplexSymbolFactory.ComplexSymbol var10 = (ComplexSymbolFactory.ComplexSymbol)s;
                    /*System.out.println("var10.TokenName = " + var10.getName());
                    System.out.println("var10.Row = " + var10.getLeft().getLine());
                    System.out.println("var10.Column = " + var10.getLeft().getColumn());
                    System.out.println("var10.value = " + var10.value);*/
                    if(var10.getName().equals("EOF") && var10.value == null){
                        var10.value = "EOF";
                    }
                    tokenTable.agregarFila((ComplexSymbolFactory.ComplexSymbol) var10);
                } else if(s instanceof Symbol) {
                    System.out.println("var9 = " + s.toString());
                }

            } while (s.sym != sym.EOF);
            tokenTable.imprimirTable();
            /*Iterator var8 = lexer.getBuffered().iterator();
            while(var8.hasNext()) {
                Symbol var9 = (Symbol)var8.next();
                if(var9 instanceof ComplexSymbolFactory.ComplexSymbol) {
                    ComplexSymbolFactory.ComplexSymbol var10 = (ComplexSymbolFactory.ComplexSymbol)var9;
                    System.out.println("var10 = " + scanner.getTokenNamePrime(var10.sym));
                    System.out.println("var10 = " + var10.getLeft().getLine());
                    System.out.println("var10 = " + var10.getLeft().getColumn());
                    System.out.println("var10 = " + var10.getLeft());
                } else if(var9 instanceof Symbol) {
                    System.out.println("var9 = " + var9.toString());
                }
            }*/
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    private void parser() {
        boolean withDebug = false; //TODO put as argument
        try {
            Object result;
            parser p = new parser(new Scanner(new FileReader(dir)));
            if(withDebug){
                result = p.debug_parse().value;
            }else {
                result = p.parse().value;
            }
            TimeUnit.MILLISECONDS.sleep(500);
            System.out.println(result);
            //p.debug_stack();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String readOption() {
        String re = "";
        try {
            BufferedReader r = new BufferedReader(new InputStreamReader(System.in));
            re = r.readLine();
        } catch (IOException e) {
            System.out.println("Invalid input.");
        }
        return re;
    }

    public static void main(String argv[]) throws InterruptedException {
        TestLexer main = new TestLexer();
        String opc;
        boolean control = true;
        boolean withArgv = argv.length != 0;
        boolean firstUse = true;

        while (control) {
            if (withArgv && firstUse) {
                opc = "1";
            } else {
                main.displayFirstMenu();
                opc = main.readOption();
            }
            switch (opc) {
                case "1": {
                    if (withArgv && firstUse) {
                        main.dir = argv[0];
                        firstUse = false;
                    } else {
                        main.displaySecondMenu();
                        main.dir = main.readOption();
                    }
                    main.scan();
                    TimeUnit.MILLISECONDS.sleep(500);
                    //main.parser();
                    TimeUnit.MILLISECONDS.sleep(500);
                    break;
                }
                case "2": {
                    control = false;
                    break;
                }
                default: {
                    System.out.println("Invalid choice. Try again!");
                    break;
                }
            }
        }
    }
}

