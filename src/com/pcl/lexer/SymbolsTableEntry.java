package com.pcl.lexer;

/**
 * Created by Jose Aguilar Quesada on 11/28/2016.
 */
public class SymbolsTableEntry {
    private String token;
    private String value;
    private String scope;

    public SymbolsTableEntry(String ptoken, String pvalue, String pscope){
        this.setToken(ptoken);
        this.setValue(pvalue);
        this.setScope(pscope);
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

    public String getScope() {
        return scope;
    }

    public void setScope(String scope) {
        this.scope = scope;
    }
}
