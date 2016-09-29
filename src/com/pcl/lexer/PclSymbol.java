package com.pcl.lexer;
import java.util.HashMap;

public class PclSymbol extends java_cup.runtime.Symbol {
  private int line;
  private int column;
  //private HashMap<String,String,HashMap> tokenTable;

  public PclSymbol(int type, int line, int column) {
    this(type, line, column, -1, -1, null);
  }

  public PclSymbol(int type, int line, int column, Object value) {
    this(type, line, column, -1, -1, value);
  }

  public PclSymbol(int type, int line, int column, int left, int right, Object value) {
    super(type, left, right, value);
    this.line = line;
    this.column = column;
  }


  public int getLine() {
    return line;
  }

  public int getColumn() {
    return column;
  }

  public String toString() {   
    return "line "+line+", column "+column+", sym: "+sym+(value == null ? "" : (", value: '"+value+"'"));
  }
}
