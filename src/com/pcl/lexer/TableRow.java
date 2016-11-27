package com.pcl.lexer;

import java_cup.runtime.ComplexSymbolFactory;

import java.util.HashMap;

/**
 * Created by Jose Aguilar Quesada on 9/29/2016.
 */
public class TableRow {
    private ComplexSymbolFactory.ComplexSymbol token;
    private int tipo;

    private HashMap<Integer,Integer> lineas; //el primer integer es la línea y el segundo es la cantidad de apariciones por linea

    public TableRow(ComplexSymbolFactory.ComplexSymbol pToken, int pTipo, int pLinea){
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
        String result = "Valor: " + token.value +" tipo: "+ token.getName() + " Linea:";
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


    public ComplexSymbolFactory.ComplexSymbol getToken(){return token;};
    public Object getValor(){
        return token.value;
    }

    public  int getTipo(){
        return tipo;
    }
}
