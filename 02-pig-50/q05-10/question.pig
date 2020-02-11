-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
-- aparece cada letra minúscula en la columna 2.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

u = LOAD 'data.tsv' USING PigStorage('\t') 
    AS (clave:CHARARRAY, 
        arreglo:CHARARRAY, 
        dicc:INT); 


x = FOREACH u GENERATE FLATTEN(TOKENIZE(arreglo));
grupo = GROUP x BY $0;
conteo = FOREACH grupo GENERATE FLATTEN(group), COUNT($1);
ajuste = LIMIT conteo 7;

DUMP ajuste;

STORE ajuste INTO 'output';
fs -get output/ .