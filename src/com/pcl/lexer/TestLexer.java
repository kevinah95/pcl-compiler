package com.pcl.lexer;
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 2004-2015  Gerwin Klein <lsf@jflex.de>                    *
 * All rights reserved.                                                    *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

import java_cup.runtime.*;

import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamWriter;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;
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

            Lexer scanner = new Lexer(new BufferedReader(new FileReader(dir)),csf);
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
        try {
            /*// initialize the symbol factory
            ComplexSymbolFactory csf = new ComplexSymbolFactory();
            // create a buffering scanner wrapper
            ScannerBuffer lexer = new ScannerBuffer(new Lexer(new BufferedReader(new FileReader(dir)),csf));
            // start parsing
            Parser p = new Parser(lexer,csf);
            System.out.println("Parser runs: ");
            XMLElement e = (XMLElement)p.parse().value;
            // create XML output file
            XMLOutputFactory outFactory = XMLOutputFactory.newInstance();
            XMLStreamWriter sw = outFactory.createXMLStreamWriter(new FileOutputStream("simple.xml"), "UTF-8");
            // dump XML output to the file
            XMLElement.dump(lexer,sw,e); //,"expr","stmt");
            // transform the parse tree into an AST and a rendered HTML version
            Transformer transformer = TransformerFactory.newInstance()
                    .newTransformer(new StreamSource(new File("tree.xsl")));
            Source text = new StreamSource(new File("simple.xml"));
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");

            transformer.transform(text, new StreamResult(new File("output.html")));
            System.out.println("Parsing finished!");*/
            // initialize the symbol factory
            ComplexSymbolFactory csf = new ComplexSymbolFactory();
            // create a buffering scanner wrapper
            ScannerBuffer lexer = new ScannerBuffer(new Lexer(new BufferedReader(new FileReader(dir)),csf));
            // start parsing
            Parser p = new Parser(lexer,csf);
            XMLElement e = (XMLElement)p.parse().value;

            for (XMLElement el: SyntaxTreeXPath.query("/",e)){
                System.out.println(el.getTagname());
            }


            TestVisitor t = new TestVisitor();
            SyntaxTreeDFS.dfs(e,t);

            // create XML output file
            XMLOutputFactory outFactory = XMLOutputFactory.newInstance();
            XMLStreamWriter sw = outFactory.createXMLStreamWriter(new FileOutputStream("simple.xml"), "UTF-8");
            // dump XML output to the file
            XMLElement.dump(lexer,sw,e,"expr","stmt");

            // transform the parse tree into an AST and a rendered HTML version
            Transformer transformer = TransformerFactory.newInstance()
                    .newTransformer(new StreamSource(new File("tree.xsl")));
            Source text = new StreamSource(new File("simple.xml"));
            transformer.setOutputProperty(OutputKeys.VERSION, "1.0");
            //transformer.setOutputProperty(OutputKeys.ENCODING,"UTF-8");
            transformer.transform(text, new StreamResult(new File("output.xml")));
            transformer = TransformerFactory.newInstance()
                    .newTransformer(new StreamSource(new File("tree-view.xsl")));
            text = new StreamSource(new File("output.xml"));
            transformer.transform(text, new StreamResult(new File("ast.html")));
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
                    //main.scan();
                    TimeUnit.MILLISECONDS.sleep(500);
                    main.parser();
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

