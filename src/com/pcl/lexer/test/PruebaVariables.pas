//Esta es una prueba para las declaraciones de variables globales y locales y constantes


PROGRAM Prueba

CONST

	 Min        = 0;
     Max        = 1000;
     Incremento = 5;
     N          = 8;  // Deberia dar un error
     Saludo     = "Hola";
     Suma       = (3 * 2) + (5 * 4);   //deberia dar error. Aqui no van operaciones

VAR

 numero,limite,contador:INT;  // todo esta bien

 algo:INT; //hizo falta el identificador

 respuesta : STRING ; // todo esta bien

 coleccion: ARRAY[50] OF INT;

 coleccion2: ARRAY[5] OF LONGINT; // error porque falta el OF

 coleccion2: ARRAY[i] OF SHORTINT; // error porque falta el ]


 varsintipo:INT ; //error porque no se le declara el tipo



PROCEDURE funcion1() //esta esta bien
BEGIN
   funcion1:= 0;
END


PROCEDURE funcion1() //esta esta bien
BEGIN
   funcion1:= 0;
END

PROCEDURE funcion1() //esta esta bien
BEGIN
   funcion1:= 0;
END

PROCEDURE funcion1() //tiene errores
BEGIN
VAR
   variable:STRING; // no le define tipo
   i: INT;

CONST
	A := 123; // error: es solo el =

   funcion1:= 0;
END

variable: INT;  //error pues no se permiten variables globales despues de la primer declaracion de funcion


BEGIN
VAR //error pues no se permiten variables globales dentro del bloque
 variable: INT;
 write("Fin");
END



