USE GD2C2024;
GO

-- FIXME eliminar 
IF EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'GROUP_BY_PROMOCION')
BEGIN
    DROP TABLE GROUP_BY_PROMOCION.Envios;
    DROP TABLE GROUP_BY_PROMOCION.TiposEnvio;

    DROP TABLE GROUP_BY_PROMOCION.DetallesPago;
    DROP TABLE GROUP_BY_PROMOCION.Pagos;
    DROP TABLE GROUP_BY_PROMOCION.MediosDePago;
    DROP TABLE GROUP_BY_PROMOCION.TiposMedioDePago;

    DROP TABLE GROUP_BY_PROMOCION.DetallesVenta;
    DROP TABLE GROUP_BY_PROMOCION.Ventas;

    DROP TABLE GROUP_BY_PROMOCION.DetallesFactura;
    DROP TABLE GROUP_BY_PROMOCION.TiposDetalleFactura;
    DROP TABLE GROUP_BY_PROMOCION.Facturas;

    DROP TABLE GROUP_BY_PROMOCION.Publicaciones;

    DROP TABLE GROUP_BY_PROMOCION.Domicilios;

    DROP TABLE GROUP_BY_PROMOCION.Clientes;
    DROP TABLE GROUP_BY_PROMOCION.Vendedores;

    DROP TABLE GROUP_BY_PROMOCION.Almacenes;

    DROP TABLE GROUP_BY_PROMOCION.Localidades;
    DROP TABLE GROUP_BY_PROMOCION.Provincias;

    DROP TABLE GROUP_BY_PROMOCION.Productos;
    DROP TABLE GROUP_BY_PROMOCION.SubRubros;
    DROP TABLE GROUP_BY_PROMOCION.Rubros;
    DROP TABLE GROUP_BY_PROMOCION.Marcas;
    DROP TABLE GROUP_BY_PROMOCION.Modelos;

    DROP TABLE GROUP_BY_PROMOCION.Usuarios;

    DROP SCHEMA GROUP_BY_PROMOCION;
END
GO

-- Crear Esquema
CREATE SCHEMA GROUP_BY_PROMOCION;
GO

/*
** Crear Tablas
*/

