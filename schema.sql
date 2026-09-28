-- ══════════════════════════════════════════
-- MiniStore — Schema y datos de prueba
-- ══════════════════════════════════════════

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;

-- Tabla de catálogo de productos
CREATE TABLE productos (
    producto_id   INT PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    categoria     VARCHAR(50)  NOT NULL,
    precio        DECIMAL(10,2)
);

-- Tabla de transacciones de ventas
CREATE TABLE ventas (
    venta_id     INT PRIMARY KEY,
    producto_id  INT,
    cliente_id   INT,
    cantidad     INT          NOT NULL,
    fecha_venta  DATE         NOT NULL
);

-- Datos: productos del catálogo (incluye productos nunca vendidos)
INSERT INTO productos VALUES (101, 'Laptop Pro 15',      'Computación',    1200.00);
INSERT INTO productos VALUES (102, 'Mouse Inalámbrico',  'Accesorios',       28.00);
INSERT INTO productos VALUES (103, 'Monitor 4K 27"',     'Computación',     450.00);
INSERT INTO productos VALUES (104, 'Teclado Mecánico',   'Accesorios',       95.00);
INSERT INTO productos VALUES (105, 'Auriculares BT Pro', 'Audio',           120.00);
INSERT INTO productos VALUES (106, 'SSD Externo 1TB',    'Almacenamiento',  130.00);
INSERT INTO productos VALUES (107, 'Webcam HD 1080p',    'Accesorios',       85.00);

-- Estos dos productos NUNCA fueron vendidos
INSERT INTO productos

