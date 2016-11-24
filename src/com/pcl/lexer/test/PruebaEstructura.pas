///Se quiere probar la estructura del PROGRAMa
// Este codigo contiene varios  ejemplos de estructura que se deben probar.

(*
PROGRAM Prueba

PROCEDURE funcion1( INT x, INT y)
BEGIN
 funcion1:=0;
END
//i:= x++; //se espera error de sintaxis por expresion fuera de funcion


VAR  // las variables no pueden venir despues de una declaracion de funcion

 i:INT;

BEGIN
 write("Fin") // falta punto y coma
END
*)


(*
VAR  //falta la declaracion de progama
 i:INT;

BEGIN
 write("Fin");
END

*)




PROGRAM Prueba

VAR

 i:INT;


PROCEDURE funcion1( INT x , INT y)
BEGIN
 funcion1:=0;
END

BEGIN
 write("Fin");
// PROGRAMa sin END



(*

PROGRAM Prueba

VAR

 i:INT;


PROCEDURE funcion1( x:INT, y:INT)
BEGIN
 funcion1:=0;
END

//PROGRAMa sin BEGIN
 write("Fin");
END

*)

