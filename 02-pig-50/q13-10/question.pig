--
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código equivalente a la siguiente consulta en SQL.
-- 
--    SELECT
--        color
--    FROM 
--        u 
--    WHERE 
--        color 
--    LIKE 'b%';
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<

u = LOAD 'data.csv' USING PigStorage(',') 
    AS (clave:INT,
    	nombre:CHARARRAY,
    	apell:CHARARRAY,
    	birth:CHARARRAY,
    	color:CHARARRAY,
    	numero:INT);

data = FOREACH u GENERATE (color);
filter_data = FILTER data BY ($0 matches '.*b.*');
DUMP filter_data;
STORE filter_data INTO 'output';
fs -get output/ .

