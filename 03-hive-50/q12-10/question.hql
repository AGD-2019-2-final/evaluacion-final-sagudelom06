-- 
-- Pregunta
-- ===========================================================================
--
-- Escriba una consulta que compute la cantidad de registros por letra de la 
-- columna 2 y clave de la columna 3; esto es, por ejemplo, la cantidad de 
-- registros en tienen la letra `a` en la columna 2 y la clave `aaa` en la 
-- columna 3 es:
--
--     a    aaa    5
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
DROP TABLE IF EXISTS t0;
CREATE TABLE t0 (
    c1 STRING,
    c2 ARRAY<CHAR(1)>, 
    c3 MAP<STRING, INT>
    )
    ROW FORMAT DELIMITED 
        FIELDS TERMINATED BY '\t'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY '#'
        LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE t0;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
WITH cte_map as (
	SELECT c2, k as value
	FROM t0
	LATERAL VIEW explode(c3) e1 as k,v
), cte_arr as (
	SELECT ch, value
	FROM cte_map
	LATERAL VIEW explode(c2) e2 as ch
) 
INSERT OVERWRITE LOCAL DIRECTORY '../q12-10/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT ch, value, count(*)
FROM cte_arr
GROUP BY ch, value;

