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





CASO 2 

SELECT 
    UPPER(nombre_emp || ' ' || appaterno_emp) AS "Nombre Empleado",
    TO_CHAR(sueldo_emp, '$999G999G990') AS "Sueldo con Formato",
    CASE 
        WHEN sueldo_emp > 2000000 THEN 'ALTO'
        ELSE 'MEDIO'
    END AS "Clasificación Sueldo",
    (2025 - EXTRACT(YEAR FROM fecing_emp)) AS "Años Antigüedad",
    CASE 
        WHEN (2025 - EXTRACT(YEAR FROM fecing_emp)) BETWEEN 5 AND 10 
            THEN 'Corresponde bono  5%: ' || LPAD(TO_CHAR(ROUND(sueldo_emp * 0.05), '$999G999G990'), 12)
        WHEN (2025 - EXTRACT(YEAR FROM fecing_emp)) BETWEEN 11 AND 20 
            THEN 'Corresponde bono 10%: ' || LPAD(TO_CHAR(ROUND(sueldo_emp * 0.10), '$999G999G990'), 12)
        WHEN (2025 - EXTRACT(YEAR FROM fecing_emp)) > 20 
            THEN 'Corresponde bono 15%: ' || LPAD(TO_CHAR(ROUND(sueldo_emp * 0.15), '$999G999G990'), 12)
    END AS "BONO"
FROM 
    empleado
WHERE 
    id_categoria_emp = 3
    AND id_sucursal != &CODIGO_SUCURSAL
    AND (2025 - EXTRACT(YEAR FROM fecing_emp)) > 5
ORDER BY 
    sueldo_emp DESC;




CASO 3

SELECT 
    CASE 
        WHEN renta_cli >= 1000000 THEN 'PREMIUM'
        WHEN renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
        WHEN renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
        ELSE 'BAJA'
    END AS "CLASIFICACION_RENTA",
    COUNT(*) AS "CANTIDAD_CLIENTES",
    TO_CHAR(ROUND(AVG(renta_cli)), '$999G999G990') AS "RENTA_PROMEDIO",
    CASE 
        WHEN CASE 
                WHEN renta_cli >= 1000000 THEN 'PREMIUM'
                WHEN renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
                WHEN renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
                ELSE 'BAJA'
             END = 'ALTA' THEN 'Clientes Sin Teléfono'
        WHEN COUNT(celular_cli) = 0 THEN 'Clientes Sin Teléfono'
        ELSE 'Clientes con Teléfono'
    END AS "ESTADO_TELEFONO"
FROM 
    cliente
GROUP BY 
    CASE 
        WHEN renta_cli >= 1000000 THEN 'PREMIUM'
        WHEN renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
        WHEN renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
        ELSE 'BAJA'
    END
HAVING 
    AVG(renta_cli) > 200000
ORDER BY 
    CASE 
        WHEN CASE 
                WHEN renta_cli >= 1000000 THEN 'PREMIUM'
                WHEN renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
                WHEN renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
                ELSE 'BAJA'
             END = 'ALTA' THEN 1
        WHEN CASE 
                WHEN renta_cli >= 1000000 THEN 'PREMIUM'
                WHEN renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
                WHEN renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
                ELSE 'BAJA'
             END = 'MEDIA' THEN 2
        WHEN CASE 
                WHEN renta_cli >= 1000000 THEN 'PREMIUM'
                WHEN renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
                WHEN renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
                ELSE 'BAJA'
             END = 'BAJA' THEN 3
        WHEN CASE 
                WHEN renta_cli >= 1000000 THEN 'PREMIUM'
                WHEN renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
                WHEN renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
                ELSE 'BAJA'
             END = 'PREMIUM' THEN 4
    END ASC;
