package com.pcl.lexer;

/**
 * Created by Jose Aguilar Quesada on 11/29/2016.
 */
public class StackElement {
    private String token;
    private String value;
    private String tReturn;
    private String role;
    private int row;
    private int col;

    public StackElement(String ptoken, String pvalue, String ptReturn, String prole, int prow, int pcol){
        this.token = ptoken;
        this.value = pvalue;
        this.tReturn = ptReturn;
        this.role = prole;
        this.row = prow;
        this.col = pcol;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getT_return() {
        return tReturn;
    }

    public void setT_return(String t_return) {
        this.tReturn = t_return;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getRow() {
        return row;
    }

    public void setRow(int row) {
        this.row = row;
    }

    public int getCol() {
        return col;
    }

    public void setCol(int col) {
        this.col = col;
    }
}
