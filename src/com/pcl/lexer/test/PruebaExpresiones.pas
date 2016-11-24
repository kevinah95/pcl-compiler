//Esta es una prueba para probar las expresiones que son aceptadas por el parser
//Se considera esta una parte muy importante, puesto que las expresiones son muy usadas
//en el resto de la gramatica.  Donde sea que aparece una expresion en la gramatica, las pruebas
//aqui efectuadas tienen validez


PROGRAM Prueba

VAR

 i:INT;

BEGIN

i:= ++x;
i:= ++x; //error
i:= y[1]++;
i:= funcion1(4);
x:=2; x:=4; //error no mas de una asignacion en cada linea. segun acuerdo en la clase

//i:= funcion1((x=3));

i:= funcion1(3);
i:= (2 DIV 3 * 345 + 8/9 + 5- 6 MOD 3);
//i:= 3 * 5 AND TRUE OR i; // no deberia dar error porque los tipos los prueba hasta el analisis semantico

//ca�a := 8; // error lexico

WHILE (a > 3) DO
BEGIN
  i:= 3;
END

(*WHILE (1*4) DO  // en una condicion no pueden venir operaciones aritmeticas
BEGIN
  i:= 3;
END*)

END


