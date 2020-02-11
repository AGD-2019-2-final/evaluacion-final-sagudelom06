-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
-- columna 3. En otras palabras, cuántos registros hay que tengan la clave 
-- `aaa`?
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

x = FOREACH u GENERATE dicc;
desagregado = FOREACH x GENERATE FLATTEN(dicc);
agrupado = GROUP desagregado BY $0;
conteo = FOREACH agrupado GENERATE FLATTEN(group), COUNT($1);


DUMP conteo;

STORE conteo INTO 'output' USING PigStorage(',');
fs -get output/ .
