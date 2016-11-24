//Esta es una prueba para verificar las estructuras de control
//IF-ELSE, WHILE, FOR

PROGRAM Prueba

VAR

 i:INT;

BEGIN

// Pruebas del IF

  IF (a=2) THEN //deberia dar error, pues debe haber una expresion
   i:=0;
  ELSE
    i:=0;

  IF (a<>TRUE) THEN //deberia dar error, pues no cierra la expresion
     i:=0;
  ELSE
    i:=0;

  IF (x=2) THEN //error sin THEN
     i:= x++;
  ELSE
      i:= x--;

  IF (a=2) THEN //deberia dar error por doble IF
  	i:=0;
   ELSE
     i:=0;

   IF (x=2) THEN
       i:= x++;
   ELSE
      i:= x--;

   IF (x>4)  THEN //deberia aceptar IF anidados y cualquier tipo de expresion dentro de ( )
   BEGIN
        IF (a>=2) THEN
          i:= x++;
        ELSE
           i:=x--;
   END
   ELSE
   BEGIN
      i:= x;
   END


   // PRUEBAS DEL FOR

       FOR i>9 TO 8 DO // la primer expresion no es asignacion
       BEGIN
         i:=0;
       END

       FOR x:= 7 TO (f>9) DO // segunda expresion no puede ser una condicion
       BEGIN
	      i:=0;
       END

       FOR X:= 1 TO 10 //falta el DO
       BEGIN
	   	  i:=0;
       END

       FOR X:= 1  10 DO//falta el TO
	   BEGIN
	   	   	  i:=0;
       END


       FOR X:= 1 TO 10 DO
	   BEGIN
	   	WHILE (a>8) DO
		BEGIN
		   i:=0;
        END
       END


       FOR X:= 1 TO 10 DO
	   BEGIN
	      i:=0;
	   // no cerro el FOR


   //PRUEBAS DEL WHILE

        WHILE DO  //debe dar error no tiene expresion
        BEGIN
           i:=0;
        END

        WHILE () DO  //debe dar error no tiene expresion
		BEGIN
		   i:=0;
        END

        WHILE (a>8) DO
		BEGIN
		   i:=0;
        END


        WHILE (a>8)   //falta el DO
		BEGIN
			i:=0;
        END


        WHILE (a>8) DO
		  i:=0;//falta el BEGIN
        END


        WHILE (a>8) DO
		BEGIN
			IF (b= false) THEN
   				i:=0;
  			ELSE
    			i:=0;
        END

END




