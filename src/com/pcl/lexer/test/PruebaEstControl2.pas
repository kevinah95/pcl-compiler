//Esta es una prueba para verificar las estructuras de control, READ y WRITE
// CASE, REPEAT


PROGRAM Prueba
BEGIN
//Pruebas del READ - WRITE


    READ();
    READ(X);
    READ(123);  //se espera error, pues no se acepta expresion entre ( )
    READ(x++); //se espera error

    WRITE(213+ 518- 345);
    WRITE(C);
    WRITE(C, 123, "Hola");
    WRITE( );     //se espera error]
    WRITE ;       //se espera error

END


