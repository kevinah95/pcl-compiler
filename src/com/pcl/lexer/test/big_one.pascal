PROGRAM mojProgram
CONST
    PI = 3.1415926;
    Nombre = "Juan Gutiérrez";
    CARACTER = "c";
    BOOLEANOIDE = Funcion(123);
    REPETICIONES = -f[3];
    REPETICIONES = -3;
    REPETICIONES = -f(3);
    //REPETICIONES = PI; //TODO MINUS and EQ IDENTIFIER
    REPETICIONES = -3.14;
VAR
        i,j,k : INT;
		a : BOOLEAN;
		b : CHAR;
		f : ARRAY[-FunOp()..-b] OF INT;
		f : ARRAY[8] OF INT;
		p : INT;
		s : STRING;
(*FUNCTIONS*)
FUNCTION fact(INT a, STRING s): INT
BEGIN
    WRITE("a");
    fact := 4;
    Procedimiento(Funcion(123));

END
FUNCTION Func2(INT a, STRING s): INT
BEGIN
    WRITE("a");
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
    WRITE("a");
    }
    WRITE("b");
    j := -4; //TODO UMINUS -4
    k := 3;
    REPEAT
        f[5] := fact(k);
        WRITE(-fact(k));
        WRITE(-2);
        READ(-45);
        k := -1;
    UNTIL k = -4;

    b:="a";
    a:=FALSE;

    FOR i := -12 TO -10 DO
        BEGIN
        IF (i < -6) THEN
                WRITE(a);
                a := NOT a;
                b := NOT TRUE;
                IF (a=(-b-3)) OR (n=x) THEN k:=95; j:=3; ELSE k:=2; //La condción no puede ir entre parentesis
                WHILE (j < 9) DO //TODO NEGATVE NUMBERS
                    BEGIN
                        WRITE(j);
                        CASE k OF
                            95: j := j-1;; //
                            9: k := n;;
                        ELSE
                            j:=j+1;
                    END
        ELSE IF i > 9 THEN
            WRITE(b);
        ELSE
            WRITE(i);
        END
    WRITE("k");
    B(i-1);
    A();
    n:=(a-b+(3-2));
    FOR i:=0 TO 9 DO
    BEGIN
    WRITE(f[i]*1000*1000+i);
    END
END
