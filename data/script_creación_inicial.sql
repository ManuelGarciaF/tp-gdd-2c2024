USE GD2C2024;
GO

-- Crear Esquema
CREATE SCHEMA GROUP_BY_PROMOCION;
GO

-- Crear Tablas

CREATE TABLE GROUP_BY_PROMOCION.TiposDetalleFactura (
    tdfa_codigo DECIMAL(18) PRIMARY KEY,
    tdfa_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.DetallesFactura (
    dfac_codigo DECIMAL(18) PRIMARY KEY,
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
    marc_codigo DECIMAL(18) PRIMARY KEY,
    marc_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Modelos (
    mode_codigo DECIMAL(18) PRIMARY KEY,
    mode_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Productos (
    prod_codigo DECIMAL(18) PRIMARY KEY,
    prod_sub_rubro DECIMAL(18), -- FK
    prod_marca DECIMAL(18), -- FK
    prod_modelo DECIMAL(18), -- FK
    prod_descripcion NVARCHAR(50) NOT NULL,
    prod_precio DECIMAL(18,2) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Rubros (
    rubr_codigo DECIMAL(18) PRIMARY KEY,
    rubr_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.SubRubros (
    subr_codigo DECIMAL(18) PRIMARY KEY,
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
    loca_codigo DECIMAL(18) PRIMARY KEY,
    loca_provincia DECIMAL(18), -- FK
    loca_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Provincias (
    prov_codigo DECIMAL(18) PRIMARY KEY,
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
    vent_pago DECIMAL(18), -- FK
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
    pago_codigo DECIMAL(18) PRIMARY KEY,
    pago_medio_de_pago DECIMAL(18), -- FK
    pago_fecha DATE NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.TiposMedioDePago (
    tmdp_codigo DECIMAL(18) PRIMARY KEY,
    tmdp_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.MediosDePago (
    mpag_codigo DECIMAL(18) PRIMARY KEY,
    mpag_tipo DECIMAL(18), -- FK
    mpag_descripcion NVARCHAR(50) NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.Vendedores (
    vend_codigo DECIMAL(18) PRIMARY KEY,
    vend_usuario DECIMAL(18), -- FK
    vend_razon_social NVARCHAR(50) NOT NULL,
    vend_mail NVARCHAR(50) NOT NULL,
    vend_cuit DECIMAL(18) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Clientes (
    clie_codigo DECIMAL(18) PRIMARY KEY,
    clie_usuario DECIMAL(18), -- FK
    clie_nombre NVARCHAR(50) NOT NULL,
    clie_apellido NVARCHAR(50) NOT NULL,
    clie_fecha_nac DATE NOT NULL,
    clie_mail NVARCHAR(50) NOT NULL,
    clie_dni DECIMAL(18) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.Usuarios (
    usua_codigo DECIMAL(18) PRIMARY KEY,
    usua_nombre NVARCHAR(50) NOT NULL,
    usua_contrasenia NVARCHAR(50) NOT NULL,
    usua_fecha_crea DATE NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.Domicilios (
    domi_codigo DECIMAL(18) PRIMARY KEY,
    domi_usuario DECIMAL(18), -- FK
    domi_localidad DECIMAL(18), -- FK
    domi_calle NVARCHAR(50) NOT NULL,
    domi_nro_calle DECIMAL(18) NOT NULL,
    domi_piso DECIMAL(18),
    domi_depto NVARCHAR(50),
    domi_cp NVARCHAR(50) NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.TiposEnvio (
    tden_codigo DECIMAL(18) PRIMARY KEY,
    tden_descripcion NVARCHAR(50) NOT NULL
)
CREATE TABLE GROUP_BY_PROMOCION.Envios (
    envi_codigo DECIMAL(18) PRIMARY KEY,
    envi_venta DECIMAL(18), -- FK
    envi_tipo DECIMAL(18), -- FK
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
    ADD FOREIGN KEY(vent_cliente) REFERENCES GROUP_BY_PROMOCION.Clientes(clie_codigo) ON DELETE SET NULL,
        FOREIGN KEY(vent_pago) REFERENCES GROUP_BY_PROMOCION.Pagos(pago_codigo) ON DELETE SET NULL;

ALTER TABLE GROUP_BY_PROMOCION.DetallesPago
    ADD FOREIGN KEY(dpag_pago) REFERENCES GROUP_BY_PROMOCION.Pagos(pago_codigo) ON DELETE NO ACTION;

ALTER TABLE GROUP_BY_PROMOCION.Pagos
    ADD FOREIGN KEY(pago_medio_de_pago) REFERENCES GROUP_BY_PROMOCION.MediosDePago(mpag_codigo) ON DELETE SET NULL;

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
        FOREIGN KEY(envi_tipo) REFERENCES GROUP_BY_PROMOCION.TiposEnvio(tden_codigo) ON DELETE SET NULL;

-- FIXME eliminar 
/*
DROP TABLE GROUP_BY_PROMOCION.TiposDetalleFactura;
DROP TABLE GROUP_BY_PROMOCION.DetallesFactura;
DROP TABLE GROUP_BY_PROMOCION.Facturas;

DROP TABLE GROUP_BY_PROMOCION.Marcas;
DROP TABLE GROUP_BY_PROMOCION.Modelos;
DROP TABLE GROUP_BY_PROMOCION.Productos;
DROP TABLE GROUP_BY_PROMOCION.Rubros;
DROP TABLE GROUP_BY_PROMOCION.SubRubros;

DROP TABLE GROUP_BY_PROMOCION.Publicaciones;

DROP TABLE GROUP_BY_PROMOCION.Localidades;
DROP TABLE GROUP_BY_PROMOCION.Provincias;

DROP TABLE GROUP_BY_PROMOCION.Almacenes;

DROP TABLE GROUP_BY_PROMOCION.Ventas;
DROP TABLE GROUP_BY_PROMOCION.DetallesVenta;

DROP TABLE GROUP_BY_PROMOCION.DetallesPago;
DROP TABLE GROUP_BY_PROMOCION.Pagos;
DROP TABLE GROUP_BY_PROMOCION.TiposMedioDePago;
DROP TABLE GROUP_BY_PROMOCION.MediosDePago;

DROP TABLE GROUP_BY_PROMOCION.Vendedores;
DROP TABLE GROUP_BY_PROMOCION.Clientes;
DROP TABLE GROUP_BY_PROMOCION.Usuarios;

DROP TABLE GROUP_BY_PROMOCION.Domicilios;

DROP TABLE GROUP_BY_PROMOCION.TiposEnvio;
DROP TABLE GROUP_BY_PROMOCION.Envios;
DROP SCHEMA GROUP_BY_PROMOCION 
*/