-- Pregunta
-- ===========================================================================
-- 
-- Ordene el archivo `data.tsv`  por letra y valor (3ra columna).
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
-- 
--  >>> Escriba el codigo del mapper a partir de este punto <<<

fs -rm -f -r data.tsv
fs -put data.tsv


u = LOAD 'data.tsv' USING PigStorage('\t') 
    AS (clave:CHARARRAY, 
        Fecha:CHARARRAY, 
        numero:INT); 


orden = ORDER u BY clave,numero ASC;
DUMP orden;
STORE orden INTO 'output';
fs -get output/ .


