package com.pcl.lexer;

import java.util.List;

/**
 * Created by Jose Aguilar Quesada on 9/29/2016.
 */
public class TokenTable {
    private TableRow[] filas;

    public TokenTable(){
        filas = new TableRow[]{};
    }

    //Revisa entre todos los rows si el token ya existe, si existe agrega solo el numero de linea
    //De lo contrario agrega un nuevo Row a la tabla
    public void agregarFila(PclSymbol pToken, String pTipo, Integer pLinea){
        boolean encontrado = false;
        for (int i = 0 ; i<filas.length ; i++){
            //Compara el valor de los token ignorando el case
            if (filas[i].getValor().equalsIgnoreCase(pToken.getValue()) && filas[i].getTipo().equals(pTipo)){
                filas[i].agregarLinea(pLinea);
                encontrado = true;
            }
        }
        if (encontrado == false){
            filas[filas.length] = new TableRow(pToken,pTipo,pLinea);
        }
    }
}
