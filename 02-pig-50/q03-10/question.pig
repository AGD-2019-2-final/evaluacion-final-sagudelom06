-- Pregunta
-- ===========================================================================
-- 
-- Obtenga los cinco (5) valores más pequeños de la 3ra columna.
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
u = LOAD 'data.tsv' USING PigStorage('\t') 
    AS (clave:CHARARRAY, 
        Fecha:CHARARRAY, 
        numero:INT); 


orden = ORDER u BY numero ASC;
s = LIMIT orden 5;
chalalay = FOREACH s GENERATE numero;
DUMP chalalay;

STORE chalalay INTO 'output';
fs -get output/ .