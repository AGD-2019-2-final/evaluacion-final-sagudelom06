-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
-- salida esperada es la siguiente:
-- 
--   (Hamilton)
--   (Holcomb)
--   (Garrett)
--   (Fry)
--   (Kinney)
--   (Klein)
--   (Diaz)
--   (Guy)
--   (Estes)
--   (Jarvis)
--   (Knight)
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

data = FOREACH u GENERATE (apell);
filter_data = FILTER data BY ($0 matches '.*D.*') OR ($0 matches '.*E.*') OR ($0 matches '.*F.*') OR ($0 matches '.*G.*') OR ($0 matches '.*H.*') OR ($0 matches '.*I.*') OR ($0 matches '.*J.*') OR ($0 matches '.*K.*');

DUMP filter_data;
STORE filter_data INTO 'output';
fs -get output/ .