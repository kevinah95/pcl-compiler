PROGRAM mojProgram
CONST
    PI = 3.1415926;
    Nombre = "Juan Gutiérrez";
    CARACTER = "c";
    BOOLEANOIDE = Funcion(123);
    REPETICIONES = 3;
VAR
        i,j,k : INT;
		a : BOOLEAN;
		b : CHAR;
		f : ARRAY[0..8] OF INT;
		p : INT;
		s : STRING;
(*FUNCTIONS*)
FUNCTION fact(INT a, STRING s): INT
BEGIN
    WRITE("a")
    fact := 4;
    Procedimiento(Funcion(123));

END
(*PROCEDURES*)
PROCEDURE hello2(INT a)
   (*
   PROCEDURE a(BOOLEAN b)
   BEGIN
   END { a }*)
BEGIN
END { hello2 }
BEGIN
    i := 12;
    {ble{ ble} bleeee
    WRITE('a');
    }
    WRITE('b')
    j := 4; //TODO UMINUS -4
    k := 3; //TODO identificador a otro identificador
    REPEAT
        //f[5] := fact(k); //TODO array[id]
        WRITE(fact(k))
        k := 1;
    UNTIL k = 0

    b:='a';
    a:=FALSE;

    FOR i := 0 TO 10 DO
        BEGIN
        IF i < 6 THEN
                WRITE(a)
                a := NOT a;
                IF a THEN BEGIN k:=95; j:=3; END ELSE k:=2;
                WHILE (j > -9) AND (j < -1) DO
                    BEGIN
                        WRITE(j);
                        CASE k OF
                            95: j := j-1;
                            -2: j:=j+1;
                        ELSE
                            j:=j+1;
                    END
        ELSE IF i > 9 THEN
            WRITE(b)
        ELSE
            WRITE(i);
        END
    WRITE('k');
    FOR i:=0TO 9DO
    WRITE(f[i]*1000*1000+i);
END
