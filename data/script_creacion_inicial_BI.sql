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

-- Eliminar 
IF OBJECT_ID('GROUP_BY_PROMOCION.cuatrimestre') IS NOT NULL
  DROP FUNCTION GROUP_BY_PROMOCION.cuatrimestre;
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
    brhv_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    brhv_hora_inicio TIME(0) NOT NULL,
    brhv_hora_fin TIME(0) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.BI_RangosEtariosClientes (
    brec_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    brec_minimo DECIMAL(4) NOT NULL,
    brec_maximo DECIMAL(4) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.BI_TiposMedioDePago (
    btmd_codigo DECIMAL(18) PRIMARY KEY,
    btmd_descripcion NVARCHAR(50) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.BI_ConceptosFactura (
    bcfa_codigo DECIMAL(18) PRIMARY KEY,
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
GO

/*
** Funciones
*/

CREATE FUNCTION GROUP_BY_PROMOCION.cuatrimestre(@fecha DATETIME) 
RETURNS DECIMAL(1)
AS
BEGIN
    RETURN (SELECT CASE
        WHEN month(@fecha) BETWEEN 1 AND 4 THEN 1
        WHEN month(@fecha) BETWEEN 5 AND 8 THEN 2
        ELSE 3
        END)
END
GO

/*
** Insertar Dimensiones
*/

INSERT INTO GROUP_BY_PROMOCION.BI_Tiempos (btie_anio, btie_cuatrimestre, btie_mes)
    SELECT DISTINCT
        year(vent_fecha),
        GROUP_BY_PROMOCION.cuatrimestre(vent_fecha),
        month(vent_fecha)
    FROM GROUP_BY_PROMOCION.Ventas
    UNION
    SELECT DISTINCT
        year(publ_fecha_inicio),
        GROUP_BY_PROMOCION.cuatrimestre(publ_fecha_inicio),
        month(publ_fecha_inicio)
    FROM GROUP_BY_PROMOCION.Publicaciones
    UNION
    SELECT DISTINCT
        year(fact_fecha),
        GROUP_BY_PROMOCION.cuatrimestre(fact_fecha),
        month(fact_fecha)
    FROM GROUP_BY_PROMOCION.Facturas
    ORDER BY 1 ASC, 3 ASC

INSERT INTO GROUP_BY_PROMOCION.BI_Rubros (brub_subrubro, brub_rubro, brub_subrubro_detalle, brub_rubro_detalle)
    SELECT DISTINCT subr_codigo, rubr_codigo, subr_descripcion, rubr_descripcion
    FROM GROUP_BY_PROMOCION.SubRubros
    JOIN GROUP_BY_PROMOCION.Rubros ON subr_rubro=rubr_codigo

INSERT INTO GROUP_BY_PROMOCION.BI_Marcas (bmar_codigo, bmar_detalle)
    SELECT DISTINCT marc_codigo, marc_descripcion
    FROM GROUP_BY_PROMOCION.Marcas

INSERT INTO GROUP_BY_PROMOCION.BI_Ubicaciones (bubi_localidad, bubi_provincia, bubi_localidad_detalle, bubi_provincia_detalle)
    SELECT DISTINCT loca_codigo, loca_provincia, loca_descripcion, prov_descripcion
    FROM GROUP_BY_PROMOCION.Localidades
    JOIN GROUP_BY_PROMOCION.Provincias ON loca_provincia=prov_codigo

INSERT INTO GROUP_BY_PROMOCION.BI_RangosHorariosVentas (brhv_hora_inicio, brhv_hora_fin)
VALUES ('00:00','06:00'), ('06:00','12:00'), ('12:00','18:00'), ('18:00','23:59:59')

INSERT INTO GROUP_BY_PROMOCION.BI_RangosEtariosClientes (brec_minimo, brec_maximo)
VALUES (0, 24), (25, 34), (35, 50), (50, 999)

INSERT INTO GROUP_BY_PROMOCION.BI_TiposMedioDePago (btmd_codigo, btmd_descripcion)
    SELECT DISTINCT tmdp_codigo, tmdp_descripcion
    FROM GROUP_BY_PROMOCION.TiposMedioDePago

INSERT INTO GROUP_BY_PROMOCION.BI_ConceptosFactura (bcfa_codigo, bcfa_detalle)
    SELECT DISTINCT tdfa_codigo, tdfa_descripcion
    FROM GROUP_BY_PROMOCION.TiposDetalleFactura

/*
** Insertar hechos
*/

INSERT INTO GROUP_BY_PROMOCION.BI_Publicaciones (bpub_rubro, bpub_tiempo, bpub_marca, bpub_tiempo_vigente_total, bpub_cantidad, bpub_stock_total)
    SELECT 
        brub_subrubro,
        btie_codigo,
        bmar_codigo,
        sum(DATEDIFF(DAY, publ_fecha_inicio, publ_fecha_cierre)),
        count(*),
        sum(publ_stock)
    FROM GROUP_BY_PROMOCION.Publicaciones
    JOIN GROUP_BY_PROMOCION.Productos ON prod_id=publ_producto
    JOIN GROUP_BY_PROMOCION.BI_Rubros ON prod_sub_rubro=brub_subrubro
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON year(publ_fecha_inicio)=btie_anio AND month(publ_fecha_inicio)=btie_mes
    JOIN GROUP_BY_PROMOCION.BI_Marcas ON prod_marca=bmar_codigo
    GROUP BY brub_subrubro, btie_codigo, bmar_codigo

INSERT INTO GROUP_BY_PROMOCION.BI_Ventas
    SELECT
        brub_subrubro,
        btie_codigo,
        brec_codigo,
        brhv_codigo,
        ualmacen.bubi_localidad,
        ucliente.bubi_localidad,
        btmd_codigo,
        sum(vent_total),
        count(distinct vent_codigo)
    FROM GROUP_BY_PROMOCION.Ventas
    JOIN GROUP_BY_PROMOCION.DetallesVenta ON vent_codigo=dven_venta
    JOIN GROUP_BY_PROMOCION.Publicaciones ON dven_publicacion=publ_codigo
    JOIN GROUP_BY_PROMOCION.Productos ON publ_producto=prod_id
    JOIN GROUP_BY_PROMOCION.BI_Rubros ON prod_sub_rubro=brub_subrubro
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON year(vent_fecha)=btie_anio AND month(vent_fecha)=btie_mes
    JOIN GROUP_BY_PROMOCION.Clientes ON vent_cliente=clie_codigo
    JOIN GROUP_BY_PROMOCION.BI_RangosEtariosClientes ON
        DATEDIFF(YEAR, clie_fecha_nac, GETDATE()) BETWEEN brec_minimo AND brec_maximo
    JOIN GROUP_BY_PROMOCION.BI_RangosHorariosVentas ON
        CAST(vent_fecha AS TIME) BETWEEN brhv_hora_inicio AND brhv_hora_fin
    JOIN GROUP_BY_PROMOCION.Almacenes ON publ_almacen=alma_codigo
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ualmacen ON alma_localidad=ualmacen.bubi_localidad
    JOIN GROUP_BY_PROMOCION.Envios ON vent_codigo=envi_venta
    JOIN GROUP_BY_PROMOCION.Domicilios ON envi_domicilio=domi_codigo
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ucliente ON domi_localidad=ucliente.bubi_localidad
    JOIN GROUP_BY_PROMOCION.Pagos ON pago_venta=vent_codigo
    JOIN GROUP_BY_PROMOCION.MediosDePago ON pago_medio_de_pago=mpag_codigo
    JOIN GROUP_BY_PROMOCION.BI_TiposMedioDePago ON btmd_codigo=mpag_tipo
    GROUP BY brub_subrubro, btie_codigo, brec_codigo, brhv_codigo, ualmacen.bubi_localidad, ucliente.bubi_localidad, btmd_codigo