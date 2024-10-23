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
    tdfa_descripcion NVARCHAR(50) NOT NULL
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
    fact_usuario DECIMAL(18), -- FK
    fact_total DECIMAL(18, 2) NOT NULL,
    fact_fecha DATE NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.Marcas (
    marc_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    marc_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Modelos (
    mode_codigo DECIMAL(18) PRIMARY KEY,
    mode_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Productos (
    prod_codigo NVARCHAR(50) PRIMARY KEY,   -- TODO Terminar de chequear que esto este bien
    prod_sub_rubro DECIMAL(18), -- FK
    prod_marca DECIMAL(18), -- FK
    prod_modelo DECIMAL(18), -- FK
    prod_descripcion NVARCHAR(50) NOT NULL,
    prod_precio DECIMAL(18,2) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Rubros (
    rubr_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    rubr_descripcion NVARCHAR(50) NOT NULL
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
    publ_producto NVARCHAR(50), -- FK
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
    prov_descripcion NVARCHAR(50) NOT NULL
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
    pago_venta DECIMAL(18), -- FK
    pago_importe DECIMAL(18, 2) NOT NULL,
    pago_fecha DATE NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.TiposMedioDePago (
    tmdp_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    tmdp_descripcion NVARCHAR(50) NOT NULL
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
    vend_cuit DECIMAL(18) NOT NULL
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
    tden_descripcion NVARCHAR(50) NOT NULL
)
CREATE TABLE GROUP_BY_PROMOCION.Envios (
    envi_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    envi_venta DECIMAL(18), -- FK
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
    ADD FOREIGN KEY(fact_usuario) REFERENCES GROUP_BY_PROMOCION.Usuarios(usua_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.Productos
    ADD FOREIGN KEY(prod_sub_rubro) REFERENCES GROUP_BY_PROMOCION.SubRubros(subr_codigo) ON DELETE SET NULL,
        FOREIGN KEY(prod_marca) REFERENCES GROUP_BY_PROMOCION.Marcas(marc_codigo) ON DELETE SET NULL,
        FOREIGN KEY(prod_modelo) REFERENCES GROUP_BY_PROMOCION.Modelos(mode_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.SubRubros
    ADD FOREIGN KEY(subr_rubro) REFERENCES GROUP_BY_PROMOCION.Rubros(rubr_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.Publicaciones
    ADD FOREIGN KEY(publ_vendedor) REFERENCES GROUP_BY_PROMOCION.Vendedores(vend_codigo) ON DELETE SET NULL,
        FOREIGN KEY(publ_almacen) REFERENCES GROUP_BY_PROMOCION.Almacenes(alma_codigo) ON DELETE SET NULL,
        FOREIGN KEY(publ_producto) REFERENCES GROUP_BY_PROMOCION.Productos(prod_codigo) ON DELETE SET NULL;

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


/*
** Carga de datos
*/

/* Tablas simples (sin FKs) */

INSERT INTO GROUP_BY_PROMOCION.TiposDetalleFactura (tdfa_descripcion)
    SELECT DISTINCT FACTURA_DET_TIPO FROM gd_esquema.Maestra
    WHERE FACTURA_DET_TIPO IS NOT NULL;

INSERT INTO GROUP_BY_PROMOCION.Marcas (marc_descripcion)
    SELECT DISTINCT PRODUCTO_MARCA FROM gd_esquema.Maestra
    WHERE PRODUCTO_MARCA IS NOT NULL;

INSERT INTO GROUP_BY_PROMOCION.Modelos (mode_codigo, mode_descripcion)
    SELECT DISTINCT PRODUCTO_MOD_CODIGO, PRODUCTO_MOD_DESCRIPCION FROM gd_esquema.Maestra
    WHERE PRODUCTO_MOD_CODIGO IS NOT NULL;

INSERT INTO GROUP_BY_PROMOCION.Rubros (rubr_descripcion)
    SELECT DISTINCT PRODUCTO_RUBRO_DESCRIPCION FROM gd_esquema.Maestra
    WHERE PRODUCTO_RUBRO_DESCRIPCION IS NOT NULL;

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

INSERT INTO GROUP_BY_PROMOCION.TiposMedioDePago (tmdp_descripcion)
    SELECT DISTINCT PAGO_TIPO_MEDIO_PAGO FROM gd_esquema.Maestra
    WHERE PAGO_TIPO_MEDIO_PAGO IS NOT NULL;

-- TODO Usuarios

INSERT INTO GROUP_BY_PROMOCION.TiposEnvio (tden_descripcion)
    SELECT DISTINCT ENVIO_TIPO FROM gd_esquema.Maestra
    WHERE ENVIO_TIPO IS NOT NULL;

/* Tablas con FKs */

-- TODO Facturas
/*INSERT INTO GROUP_BY_PROMOCION.Facturas (fact_usuario, fact_total, fact_fecha)
    SELECT DISTINCT u.usua_codigo, m.FACTURA_TOTAL, m.FACTURA_FECHA
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.usuario u ON 
    WHERE m.FACTURA_NUMERO IS NOT NULL;
*/

-- TODO DetallesFactura

INSERT INTO GROUP_BY_PROMOCION.SubRubros (subr_rubro, subr_descripcion)
    SELECT DISTINCT r.rubr_codigo, m.PRODUCTO_SUB_RUBRO
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Rubros r ON r.rubr_descripcion = m.PRODUCTO_RUBRO_DESCRIPCION
    WHERE m.PRODUCTO_RUBRO_DESCRIPCION IS NOT NULL;

-- TODO Productos
/*
INSERT INTO GROUP_BY_PROMOCION.Productos (prod_codigo, prod_sub_rubro, prod_marca, prod_modelo, prod_descripcion, prod_precio)
    SELECT DISTINCT m.PRODUCTO_CODIGO, s.subr_codigo, ma.marc_codigo, m.PRODUCTO_MOD_CODIGO, m.PRODUCTO_DESCRIPCION, m.PRODUCTO_PRECIO
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Subrubros s ON s.subr_descripcion = m.PRODUCTO_SUB_RUBRO
    JOIN GROUP_BY_PROMOCION.Marcas ma ON ma.marc_descripcion = m.PRODUCTO_MARCA
    WHERE m.PRODUCTO_CODIGO IS NOT NULL;
*/

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

INSERT INTO GROUP_BY_PROMOCION.Almacenes (alma_codigo, alma_localidad, alma_calle, alma_nro_calle, alma_costo_dia)
    SELECT DISTINCT m.ALMACEN_CODIGO, l.loca_codigo, m.ALMACEN_CALLE, m.ALMACEN_NRO_CALLE, m.ALMACEN_COSTO_DIA_AL
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.Provincias p ON p.prov_descripcion = m.ALMACEN_PROVINCIA
    JOIN GROUP_BY_PROMOCION.Localidades l ON l.loca_descripcion = m.ALMACEN_LOCALIDAD AND l.loca_provincia = p.prov_codigo
    WHERE m.ALMACEN_CODIGO IS NOT NULL;

-- TODO Vendedores
-- TODO Clientes

-- TODO Domicilios

-- TODO Publicaciones

-- TODO Ventas
-- TODO DetallesVenta

INSERT INTO GROUP_BY_PROMOCION.MediosDePago (mpag_tipo, mpag_descripcion)
    SELECT DISTINCT t.tmdp_codigo, m.PAGO_MEDIO_PAGO
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.TiposMedioDePago t ON t.tmdp_descripcion = m.PAGO_TIPO_MEDIO_PAGO
    WHERE m.PAGO_MEDIO_PAGO IS NOT NULL;

/*
INSERT INTO GROUP_BY_PROMOCION.Pagos (pago_medio_de_pago, pago_importe, pago_fecha)
    SELECT DISTINCT mp.mpag_codigo, m.PAGO_IMPORTE, m.PAGO_FECHA
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.TiposMedioDePago tmp on tmp.tmdp_descripcion = m.PAGO_TIPO_MEDIO_PAGO 
    JOIN GROUP_BY_PROMOCION.MediosDePago mp ON mp.mpag_descripcion = m.PAGO_MEDIO_PAGO AND mp.mpag_tipo = tmp.tmdp_codigo
    WHERE m.PAGO_MEDIO_PAGO IS NOT NULL;
    

INSERT INTO GROUP_BY_PROMOCION.DetallesPago (dpag_pago, dpag_nro_tarjeta, dpag_fecha_venc_tarjeta, dpag_cant_cuotas)
    SELECT DISTINCT p.pago_codigo, m.PAGO_NRO_TARJETA, m.PAGO_FECHA_VENC_TARJETA, m.PAGO_CANT_CUOTAS
    FROM gd_esquema.Maestra m
    JOIN GROUP_BY_PROMOCION.TiposMedioDePago tmp on tmp.tmdp_descripcion = m.PAGO_TIPO_MEDIO_PAGO 
    JOIN GROUP_BY_PROMOCION.MediosDePago mp ON mp.mpag_descripcion = m.PAGO_MEDIO_PAGO AND mp.mpag_tipo = tmp.tmdp_codigo
    JOIN GROUP_BY_PROMOCION.Pagos p ON p.pago_
    WHERE m.PAGO_NRO_TARJETA IS NOT NULL;
*/

-- TODO Envios