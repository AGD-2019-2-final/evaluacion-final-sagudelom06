-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
-- la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
-- columna 3 separados por coma. La tabla debe estar ordenada por las 
-- columnas 1, 2 y 3.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
u = LOAD 'data.tsv' USING PigStorage('\t') 
    AS (clave:CHARARRAY, 
        arreglo:BAG{t2:TUPLE(c2:CHARARRAY)},
        dicc:MAP[]);

data = FOREACH u GENERATE clave, COUNT(arreglo), SIZE(dicc);
orden = ORDER data BY $0, $1, $2;
DUMP orden;

STORE orden INTO 'output' USING PigStorage(',');
fs -get output/ .