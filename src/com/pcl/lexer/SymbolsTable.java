package com.pcl.lexer;

import java.util.ArrayList;

/**
 * Created by Jose Aguilar Quesada on 11/28/2016.
 */
public class SymbolsTable {
    private ArrayList<SymbolsTableEntry> symTable = new ArrayList<SymbolsTableEntry>();

    public SymbolsTable(){
    }

    public boolean newEntry(String ptoken, String pvalue, String pscope){
        SymbolsTableEntry temp = new SymbolsTableEntry(ptoken, pvalue, pscope);
        if (symTable.isEmpty()){
            symTable.add(temp);
            return true;
        }
        else{
            for (SymbolsTableEntry entry : this.symTable){
                if (entry.getValue().equals(pvalue) && entry.getToken().equals(ptoken) && entry.getScope().equals(pscope)){
                    return false;
                }
            }
        symTable.add(temp);
        return true;
    }

    public SymbolsTableEntry findEntry(String ptoken, String pvalue, String pscope){
        for (SymbolsTableEntry entry : this.symTable){
            if (entry.getValue().equals(pvalue) && entry.getToken().equals(ptoken) && entry.getScope().equals(pscope)){
                return entry;
            }
        }
        return null;
    }

    public void printTable(){
        System.out.println("______________________________ SYMBOL TABLE ______________________________");
        System.out.println("Name - Type - Scope");
        for (SymbolsTableEntry entry : this.symTable){
            System.out.println(entry.getValue()+" - "+entry.getToken()+" - "+entry.getScope());
        }
    }
}
