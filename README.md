Contexto
Este repositorio contiene la práctica evaluable del Módulo 5 sobre LEFT JOIN, RIGHT JOIN y FULL OUTER JOIN, utilizando el dataset de MiniStore.
El objetivo es detectar productos sin ventas, ventas huérfanas y construir una vista completa de auditoría, algo fundamental en análisis de calidad de datos.

El repositorio incluye:

Código
outer-joins-ministore/
├── schema.sql
├── soluciones.sql
└── README.md
🧪 Explicación de las decisiones técnicas
1️⃣ ¿Por qué usé LEFT JOIN en la Consulta 1 y no INNER JOIN?
La pregunta de negocio es:

“¿Qué productos del catálogo nunca fueron vendidos?”

Para responder eso, necesito ver todos los productos, incluso aquellos sin coincidencias en la tabla ventas.

En un LEFT JOIN, la tabla de la izquierda (productos) siempre devuelve todas sus filas, aunque no haya ventas asociadas.

En un INNER JOIN, solo vería los productos que sí tienen ventas, y perdería exactamente los casos que quiero detectar.

Ejemplo concreto del dataset
Los productos 108 y 109 existen en el catálogo pero no tienen ventas.
Con LEFT JOIN aparecen con:

Código
venta_id = NULL
Con INNER JOIN desaparecen, por eso INNER JOIN no sirve para esta pregunta.

2️⃣ ¿Por qué usé RIGHT JOIN en la Consulta 2?
La pregunta de negocio es:

“¿Existen ventas registradas con productos que no figuran en nuestro catálogo?”

Para detectar ventas huérfanas, necesito ver todas las ventas, incluso las que no tienen producto asociado.

En un RIGHT JOIN, la tabla de la derecha (ventas) siempre devuelve todas sus filas, incluyendo las que no coinciden con productos.

¿Qué tabla está a la izquierda y cuál a la derecha?
Consulta 2:

sql
FROM productos p
RIGHT JOIN ventas v ON p.producto_id = v.producto_id
Izquierda → productos

Derecha → ventas (la que quiero preservar completa)

Ejemplo concreto del dataset
La venta:

Código
venta_id = 10, producto_id = 999
Ese producto no existe en el catálogo.
Con RIGHT JOIN aparece con:

Código
p.producto_id = NULL
Eso indica un error de carga de datos.

3️⃣ ¿Qué representan los valores NULL en cada resultado?
Los NULL son la señal exacta que buscamos en auditoría de datos.

Caso 1 — LEFT JOIN (Consulta 1)
Si aparece:

Código
ventas.venta_id = NULL
Significa:

“Este producto existe en el catálogo, pero nunca fue vendido.”

Ejemplo real: productos 108 y 109.

Caso 2 — RIGHT JOIN (Consulta 2)
Si aparece:

Código
productos.producto_id = NULL
Significa:

“Esta venta tiene un producto que no existe en el catálogo.”

Ejemplo real: venta 10 con producto_id 999.

Caso 3 — FULL OUTER JOIN (Consulta 3)
Los NULL pueden aparecer en cualquiera de las dos tablas:

NULL en columnas de ventas → producto sin ventas

NULL en columnas de productos → venta huérfana

Es la vista completa de auditoría.

4️⃣ ¿Cuándo usaría FULL OUTER JOIN en un caso real de negocio?
El FULL OUTER JOIN es ideal cuando:

Necesitás una vista completa de dos tablas

No querés perder ninguna fila

Querés detectar ambos tipos de problemas:

registros faltantes en una tabla

registros huérfanos en la otra

Ejemplos reales:
Auditoría de catálogo vs ventas (como en este ejercicio)

Cruce de clientes vs transacciones

Cruce de inventario vs movimientos de stock

Cruce de empleados vs registros de horas trabajadas

Cruce de proveedores vs órdenes de compra

En todos estos casos, el FULL OUTER JOIN te permite ver todo, incluyendo los errores.
