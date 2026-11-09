CASO 1

SELECT 
    id_tipo_propiedad AS "TIPO",
    COUNT(*) AS "TOTAL_PROPIEDADES",
    TO_CHAR(MAX(valor_arriendo), '$999G999G990') AS "MAX_ARRIENDO",
    TO_CHAR(ROUND(AVG(valor_arriendo)), '$999G999G990') AS "PROMEDIO_ARRIENDO",
    TO_CHAR(MIN(valor_arriendo), '$999G999G990') AS "MIN_ARRIENDO",
    CASE 
        WHEN MAX(valor_arriendo) <= 1000000 THEN 'ESTÁNDAR'
        ELSE 'PREMIUM'
    END AS "CLASIFICACION",
    TO_CHAR(SUM(NVL(valor_gasto_comun, 0)), '$999G999G990') AS "TOTAL_GASTOS_COMUNES"
FROM 
    propiedad
GROUP BY 
    id_tipo_propiedad
HAVING 
    SUM(NVL(valor_gasto_comun, 0)) > &VALOR_TOTAL_GASTO_COMUN
ORDER BY 
    SUM(NVL(valor_gasto_comun, 0)) DESC;