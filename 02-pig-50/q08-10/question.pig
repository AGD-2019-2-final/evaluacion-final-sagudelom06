-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
-- columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
-- registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
-- columna 3 es:
-- 
--   ((b,jjj), 216)
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

data = FOREACH u GENERATE FLATTEN(arreglo), FLATTEN(dicc);
tupla = FOREACH data GENERATE TOTUPLE($0, $1);
agrupado = GROUP tupla BY $0;
conteo = FOREACH agrupado GENERATE $0, COUNT($1);

DUMP conteo;


STORE conteo INTO 'output';
fs -get output/ .