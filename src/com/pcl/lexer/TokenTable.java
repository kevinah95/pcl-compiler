package com.pcl.lexer;

import com.inamik.text.tables.GridTable;
import com.inamik.text.tables.SimpleTable;
import com.inamik.text.tables.grid.Border;
import com.inamik.text.tables.grid.Util;
import java_cup.runtime.ComplexSymbolFactory;

import java.util.ArrayList;

/**
 * Created by Jose Aguilar Quesada on 9/29/2016.
 */
public class TokenTable {

    private ArrayList<TableRow> filas;


    public TokenTable() {
        filas = new ArrayList<>();
    }

    //Revisa entre todos los rows si el token ya existe, si existe agrega solo el numero de linea
    //De lo contrario agrega un nuevo Row a la tabla
    public void agregarFila(ComplexSymbolFactory.ComplexSymbol pToken) {
        //System.out.println("Entra en agregar");
        boolean encontrado = false;
        for (int i = 0; i < filas.size(); i++) {
            //Compara el valor de los token ignorando el case
            if (filas.get(i).getValor().toString().equalsIgnoreCase(pToken.value.toString()) && (filas.get(i).getTipo() == pToken.sym)) {
                filas.get(i).agregarLinea(pToken.getLeft().getLine());
                encontrado = true;
            }
        }
        if (encontrado == false) {
            TableRow t = new TableRow(pToken, pToken.sym, pToken.getLeft().getLine());
            filas.add(t);
        }
    }

    public void imprimirTable() {
        System.out.println("Entra en Print");
        SimpleTable t = SimpleTable.of().nextRow()
                .nextCell().addLine("--Token--")
                .nextCell().addLine("--Type--")
                .nextCell().addLine("--Line--");
        for (int i = 0; i < filas.size(); i++) {
            TableRow temp = filas.get(i);
            t.nextRow()
                    .nextCell().addLine(temp.getValor().toString())
                    .nextCell().addLine(temp.getToken().getName())
                    .nextCell().addLine(temp.getLineas());
        }
        // Convert to grid
        GridTable g = t.toGrid();
        // Add simple border
        g = Border.of(Border.Chars.of('+', '-', '|')).apply(g);
        // Print the table to System.out
        Util.print(g);
    }
}
