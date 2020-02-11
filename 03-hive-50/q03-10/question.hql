-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Escriba una consulta que devuelva los cinco valores diferentes más pequeños 
-- de la tercera columna.
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data (col_values STRING) STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH 'data.tsv' OVERWRITE INTO TABLE temp_data;

DROP TABLE IF EXISTS data;

CREATE TABLE data (letra STRING, fecha DATE, valor INT);

INSERT OVERWRITE TABLE data
SELECT
    regexp_extract(col_values, '^(?:([^\t]*)\t?){1}', 1) letra,
    regexp_extract(col_values, '^(?:([^\t]*)\t?){2}', 1) fecha,
    regexp_extract(col_values, '^(?:([^\t]*)\t?){3}', 1) valor
FROM
    temp_data;


INSERT OVERWRITE LOCAL DIRECTORY '../q03-10/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT DISTINCT(valor)
FROM data
ORDER BY valor
LIMIT 5;