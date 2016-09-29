package com.pcl.lexer;

import java.util.HashMap;

/**
 * Created by Jose Aguilar Quesada on 9/29/2016.
 */
public class TableRow {
    private PclSymbol token;
    private String tipo;
    private HashMap<Integer,Integer> lineas; //el primer integer es la línea y el segundo es la cantidad de apariciones por linea

    public TableRow(PclSymbol pToken,String pTipo, Integer pLinea){
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
        String result = "Valor: " + token.getValue() +" tipo: "+ tipo+ "Linea:";
        for(Integer key : lineas.keySet()){
            result += (" "+Integer.toString(key)+"("+Integer.toString(lineas.get(key))+")");
        }
        return result;
    }

    public String getValor(){
        return token.getValue();
    }

    public  String getTipo(){
        return tipo;
    }
}
