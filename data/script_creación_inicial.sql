USE GD2C2024;
GO;

-- Crear Esquema
CREATE SCHEMA GROUP_BY_PROMOCION;
GO;

-- Crear Tablas

CREATE TABLE TiposDetalleFactura (
    tdfa_codigo DECIMAL(18) PRIMARY KEY,
    tdfa_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE DetallesFactura (
    dfac_codigo DECIMAL(18) PRIMARY KEY,
    dfac_publicacion DECIMAL(18), -- FK
    dfac_factura DECIMAL(18), -- FK
    dfac_tipo DECIMAL(18), -- FK
    dfac_cantidad DECIMAL(18) NOT NULL,
    dfac_subtotal DECIMAL(18, 2) NOT NULL,
    dfac_precio DECIMAL(18, 2) NOT NULL
);
CREATE TABLE Facturas (
    fact_numero DECIMAL(18) PRIMARY KEY,
    fact_usuario DECIMAL(18, 2), -- FK
    fact_total DECIMAL(18, 2) NOT NULL,
    fact_fecha DATE NOT NULL
);

CREATE TABLE Marcas (
    marc_codigo DECIMAL(18) PRIMARY KEY,
    marc_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE Modelos (
    mode_codigo DECIMAL(18) PRIMARY KEY,
    mode_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE Productos (
    prod_codigo DECIMAL(18) PRIMARY KEY,
    prod_sub_rubro DECIMAL(18), -- FK
    prod_marca DECIMAL(18), -- FK
    prod_modelo DECIMAL(18), -- FK
    prod_descripcion NVARCHAR(50) NOT NULL,
    prod_precio DECIMAL(18,2) NOT NULL
);
CREATE TABLE Rubros (
    rubr_codigo DECIMAL(18) PRIMARY KEY,
    rubr_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE SubRubros (
    subr_codigo DECIMAL(18) PRIMARY KEY,
    subr_rubro DECIMAL(18), -- FK
    subr_descripcion NVARCHAR(50) NOT NULL
);

CREATE TABLE Publicaciones (
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

CREATE TABLE Localidades (
    loca_codigo DECIMAL(18) PRIMARY KEY,
    loca_provincia DECIMAL(18), -- FK
    loca_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE Provincias (
    prov_codigo DECIMAL(18) PRIMARY KEY,
    prov_descripcion NVARCHAR(50) NOT NULL
);

CREATE TABLE Almacenes (
    alma_codigo DECIMAL(18) PRIMARY KEY,
    alma_localidad DECIMAL(18), -- FK
    alma_calle NVARCHAR(50) NOT NULL,
    alma_nro_calle DECIMAL(18) NOT NULL,
    alma_costo_dia DECIMAL(18, 2) NOT NULL
);

CREATE TABLE DetallesVenta (
    dven_venta DECIMAL(18), -- FK
    dven_publicacion DECIMAL(18), -- FK
    dven_precio DECIMAL(18, 2) NOT NULL,
    dven_cantidad DECIMAL(18) NOT NULL,
    dven_subtotal DECIMAL(18, 2) NOT NULL

    PRIMARY KEY (dven_venta, dven_publicacion)
);
CREATE TABLE Ventas (
    vent_codigo DECIMAL(18) PRIMARY KEY,
    vent_cliente DECIMAL(18), -- FK
    vent_pago DECIMAL(18), -- FK
    vent_fecha DATETIME NOT NULL,
    vent_total DECIMAL(18,2) NOT NULL
);

CREATE TABLE DetallesPago (
    dpag_pago DECIMAL(18) PRIMARY KEY, -- FK
    dpag_nro_tarjeta NVARCHAR(50) NOT NULL,
    dpag_fecha_venc_tarjeta DATE NOT NULL,
    dpag_cant_cuotas DECIMAL(18) NOT NULL
);
CREATE TABLE Pagos (
    pago_codigo DECIMAL(18) PRIMARY KEY,
    pago_medio_de_pago DECIMAL(18), -- FK
    pago_fecha DATE NOT NULL
);
CREATE TABLE TiposMedioDePago (
    tmdp_codigo DECIMAL(18) PRIMARY KEY,
    tmdp_descripcion NVARHCAR(50) NOT NULL
);
CREATE TABLE MediosDePago (
    mpag_codigo DECIMAL(18) PRIMARY KEY,
    mpag_tipo DECIMAL(18), -- FK
    mpag_descripcion NVARHCAR(50) NOT NULL
);

CREATE TABLE Vendedores (
    vend_codigo DECIMAL(18) PRIMARY KEY,
    vend_usuario DECIMAL(18), -- FK
    vend_razon_social NVARCHAR(50) NOT NULL,
    vend_mail NVARCHAR(50) NOT NULL,
    vend_cuit DECIMAL(18) NOT NULL
);
CREATE TABLE Clientes (
    clie_codigo DECIMAL(18) PRIMARY KEY,
    clie_usuario DECIMAL(18), -- FK
    clie_nombre NVARCHAR(50) NOT NULL,
    clie_apellido NVARCHAR(50) NOT NULL,
    clie_fecha_nac DATE NOT NULL,
    clie_mail NVARCHAR(50) NOT NULL,
    clie_dni DECIMAL(18) NOT NULL
);
CREATE TABLE Usuarios (
    usua_codigo DECIMAL(18) PRIMARY KEY,
    usua_nombre NVARCHAR(50) NOT NULL,
    usua_contrasenia NVARCHAR(50) NOT NULL,
    usua_fecha_crea DATE NOT NULL
);

CREATE TABLE Domicilios (
    domi_codigo DECIMAL(18) PRIMARY KEY,
    domi_usuario DECIMAL(18), -- FK
    domi_localidad DECIMAL(18), -- FK
    domi_calle NVARCHAR(50) NOT NULL,
    domi_nro_calle DECIMAL(18) NOT NULL,
    domi_piso DECIMAL(18),
    domi_depto NVARCHAR(50),
    domi_cp NVARCHAR(50) NOT_NULL
);

CREATE TABLE TiposEnvio (
    tden_codigo DECIMAL(18) PRIMARY KEY,
    tden_descripcion NVARHCAR(50) NOT NULL
);
CREATE TABLE Envios (
    envi_codigo DECIMAL(18) PRIMARY KEY,
    envi_venta DECIMAL(18), -- FK
    envi_tipo DECIMAL(18), -- FK
    envi_fecha_programada DATE,
    envi_hora_inicio DECIMAL(18),
    envi_hora_fin DECIMAL(18),
    envi_fecha_entrega DATETIME,
    envi_costo DECIMAL(18, 2),
);
GO;

-- FIXME eliminar 
/*
DROP TABLE TiposDetalleFactura;
DROP TABLE DetallesFactura;
DROP TABLE Facturas;

DROP TABLE Marcas;
DROP TABLE Modelos;
DROP TABLE Productos;
DROP TABLE Rubros;
DROP TABLE SubRubros;

DROP TABLE Publicaciones;

DROP TABLE Localidades;
DROP TABLE Provincias;

DROP TABLE Almacenes;

DROP TABLE Ventas;
DROP TABLE DetallesVenta;

DROP TABLE DetallesPago;
DROP TABLE Pagos;
DROP TABLE TiposMedioDePago;
DROP TABLE MediosDePago;

DROP TABLE Vendedores;
DROP TABLE Clientes;
DROP TABLE Usuarios;

DROP TABLE Domicilios;

DROP TABLE TiposEnvio;
DROP TABLE Envios;
*/
