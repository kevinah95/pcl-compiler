package com.pcl.lexer;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * Created by Jose Aguilar Quesada on 9/29/2016.
 */
public class TokenTable {

    private ArrayList<TableRow> filas;


    public TokenTable(){
        filas = new ArrayList<>();
    }

    //Revisa entre todos los rows si el token ya existe, si existe agrega solo el numero de linea
    //De lo contrario agrega un nuevo Row a la tabla
    public void agregarFila(PclSymbol pToken){
        boolean encontrado = false;
        for (int i = 0 ; i<filas.size() ; i++){
            //Compara el valor de los token ignorando el case
            if (filas.get(i).getValor().equalsIgnoreCase(pToken.getValue()) && (filas.get(i).getTipo()== pToken.sym)){
                filas.get(i).agregarLinea(pToken.getLine());
                encontrado = true;
            }
        }
        if (encontrado == false){
            TableRow t = new TableRow(pToken,pToken.sym,pToken.getLine());
            filas.add(t);
        }
    }

    public void imprimirTable(){
        AsciiTable4j t = new AsciiTable4j();
        t.addRow(Arrays.asList("Token", "Type", "Line"));
        for (int i = 0; i < filas.size(); i++) {
            TableRow temp = filas.get(i);
            t.addRow(Arrays.asList(temp.getValor(), temp.getTokenName(temp.getTipo()), temp.getLineas()));
            //System.out.println(filas.get(i).toString());
        }
        t.showTable();
    }
}