CREATE TABLE GROUP_BY_PROMOCION.TiposDetalleFactura (
    tdfa_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    tdfa_descripcion NVARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE GROUP_BY_PROMOCION.DetallesFactura (
    dfac_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    dfac_publicacion DECIMAL(18), -- FK
    dfac_factura DECIMAL(18), -- FK
    dfac_tipo DECIMAL(18), -- FK
    dfac_cantidad DECIMAL(18) NOT NULL,
    dfac_subtotal DECIMAL(18, 2) NOT NULL,
    dfac_precio DECIMAL(18, 2) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Facturas (
    fact_numero DECIMAL(18) PRIMARY KEY,
    fact_vendedor DECIMAL(18), -- FK
    fact_total DECIMAL(18, 2) NOT NULL,
    fact_fecha DATE NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.Marcas (
    marc_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    marc_descripcion NVARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE GROUP_BY_PROMOCION.Modelos (
    mode_codigo DECIMAL(18) PRIMARY KEY,
    mode_descripcion NVARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE GROUP_BY_PROMOCION.Productos (
    prod_id DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    prod_sub_rubro DECIMAL(18), -- FK
    prod_marca DECIMAL(18), -- FK
    prod_modelo DECIMAL(18), -- FK
    prod_codigo NVARCHAR(50),
    prod_descripcion NVARCHAR(50) NOT NULL,
    prod_precio DECIMAL(18,2) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Rubros (
    rubr_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    rubr_descripcion NVARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE GROUP_BY_PROMOCION.SubRubros (
    subr_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    subr_rubro DECIMAL(18), -- FK
    subr_descripcion NVARCHAR(50) NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.Publicaciones (
    publ_codigo DECIMAL(18) PRIMARY KEY,
    publ_vendedor DECIMAL(18), -- FK
    publ_almacen DECIMAL(18), -- FK
    publ_producto DECIMAL(18), -- FK
    publ_descripcion NVARCHAR(50) NOT NULL,
    publ_fecha_inicio DATE NOT NULL,
    publ_fecha_cierre DATE NOT NULL,
    publ_stock DECIMAL(18) NOT NULL,
    publ_precio DECIMAL(18, 2) NOT NULL,
    publ_costo DECIMAL(18, 2) NOT NULL,
    publ_porc_venta DECIMAL(18, 2) NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.Localidades (
    loca_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    loca_provincia DECIMAL(18), -- FK
    loca_descripcion NVARCHAR(50) NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.Provincias (
    prov_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    prov_descripcion NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE GROUP_BY_PROMOCION.Almacenes (
    alma_codigo DECIMAL(18) PRIMARY KEY,
    alma_localidad DECIMAL(18), -- FK
    alma_calle NVARCHAR(50) NOT NULL,
    alma_nro_calle DECIMAL(18) NOT NULL,
    alma_costo_dia DECIMAL(18, 2) NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.DetallesVenta (
    dven_venta DECIMAL(18), -- FK
    dven_publicacion DECIMAL(18), -- FK
    dven_precio DECIMAL(18, 2) NOT NULL,
    dven_cantidad DECIMAL(18) NOT NULL,
    dven_subtotal DECIMAL(18, 2) NOT NULL

    PRIMARY KEY (dven_venta, dven_publicacion)
);
CREATE TABLE GROUP_BY_PROMOCION.Ventas (
    vent_codigo DECIMAL(18) PRIMARY KEY,
    vent_cliente DECIMAL(18), -- FK
    vent_fecha DATETIME NOT NULL,
    vent_total DECIMAL(18,2) NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.DetallesPago (
    dpag_pago DECIMAL(18) PRIMARY KEY, -- FK
    dpag_nro_tarjeta NVARCHAR(50) NOT NULL,
    dpag_fecha_venc_tarjeta DATE NOT NULL,
    dpag_cant_cuotas DECIMAL(18) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Pagos (
    pago_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    pago_medio_de_pago DECIMAL(18), -- FK
    pago_venta DECIMAL(18) UNIQUE, -- FK
    pago_importe DECIMAL(18, 2) NOT NULL,
    pago_fecha DATE NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.TiposMedioDePago (
    tmdp_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    tmdp_descripcion NVARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE GROUP_BY_PROMOCION.MediosDePago (
    mpag_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    mpag_tipo DECIMAL(18), -- FK
    mpag_descripcion NVARCHAR(50) NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.Vendedores (
    vend_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    vend_usuario DECIMAL(18), -- FK
    vend_razon_social NVARCHAR(50) NOT NULL,
    vend_mail NVARCHAR(50) NOT NULL,
    vend_cuit NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Clientes (
    clie_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    clie_usuario DECIMAL(18), -- FK
    clie_nombre NVARCHAR(50) NOT NULL,
    clie_apellido NVARCHAR(50) NOT NULL,
    clie_fecha_nac DATE NOT NULL,
    clie_mail NVARCHAR(50) NOT NULL,
    clie_dni DECIMAL(18) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Usuarios (
    usua_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    usua_nombre NVARCHAR(50) NOT NULL,
    usua_contrasenia NVARCHAR(50) NOT NULL,
    usua_fecha_crea DATE NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.Domicilios (
    domi_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    domi_usuario DECIMAL(18), -- FK
    domi_localidad DECIMAL(18), -- FK
    domi_calle NVARCHAR(50) NOT NULL,
    domi_nro_calle DECIMAL(18) NOT NULL,
    domi_piso DECIMAL(18),
    domi_depto NVARCHAR(50),
    domi_cp NVARCHAR(50) NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.TiposEnvio (
    tden_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    tden_descripcion NVARCHAR(50) NOT NULL UNIQUE
)
CREATE TABLE GROUP_BY_PROMOCION.Envios (
    envi_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    envi_venta DECIMAL(18) UNIQUE, -- FK
    envi_tipo DECIMAL(18), -- FK
    envi_domicilio DECIMAL(18), -- FK
    envi_fecha_programada DATE,
    envi_hora_inicio DECIMAL(18),
    envi_hora_fin DECIMAL(18),
    envi_fecha_entrega DATETIME,
    envi_costo DECIMAL(18, 2),
);
GO

-- Agregar FKs
ALTER TABLE GROUP_BY_PROMOCION.DetallesFactura
    ADD FOREIGN KEY(dfac_publicacion) REFERENCES GROUP_BY_PROMOCION.Publicaciones(publ_codigo) ON DELETE SET NULL,
        FOREIGN KEY(dfac_factura) REFERENCES GROUP_BY_PROMOCION.Facturas(fact_numero) ON DELETE SET NULL,
        FOREIGN KEY(dfac_tipo) REFERENCES GROUP_BY_PROMOCION.TiposDetalleFactura(tdfa_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.Facturas
    ADD FOREIGN KEY(fact_vendedor) REFERENCES GROUP_BY_PROMOCION.Vendedores(vend_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.Productos
    ADD FOREIGN KEY(prod_sub_rubro) REFERENCES GROUP_BY_PROMOCION.SubRubros(subr_codigo) ON DELETE SET NULL,
        FOREIGN KEY(prod_marca) REFERENCES GROUP_BY_PROMOCION.Marcas(marc_codigo) ON DELETE SET NULL,
        FOREIGN KEY(prod_modelo) REFERENCES GROUP_BY_PROMOCION.Modelos(mode_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.SubRubros
    ADD FOREIGN KEY(subr_rubro) REFERENCES GROUP_BY_PROMOCION.Rubros(rubr_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.Publicaciones
    ADD FOREIGN KEY(publ_vendedor) REFERENCES GROUP_BY_PROMOCION.Vendedores(vend_codigo) ON DELETE SET NULL,
        FOREIGN KEY(publ_almacen) REFERENCES GROUP_BY_PROMOCION.Almacenes(alma_codigo) ON DELETE SET NULL,
        FOREIGN KEY(publ_producto) REFERENCES GROUP_BY_PROMOCION.Productos(prod_id) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.Localidades
    ADD FOREIGN KEY(loca_provincia) REFERENCES GROUP_BY_PROMOCION.Provincias(prov_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.Almacenes
    ADD FOREIGN KEY(alma_localidad) REFERENCES GROUP_BY_PROMOCION.Localidades(loca_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.DetallesVenta
    ADD FOREIGN KEY(dven_venta) REFERENCES GROUP_BY_PROMOCION.Ventas(vent_codigo) ON DELETE NO ACTION,
        FOREIGN KEY(dven_publicacion) REFERENCES GROUP_BY_PROMOCION.Publicaciones(publ_codigo) ON DELETE NO ACTION;

ALTER TABLE GROUP_BY_PROMOCION.Ventas
    ADD FOREIGN KEY(vent_cliente) REFERENCES GROUP_BY_PROMOCION.Clientes(clie_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.DetallesPago
    ADD FOREIGN KEY(dpag_pago) REFERENCES GROUP_BY_PROMOCION.Pagos(pago_codigo) ON DELETE NO ACTION;

ALTER TABLE GROUP_BY_PROMOCION.Pagos
    ADD FOREIGN KEY(pago_medio_de_pago) REFERENCES GROUP_BY_PROMOCION.MediosDePago(mpag_codigo) ON DELETE SET NULL,
        FOREIGN KEY(pago_venta) REFERENCES GROUP_BY_PROMOCION.Ventas(vent_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.MediosDePago
    ADD FOREIGN KEY(mpag_tipo) REFERENCES GROUP_BY_PROMOCION.TiposMedioDePago(tmdp_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.Vendedores
    ADD FOREIGN KEY(vend_usuario) REFERENCES GROUP_BY_PROMOCION.Usuarios(usua_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.Clientes
    ADD FOREIGN KEY(clie_usuario) REFERENCES GROUP_BY_PROMOCION.Usuarios(usua_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.Domicilios
    ADD FOREIGN KEY(domi_usuario) REFERENCES GROUP_BY_PROMOCION.Usuarios(usua_codigo) ON DELETE SET NULL,
        FOREIGN KEY(domi_localidad) REFERENCES GROUP_BY_PROMOCION.Localidades(loca_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.Envios
    ADD FOREIGN KEY(envi_venta) REFERENCES GROUP_BY_PROMOCION.Ventas(vent_codigo) ON DELETE SET NULL,
        FOREIGN KEY(envi_tipo) REFERENCES GROUP_BY_PROMOCION.TiposEnvio(tden_codigo) ON DELETE SET NULL,
        FOREIGN KEY(envi_domicilio) REFERENCES GROUP_BY_PROMOCION.Domicilios(domi_codigo) ON DELETE SET NULL;
GO

/*
** Carga de datos
*/

/* Tablas simples (sin FKs) */

-- TiposDetalleFactura
INSERT INTO GROUP_BY_PROMOCION.TiposDetalleFactura (tdfa_descripcion)
    SELECT DISTINCT FACTURA_DET_TIPO FROM gd_esquema.Maestra
    WHERE FACTURA_DET_TIPO IS NOT NULL;
GO

-- Marcas
INSERT INTO GROUP_BY_PROMOCION.Marcas (marc_descripcion)
    SELECT DISTINCT PRODUCTO_MARCA FROM gd_esquema.Maestra
    WHERE PRODUCTO_MARCA IS NOT NULL;
GO

-- Modelos
INSERT INTO GROUP_BY_PROMOCION.Modelos (mode_codigo, mode_descripcion)
    SELECT DISTINCT PRODUCTO_MOD_CODIGO, PRODUCTO_MOD_DESCRIPCION FROM gd_esquema.Maestra
    WHERE PRODUCTO_MOD_CODIGO IS NOT NULL;
GO

-- Rubros
INSERT INTO GROUP_BY_PROMOCION.Rubros (rubr_descripcion)
    SELECT DISTINCT PRODUCTO_RUBRO_DESCRIPCION FROM gd_esquema.Maestra
    WHERE PRODUCTO_RUBRO_DESCRIPCION IS NOT NULL;
GO

-- Provincias
INSERT INTO GROUP_BY_PROMOCION.Provincias (prov_descripcion)
    -- Todas las provincias, union evita repetidos
    SELECT DISTINCT ALMACEN_PROVINCIA AS PROVINCIA FROM gd_esquema.Maestra
    WHERE ALMACEN_PROVINCIA IS NOT NULL
    UNION
    SELECT DISTINCT CLI_USUARIO_DOMICILIO_PROVINCIA AS PROVINCIA FROM gd_esquema.Maestra
    WHERE CLI_USUARIO_DOMICILIO_PROVINCIA IS NOT NULL
    UNION
    SELECT DISTINCT VEN_USUARIO_DOMICILIO_PROVINCIA AS PROVINCIA FROM gd_esquema.Maestra
    WHERE VEN_USUARIO_DOMICILIO_PROVINCIA IS NOT NULL
GO

-- TiposMedioDePago
INSERT INTO GROUP_BY_PROMOCION.TiposMedioDePago (tmdp_descripcion)
    SELECT DISTINCT PAGO_TIPO_MEDIO_PAGO FROM gd_esquema.Maestra
    WHERE PAGO_TIPO_MEDIO_PAGO IS NOT NULL;
GO

-- Usuarios
-- Distintos clientes/vendedores comparten el mismo usuario
INSERT INTO GROUP_BY_PROMOCION.Usuarios (usua_nombre, usua_contrasenia, usua_fecha_crea)
    SELECT DISTINCT
        CLI_USUARIO_NOMBRE nombre,
        CLI_USUARIO_PASS contrasenia,
        CLI_USUARIO_FECHA_CREACION fecha_crea
    FROM gd_esquema.Maestra
    WHERE CLI_USUARIO_NOMBRE IS NOT NULL
    UNION
    SELECT DISTINCT
        VEN_USUARIO_NOMBRE nombre,
        VEN_USUARIO_PASS contrasenia,
        VEN_USUARIO_FECHA_CREACION fecha_crea
    FROM gd_esquema.Maestra
    WHERE VEN_USUARIO_NOMBRE IS NOT NULL
GO

-- TiposEnvio
INSERT INTO GROUP_BY_PROMOCION.TiposEnvio (tden_descripcion)
    SELECT DISTINCT ENVIO_TIPO FROM gd_esquema.Maestra
    WHERE ENVIO_TIPO IS NOT NULL;
GO

/* Tablas con FKs */

-- SubRubros
INSERT INTO GROUP_BY_PROMOCION.SubRubros (subr_rubro, subr_descripcion)
    SELECT DISTINCT r.rubr_codigo, m.PRODUCTO_SUB_RUBRO
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Rubros r ON r.rubr_descripcion = m.PRODUCTO_RUBRO_DESCRIPCION
    WHERE m.PRODUCTO_RUBRO_DESCRIPCION IS NOT NULL;
GO

-- Productos
INSERT INTO GROUP_BY_PROMOCION.Productos (prod_codigo, prod_sub_rubro, prod_marca, prod_modelo, prod_descripcion, prod_precio)
    SELECT DISTINCT m.PRODUCTO_CODIGO, s.subr_codigo, ma.marc_codigo, m.PRODUCTO_MOD_CODIGO, m.PRODUCTO_DESCRIPCION, m.PRODUCTO_PRECIO
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Rubros r ON r.rubr_descripcion = m.PRODUCTO_RUBRO_DESCRIPCION
    JOIN GROUP_BY_PROMOCION.Subrubros s ON s.subr_rubro = r.rubr_codigo AND s.subr_descripcion = m.PRODUCTO_SUB_RUBRO
    JOIN GROUP_BY_PROMOCION.Marcas ma ON ma.marc_descripcion = m.PRODUCTO_MARCA
    WHERE m.PRODUCTO_CODIGO IS NOT NULL;
GO

-- Localidades
INSERT INTO GROUP_BY_PROMOCION.Localidades (loca_provincia, loca_descripcion)
    -- Todas las localidades, unidas con sus provincias
    SELECT DISTINCT p.prov_codigo, m.ALMACEN_Localidad
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Provincias p on p.prov_descripcion = m.ALMACEN_PROVINCIA
    WHERE m.ALMACEN_LOCALIDAD IS NOT NULL
    UNION
    SELECT DISTINCT p.prov_codigo, m.CLI_USUARIO_DOMICILIO_LOCALIDAD
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Provincias p on p.prov_descripcion = m.CLI_USUARIO_DOMICILIO_PROVINCIA
    WHERE m.CLI_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL
    UNION
    SELECT DISTINCT p.prov_codigo, m.VEN_USUARIO_DOMICILIO_LOCALIDAD
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Provincias p on p.prov_descripcion = m.VEN_USUARIO_DOMICILIO_PROVINCIA
    WHERE m.VEN_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL;
GO

-- Almacenes
INSERT INTO GROUP_BY_PROMOCION.Almacenes (alma_codigo, alma_localidad, alma_calle, alma_nro_calle, alma_costo_dia)
    SELECT DISTINCT m.ALMACEN_CODIGO, l.loca_codigo, m.ALMACEN_CALLE, m.ALMACEN_NRO_CALLE, m.ALMACEN_COSTO_DIA_AL
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Provincias p ON p.prov_descripcion = m.ALMACEN_PROVINCIA
    JOIN GROUP_BY_PROMOCION.Localidades l ON l.loca_descripcion = m.ALMACEN_LOCALIDAD AND l.loca_provincia = p.prov_codigo
    WHERE m.ALMACEN_CODIGO IS NOT NULL;
GO

-- Vendedores
INSERT INTO GROUP_BY_PROMOCION.Vendedores (vend_usuario, vend_razon_social, vend_mail, vend_cuit)
    SELECT DISTINCT u.usua_codigo, m.VENDEDOR_RAZON_SOCIAL, m.VENDEDOR_MAIL, m.VENDEDOR_CUIT
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Usuarios u ON
        u.usua_nombre = m.VEN_USUARIO_NOMBRE AND
        u.usua_contrasenia = m.VEN_USUARIO_PASS AND
        u.usua_fecha_crea = m.VEN_USUARIO_FECHA_CREACION
    WHERE m.VENDEDOR_RAZON_SOCIAL IS NOT NULL;
GO

-- Clientes
INSERT INTO GROUP_BY_PROMOCION.Clientes (clie_usuario, clie_nombre, clie_apellido, clie_fecha_nac, clie_mail, clie_dni)
    SELECT DISTINCT u.usua_codigo, m.CLIENTE_NOMBRE, m.CLIENTE_APELLIDO, m.CLIENTE_FECHA_NAC, m.CLIENTE_MAIL, m.CLIENTE_DNI
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Usuarios u ON
        u.usua_nombre = m.CLI_USUARIO_NOMBRE AND
        u.usua_contrasenia = m.CLI_USUARIO_PASS AND
        u.usua_fecha_crea = m.CLI_USUARIO_FECHA_CREACION
    WHERE m.CLIENTE_NOMBRE IS NOT NULL;
GO

-- Domicilios
INSERT INTO GROUP_BY_PROMOCION.Domicilios (domi_usuario, domi_localidad, domi_calle, domi_nro_calle, domi_piso, domi_depto, domi_cp)
    -- Hay que considerar los domicilios de vendedores y de clientes
    SELECT DISTINCT 
        u.usua_codigo,
        l.loca_codigo,
        m.CLI_USUARIO_DOMICILIO_CALLE,
        m.CLI_USUARIO_DOMICILIO_NRO_CALLE,
        m.CLI_USUARIO_DOMICILIO_PISO,
        m.CLI_USUARIO_DOMICILIO_DEPTO,
        m.CLI_USUARIO_DOMICILIO_CP
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Usuarios u ON
        u.usua_nombre = m.CLI_USUARIO_NOMBRE AND
        u.usua_contrasenia = m.CLI_USUARIO_PASS AND
        u.usua_fecha_crea = m.CLI_USUARIO_FECHA_CREACION
    JOIN GROUP_BY_PROMOCION.Provincias p ON p.prov_descripcion = m.CLI_USUARIO_DOMICILIO_PROVINCIA
    JOIN GROUP_BY_PROMOCION.Localidades l ON l.loca_provincia = p.prov_codigo AND l.loca_descripcion = CLI_USUARIO_DOMICILIO_LOCALIDAD
    WHERE m.CLI_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL
    UNION
    SELECT DISTINCT 
        u.usua_codigo,
        l.loca_codigo,
        m.VEN_USUARIO_DOMICILIO_CALLE,
        m.VEN_USUARIO_DOMICILIO_NRO_CALLE,
        m.VEN_USUARIO_DOMICILIO_PISO,
        m.VEN_USUARIO_DOMICILIO_DEPTO,
        m.VEN_USUARIO_DOMICILIO_CP
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Usuarios u ON
        u.usua_nombre = m.VEN_USUARIO_NOMBRE AND
        u.usua_contrasenia = m.VEN_USUARIO_PASS AND
        u.usua_fecha_crea = m.VEN_USUARIO_FECHA_CREACION
    JOIN GROUP_BY_PROMOCION.Provincias p ON p.prov_descripcion = m.VEN_USUARIO_DOMICILIO_PROVINCIA
    JOIN GROUP_BY_PROMOCION.Localidades l ON l.loca_provincia = p.prov_codigo AND l.loca_descripcion = VEN_USUARIO_DOMICILIO_LOCALIDAD
    WHERE m.VEN_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL;
GO

-- Publicaciones
INSERT INTO GROUP_BY_PROMOCION.Publicaciones (
    publ_codigo,
    publ_vendedor,
    publ_almacen,
    publ_producto,
    publ_descripcion,
    publ_fecha_inicio,
    publ_fecha_cierre,
    publ_stock,
    publ_precio,
    publ_costo,
    publ_porc_venta
)
    SELECT DISTINCT  
        m.PUBLICACION_CODIGO,
        v.vend_codigo,
        a.alma_codigo,
        pr.prod_id,
        m.PUBLICACION_DESCRIPCION,
        m.PUBLICACION_FECHA,
        m.PUBLICACION_FECHA_V,
        m.PUBLICACION_STOCK,
        m.PUBLICACION_PRECIO,
        m.PUBLICACION_COSTO,
        m.PUBLICACION_PORC_VENTA
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Vendedores v ON v.vend_cuit = m.VENDEDOR_CUIT
    JOIN GROUP_BY_PROMOCION.Provincias pv ON pv.prov_descripcion = m.ALMACEN_PROVINCIA
    JOIN GROUP_BY_PROMOCION.Localidades l ON l.loca_provincia = pv.prov_codigo AND l.loca_descripcion = m.ALMACEN_Localidad
    JOIN GROUP_BY_PROMOCION.Almacenes a ON 
        a.alma_localidad = l.loca_codigo AND
        a.alma_calle = m.ALMACEN_CALLE AND
        a.alma_nro_calle = m.ALMACEN_NRO_CALLE AND
        a.alma_costo_dia = m.ALMACEN_COSTO_DIA_AL
    JOIN GROUP_BY_PROMOCION.Rubros r ON r.rubr_descripcion = m.PRODUCTO_RUBRO_DESCRIPCION
    JOIN GROUP_BY_PROMOCION.SubRubros sr ON sr.subr_rubro = r.rubr_codigo AND sr.subr_descripcion = m.PRODUCTO_SUB_RUBRO
    JOIN GROUP_BY_PROMOCION.Marcas ma ON ma.marc_descripcion = m.PRODUCTO_MARCA
    JOIN GROUP_BY_PROMOCION.Productos pr ON 
        pr.prod_sub_rubro = sr.subr_codigo AND
        pr.prod_marca = ma.marc_codigo AND
        pr.prod_modelo = m.PRODUCTO_MOD_CODIGO AND
        pr.prod_codigo = m.PRODUCTO_CODIGO AND
        pr.prod_descripcion = m.PRODUCTO_DESCRIPCION AND
        pr.prod_precio = m.PRODUCTO_PRECIO
    WHERE m.PUBLICACION_CODIGO IS NOT NULL;
GO

-- Facturas
INSERT INTO GROUP_BY_PROMOCION.Facturas (fact_numero, fact_vendedor, fact_total, fact_fecha)
    SELECT DISTINCT m.FACTURA_NUMERO, v.vend_codigo, m.FACTURA_TOTAL, m.FACTURA_FECHA
    FROM gd_esquema.Maestra m
    JOIN gd_esquema.Maestra m_vendedor ON m_vendedor.PUBLICACION_CODIGO = m.PUBLICACION_CODIGO
    JOIN GROUP_BY_PROMOCION.Vendedores v ON v.vend_cuit = m_vendedor.VENDEDOR_CUIT
    WHERE m.FACTURA_NUMERO IS NOT NULL;
GO

-- DetallesFactura
INSERT INTO GROUP_BY_PROMOCION.DetallesFactura (dfac_publicacion, dfac_factura, dfac_tipo, dfac_cantidad, dfac_subtotal, dfac_precio)
    SELECT DISTINCT m.PUBLICACION_CODIGO, m.FACTURA_NUMERO, td.tdfa_codigo, m.FACTURA_DET_CANTIDAD, m.FACTURA_DET_SUBTOTAL, m.FACTURA_DET_PRECIO
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.TiposDetalleFactura td ON td.tdfa_descripcion = m.FACTURA_DET_TIPO
    WHERE m.FACTURA_NUMERO IS NOT NULL;
GO

-- Ventas
INSERT INTO GROUP_BY_PROMOCION.Ventas (vent_codigo, vent_cliente, vent_fecha, vent_total)
    SELECT DISTINCT m.VENTA_CODIGO, c.clie_codigo, m.VENTA_FECHA, m.VENTA_TOTAL
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Clientes c ON c.clie_dni = m.CLIENTE_DNI AND c.clie_fecha_nac = m.CLIENTE_FECHA_NAC
    WHERE m.VENTA_CODIGO IS NOT NULL;
GO

-- DetallesVenta
INSERT INTO GROUP_BY_PROMOCION.DetallesVenta (dven_venta, dven_publicacion, dven_precio, dven_cantidad, dven_subtotal)
    SELECT DISTINCT m.VENTA_CODIGO, m.PUBLICACION_CODIGO, m.VENTA_DET_PRECIO, m.VENTA_DET_CANT, m.VENTA_DET_SUB_TOTAL
    FROM gd_esquema.Maestra m
    WHERE m.VENTA_DET_CANT IS NOT NULL;
GO

-- MediosDePago
INSERT INTO GROUP_BY_PROMOCION.MediosDePago (mpag_tipo, mpag_descripcion)
    SELECT DISTINCT t.tmdp_codigo, m.PAGO_MEDIO_PAGO
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.TiposMedioDePago t ON t.tmdp_descripcion = m.PAGO_TIPO_MEDIO_PAGO
    WHERE m.PAGO_MEDIO_PAGO IS NOT NULL;
GO

-- Pagos
INSERT INTO GROUP_BY_PROMOCION.Pagos (pago_medio_de_pago, pago_venta, pago_importe, pago_fecha)
    SELECT DISTINCT mp.mpag_codigo, m.VENTA_CODIGO, m.PAGO_IMPORTE, m.PAGO_FECHA
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.TiposMedioDePago tmp ON tmp.tmdp_descripcion = m.PAGO_TIPO_MEDIO_PAGO
    JOIN GROUP_BY_PROMOCION.MediosDePago mp ON mp.mpag_tipo = tmp.tmdp_codigo AND mp.mpag_descripcion = m.PAGO_MEDIO_PAGO
    WHERE m.PAGO_IMPORTE IS NOT NULL;
GO

-- DetallesPago
INSERT INTO GROUP_BY_PROMOCION.DetallesPago (dpag_pago, dpag_nro_tarjeta, dpag_fecha_venc_tarjeta, dpag_cant_cuotas)
    SELECT DISTINCT p.pago_codigo, m.PAGO_NRO_TARJETA, m.PAGO_FECHA_VENC_TARJETA, m.PAGO_CANT_CUOTAS
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.TiposMedioDePago tmp ON tmp.tmdp_descripcion = m.PAGO_TIPO_MEDIO_PAGO
    JOIN GROUP_BY_PROMOCION.MediosDePago mp ON mp.mpag_tipo = tmp.tmdp_codigo AND mp.mpag_descripcion = m.PAGO_MEDIO_PAGO
    JOIN GROUP_BY_PROMOCION.Pagos p ON
        p.pago_medio_de_pago = mp.mpag_codigo AND
        p.pago_venta = m.VENTA_CODIGO AND
        p.pago_importe = m.PAGO_IMPORTE AND
        p.pago_fecha = m.PAGO_FECHA
    WHERE m.PAGO_NRO_TARJETA IS NOT NULL;
GO

-- Envios
INSERT INTO GROUP_BY_PROMOCION.Envios (
    envi_venta,
    envi_tipo,
    envi_domicilio,
    envi_fecha_programada,
    envi_hora_inicio,
    envi_hora_fin,
    envi_fecha_entrega,
    envi_costo
)
    SELECT DISTINCT
        m.VENTA_CODIGO,
        te.tden_codigo,
        d.domi_codigo,
        m.ENVIO_FECHA_PROGAMADA,
        m.ENVIO_HORA_INICIO,
        m.ENVIO_HORA_FIN_INICIO,
        m.ENVIO_FECHA_ENTREGA,
        m.ENVIO_COSTO
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.TiposEnvio te ON te.tden_descripcion = m.ENVIO_TIPO
    JOIN GROUP_BY_PROMOCION.Usuarios u ON
        u.usua_nombre = m.CLI_USUARIO_NOMBRE AND
        u.usua_contrasenia = m.CLI_USUARIO_PASS AND
        u.usua_fecha_crea = m.CLI_USUARIO_FECHA_CREACION
    JOIN GROUP_BY_PROMOCION.Provincias pv ON pv.prov_descripcion = m.CLI_USUARIO_DOMICILIO_PROVINCIA
    JOIN GROUP_BY_PROMOCION.Localidades l ON l.loca_provincia = pv.prov_codigo AND l.loca_descripcion = m.CLI_USUARIO_DOMICILIO_LOCALIDAD
    JOIN GROUP_BY_PROMOCION.Domicilios d ON
        d.domi_usuario = u.usua_codigo AND
        d.domi_localidad = l.loca_codigo AND
        d.domi_calle = m.CLI_USUARIO_DOMICILIO_CALLE AND
        d.domi_nro_calle = m.CLI_USUARIO_DOMICILIO_NRO_CALLE AND
        d.domi_piso = m.CLI_USUARIO_DOMICILIO_PISO AND
        d.domi_depto = m.CLI_USUARIO_DOMICILIO_DEPTO AND
        d.domi_cp = m.CLI_USUARIO_DOMICILIO_CP
    WHERE m.ENVIO_COSTO IS NOT NULL;
GO