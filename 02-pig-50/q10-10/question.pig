-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Genere una relación con el apellido y su longitud. Ordene por longitud y 
-- por apellido. Obtenga la siguiente salida.
-- 
--   Hamilton,8
--   Garrett,7
--   Holcomb,7
--   Coffey,6
--   Conway,6
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
--
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (clave:INT,
    	nombre:CHARARRAY,
    	apell:CHARARRAY,
    	birth:CHARARRAY,
    	color:CHARARRAY,
    	numero:INT);

apellidos = FOREACH u GENERATE apell;
grupo = GROUP apellidos BY $0;
largo = FOREACH grupo GENERATE $0, SIZE(group);
orden = ORDER largo BY $1 DESC, $0;
s = LIMIT orden 5;

DUMP s;

STORE s INTO 'output' USING PigStorage(',');
fs -get output/ .