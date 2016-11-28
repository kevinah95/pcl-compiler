package com.pcl.lexer;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.FileReader;


/**
 * Created by kevinah95 on 11/15/2016.
 */
public class parserTest {

    Parser sut;

    String dir = "./files/program_structure.pcl";
    @Before
    public void setUp() throws Exception {
        sut = new Parser(new Lexer(new FileReader(this.getClass().getResource("/com/pcl/lexer/files/program_structure.pcl").getFile())));
    }

    private Lexer changeScannerWithThisFile(String fileName) throws FileNotFoundException {
        return new Lexer(new FileReader(this.getClass().getResource("/com/pcl/lexer/files/"+fileName).getFile()));
    }

    @After
    public void tearDown() throws Exception {

    }

    @Test
    public void testProgramStructure() throws Exception {
        sut.setScanner(changeScannerWithThisFile("program_structure.pcl"));
        Object result = sut.parse().value;
        String actual = result.toString().replaceAll("\r","").replaceAll("\n","");
        String expected = "PROGRAM mojProgramBEGINEND";
        actual = actual.toString();
        Assert.assertEquals(expected,actual);
    }

    @Test
    public void testConstants() throws Exception {
        sut.setScanner(changeScannerWithThisFile("constants.pcl"));
        Object result = sut.parse().value;
        String actual = result.toString().replaceAll("\r","").replaceAll("\n","");
        String expected = "PROGRAM mojProgramCONSTPI=3.1415926;Nombre=Juan Gutiérrez;CARACTER=c;" +
                "BOOLEANOIDE=Funcion(123);REPETICIONES=3;BEGINEND";
        actual = actual.toString();
        Assert.assertEquals(expected,actual);
    }

    @Test
    public void testVariables() throws Exception {
        sut.setScanner(changeScannerWithThisFile("variables.pcl"));
        Object result = sut.parse().value;
        String actual = result.toString().replaceAll("\r","").replaceAll("\n","");
        String expected = "PROGRAM mojProgramVARi,j,k:INT;a:BOOLEAN;b:CHAR;f:ARRAY[0..8]OFINT;" +
                "p:INT;s:STRING;BEGINEND";
        actual = actual.toString();
        Assert.assertEquals(expected,actual);
    }

    @Test
    public void testFunctions() throws Exception {
        sut.setScanner(changeScannerWithThisFile("functions.pcl"));
        Object result = sut.parse().value;
        String actual = result.toString().replaceAll("\r","").replaceAll("\n","");
        String expected = "PROGRAM mojProgramFUNCTION fact(INT a,STRING s):INTBEGINWRITE(a)" +
                "fact:=4;Procedimiento(Funcion(123));ENDBEGINEND";
        actual = actual.toString();
        Assert.assertEquals(expected,actual);
    }

}