package com.pcl.lexer;

import java.util.HashMap;

/**
 * Created by Jose Aguilar Quesada on 9/29/2016.
 */
public class TableRow {
    private PclSymbol token;
    private int tipo;
    private HashMap<Integer,Integer> lineas; //el primer integer es la línea y el segundo es la cantidad de apariciones por linea

    public TableRow(PclSymbol pToken,int pTipo, int pLinea){
        token = pToken;
        tipo = pTipo;
        lineas = new HashMap<Integer,Integer>();
        lineas.put(pLinea,1);
    }

    public void agregarLinea(Integer pLinea){
        Integer consulta = lineas.get(pLinea);
        if (consulta != null){
            lineas.put(pLinea,lineas.get(pLinea)+1);
        }
        else{
            lineas.put(pLinea,1);
        }
    }

    public String toString(){
        String result = "Valor: " + token.getValue() +" tipo: "+ getTokenName(tipo)+ " Linea:";
        for(Integer key : lineas.keySet()){
            result += (" "+Integer.toString(key)+"("+Integer.toString(lineas.get(key))+")");
        }
        return result;
    }

    public String getLineas(){
        String result = "";
        for(Integer key : lineas.keySet()){
            result += (Integer.toString(key)+"("+Integer.toString(lineas.get(key))+")");
        }
        return result;
    }

    /**
     * Converts an int token code into the name of the
     * token by reflection on the cup symbol class/interface sym
     *
     * This code was contributed by Karl Meissner <meissnersd@yahoo.com>
     */
    public String getTokenName(int token) {
        try {
            java.lang.reflect.Field [] classFields = sym.class.getFields();
            for (int i = 0; i < classFields.length; i++) {
                if (classFields[i].getInt(null) == token) {
                    return classFields[i].getName();
                }
            }
        } catch (Exception e) {
            e.printStackTrace(System.err);
        }

        return "UNKNOWN TOKEN";
    }

    public String getValor(){
        return token.getValue();
    }

    public  int getTipo(){
        return tipo;
    }
}
