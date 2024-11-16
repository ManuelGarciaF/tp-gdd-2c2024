USE GD2C2024;
GO

-- Eliminar las tablas
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_Publicaciones','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_Publicaciones;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_Ventas','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_Ventas;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_Facturas','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_Facturas;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_Envios','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_Envios;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_Tiempos','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_Tiempos;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_Rubros','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_Rubros;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_Marcas','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_Marcas;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_Ubicaciones','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_Ubicaciones;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_RangosHorariosVentas','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_RangosHorariosVentas;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_RangosEtariosClientes','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_RangosEtariosClientes;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_TiposMedioDePago','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_TiposMedioDePago;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_ConceptosFactura','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_ConceptosFactura;

GO

/*
** Crear tablas
*/
-- Tablas de dimensiones
CREATE TABLE GROUP_BY_PROMOCION.BI_Tiempos (
    btie_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    btie_anio DECIMAL(4) NOT NULL,
    btie_cuatrimestre DECIMAL(1) NOT NULL CHECK (btie_cuatrimestre BETWEEN 1 AND 4),
    btie_mes DECIMAL(2) NOT NULL CHECK (btie_mes BETWEEN 1 AND 12),
);
CREATE TABLE GROUP_BY_PROMOCION.BI_Rubros (
    brub_subrubro DECIMAL(18) PRIMARY KEY,
    brub_rubro DECIMAL(18) NOT NULL,
    brub_subrubro_detalle NVARCHAR(50) NOT NULL,
    brub_rubro_detalle NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.BI_Marcas (
    bmar_codigo DECIMAL(18) PRIMARY KEY,
    bmar_detalle NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.BI_Ubicaciones (
    bubi_localidad DECIMAL(18) PRIMARY KEY,
    bubi_provincia DECIMAL(18) NOT NULL,
    bubi_localidad_detalle NVARCHAR(50) NOT NULL,
    bubi_provincia_detalle NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.BI_RangosHorariosVentas (
    brhv_codigo DECIMAL(18) PRIMARY KEY,
    brhv_hora_inicio TIME(0) NOT NULL,
    brhv_hora_fin TIME(0) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.BI_RangosEtariosClientes (
    brec_codigo DECIMAL(18) PRIMARY KEY,
    brec_minimo DECIMAL(4) NOT NULL,
    brec_maximo DECIMAL(4) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.BI_TiposMedioDePago (
    btmd_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    btmd_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.BI_ConceptosFactura (
    bcfa_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    bcfa_detalle NVARCHAR(50) NOT NULL
);


-- Tablas de hechos
CREATE TABLE GROUP_BY_PROMOCION.BI_Publicaciones (
    bpub_rubro DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Rubros,
    bpub_tiempo DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Tiempos,
    bpub_marca DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Marcas,

    bpub_tiempo_vigente_total BIGINT NOT NULL,
    bpub_cantidad DECIMAL(18) NOT NULL,
    bpub_stock_total DECIMAL(18) NOT NULL,

    PRIMARY KEY (bpub_rubro, bpub_tiempo, bpub_marca)
);

CREATE TABLE GROUP_BY_PROMOCION.BI_Ventas (
    bven_rubro DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Rubros,
    bven_tiempo DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Tiempos,
    bven_rango_etario DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_RangosEtariosClientes,
    bven_rango_horario DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_RangosHorariosVentas,
    bven_ubicacion_almacen DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Ubicaciones,
    bven_ubicacion_cliente DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Ubicaciones,
    bven_tipo_medio_de_pago DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_TiposMedioDePago,

    bven_monto DECIMAL(18, 2) NOT NULL,
    bven_cantidad DECIMAL(18) NOT NULL,

    PRIMARY KEY (
        bven_rubro,
        bven_tiempo,
        bven_rango_etario,
        bven_rango_horario,
        bven_ubicacion_almacen,
        bven_ubicacion_cliente,
        bven_tipo_medio_de_pago
    )
);

CREATE TABLE GROUP_BY_PROMOCION.BI_Facturas (
    bfac_tiempo DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Tiempos,
    bfac_concepto DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_ConceptosFactura,
    bfac_ubicacion_vendedor DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Ubicaciones,

    bfac_monto DECIMAL(18, 2) NOT NULL,
    bfac_cantidad DECIMAL(18) NOT NULL,

    PRIMARY KEY (bfac_tiempo, bfac_concepto, bfac_ubicacion_vendedor)
);

CREATE TABLE GROUP_BY_PROMOCION.BI_Envios (
    benv_tiempo DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Tiempos,
    benv_ubicacion_almacen DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Ubicaciones,
    benv_ubicacion_cliente DECIMAL(18) FOREIGN KEY REFERENCES GROUP_BY_PROMOCION.BI_Ubicaciones,

    benv_cantidad_total DECIMAL(18) NOT NULL,
    benv_cantidad_cumplidos DECIMAL(18) NOT NULL,

    PRIMARY KEY (benv_tiempo, benv_ubicacion_almacen, benv_ubicacion_cliente)
);
