-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Cuente la cantidad de personas nacidas por año.
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
date = FOREACH u GENERATE birthday, ToDate(birthday);
anos = FOREACH date GENERATE GetYear($1);
grup = GROUP anos BY $0;
conteo = FOREACH grup GENERATE FLATTEN(group), COUNT($1);

DUMP conteo;
STORE conteo INTO 'output' USING PigStorage(',');
fs -get output/ .
