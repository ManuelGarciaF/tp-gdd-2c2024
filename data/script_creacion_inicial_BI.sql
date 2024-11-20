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
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_TiposEnvio','U') IS NOT NULL
    DROP TABLE GROUP_BY_PROMOCION.BI_TiposEnvio;
GO

-- Eliminar funciones
IF OBJECT_ID('GROUP_BY_PROMOCION.cuatrimestre') IS NOT NULL
  DROP FUNCTION GROUP_BY_PROMOCION.cuatrimestre;
GO

-- Eliminar vistas
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_PromedioDeTiempoDePublicaciones') IS NOT NULL
    DROP VIEW GROUP_BY_PROMOCION.BI_PromedioDeTiempoDePublicaciones;
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_PromedioDeStockInicial ') IS NOT NULL
    DROP VIEW GROUP_BY_PROMOCION.BI_PromedioDeStockInicial
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_VentaPromedioMensual') IS NOT NULL
    DROP VIEW GROUP_BY_PROMOCION.BI_VentaPromedioMensual
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_RendimientoDeRubros') IS NOT NULL
    DROP VIEW GROUP_BY_PROMOCION.BI_RendimientoDeRubros
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_VolumenDeVentas') IS NOT NULL
    DROP VIEW GROUP_BY_PROMOCION.BI_VolumenDeVentas
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_PagoEnCuotas') IS NOT NULL
    DROP VIEW GROUP_BY_PROMOCION.BI_PagoEnCuotas
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_PorcentajeCumplimientoDeEnvios') IS NOT NULL
    DROP VIEW GROUP_BY_PROMOCION.BI_PorcentajeCumplimientoDeEnvios
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_LocalidadesConMayorCostoDeEnvio') IS NOT NULL
    DROP VIEW GROUP_BY_PROMOCION.BI_LocalidadesConMayorCostoDeEnvio
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_PorcentajeFacturacionPorConcepto') IS NOT NULL
    DROP VIEW GROUP_BY_PROMOCION.BI_PorcentajeFacturacionPorConcepto
IF OBJECT_ID('GROUP_BY_PROMOCION.BI_FacturacionPorProvincia') IS NOT NULL
    DROP VIEW GROUP_BY_PROMOCION.BI_FacturacionPorProvincia


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
    btmd_codigo DECIMAL(18) IDENTITY(1, 1) PRIMARY KEY,
    btmd_tipo_medio_de_pago DECIMAL(18) NOT NULL,
    btmd_descripcion NVARCHAR(50) NOT NULL,
    btmd_cuotas DECIMAL(18) NOT NULL
);
CREATE TABLE GROUP_BY_PROMOCION.BI_ConceptosFactura (
    bcfa_codigo DECIMAL(18) PRIMARY KEY,
    bcfa_detalle NVARCHAR(50) NOT NULL
);

CREATE TABLE GROUP_BY_PROMOCION.BI_TiposEnvio (
    btde_codigo DECIMAL(18) PRIMARY KEY,
    btde_descripcion NVARCHAR(50) NOT NULL
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
    benv_monto DECIMAL(18, 2) NOT NULL,

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
    UNION
    SELECT DISTINCT
        year(envi_fecha_entrega),
        GROUP_BY_PROMOCION.cuatrimestre(envi_fecha_entrega),
        month(envi_fecha_entrega)
    FROM GROUP_BY_PROMOCION.Envios
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
VALUES (0, 24), (25, 34), (35, 50), (51, 999)

INSERT INTO GROUP_BY_PROMOCION.BI_TiposMedioDePago (btmd_tipo_medio_de_pago, btmd_descripcion, btmd_cuotas)
    SELECT DISTINCT 
        tmdp_codigo,
        tmdp_descripcion,
        isnull(dpag_cant_cuotas, 1)
    FROM GROUP_BY_PROMOCION.TiposMedioDePago
    LEFT JOIN GROUP_BY_PROMOCION.MediosDePago ON mpag_tipo=tmdp_codigo
    LEFT JOIN GROUP_BY_PROMOCION.Pagos ON pago_medio_de_pago=mpag_codigo
    LEFT JOIN GROUP_BY_PROMOCION.DetallesPago ON dpag_pago=pago_codigo

INSERT INTO GROUP_BY_PROMOCION.BI_ConceptosFactura (bcfa_codigo, bcfa_detalle)
    SELECT DISTINCT tdfa_codigo, tdfa_descripcion
    FROM GROUP_BY_PROMOCION.TiposDetalleFactura

INSERT INTO GROUP_BY_PROMOCION.BI_TiposEnvio (btde_codigo, btde_descripcion)
    SELECT DISTINCT tden_codigo, tden_descripcion
    FROM GROUP_BY_PROMOCION.TiposEnvio
GO

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
GO

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
    JOIN GROUP_BY_PROMOCION.BI_RangosHorariosVentas ON -- Originalmente las ventas tienen su hora como date en la tabla maestra
        CAST(vent_fecha AS TIME) BETWEEN brhv_hora_inicio AND brhv_hora_fin
    JOIN GROUP_BY_PROMOCION.Almacenes ON publ_almacen=alma_codigo
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ualmacen ON alma_localidad=ualmacen.bubi_localidad
    JOIN GROUP_BY_PROMOCION.Envios ON vent_codigo=envi_venta
    JOIN GROUP_BY_PROMOCION.Domicilios ON envi_domicilio=domi_codigo
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ucliente ON domi_localidad=ucliente.bubi_localidad
    JOIN GROUP_BY_PROMOCION.Pagos ON pago_venta=vent_codigo
    JOIN GROUP_BY_PROMOCION.MediosDePago ON pago_medio_de_pago=mpag_codigo
    LEFT JOIN GROUP_BY_PROMOCION.DetallesPago ON dpag_pago=pago_codigo
    JOIN GROUP_BY_PROMOCION.BI_TiposMedioDePago ON btmd_tipo_medio_de_pago=mpag_tipo 
        AND isnull(dpag_cant_cuotas, 1)=btmd_cuotas
    GROUP BY brub_subrubro, btie_codigo, brec_codigo, brhv_codigo, ualmacen.bubi_localidad, ucliente.bubi_localidad, btmd_codigo
GO

INSERT INTO GROUP_BY_PROMOCION.BI_Facturas
    SELECT
        btie_codigo,
        bcfa_codigo,
        bubi_localidad,
        sum(dfac_subtotal),
        count(*)
    FROM GROUP_BY_PROMOCION.Facturas
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON year(fact_fecha)=btie_anio AND month(fact_fecha)=btie_mes
    JOIN GROUP_BY_PROMOCION.DetallesFactura ON dfac_factura=fact_numero
    JOIN GROUP_BY_PROMOCION.BI_ConceptosFactura ON bcfa_codigo=dfac_tipo
    JOIN GROUP_BY_PROMOCION.Vendedores ON vend_codigo=fact_vendedor
    JOIN GROUP_BY_PROMOCION.Domicilios ON vend_usuario=domi_usuario
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ON domi_localidad=bubi_localidad
    GROUP BY btie_codigo, bcfa_codigo, bubi_localidad
GO


INSERT INTO GROUP_BY_PROMOCION.BI_Envios
    SELECT
        btie_codigo,
        ualmacen.bubi_localidad,
        ucliente.bubi_localidad,
        count(*),
        sum(CASE
            WHEN CONVERT(date, envi_fecha_entrega) = envi_fecha_programada
                AND DATEPART(HOUR, envi_fecha_entrega) BETWEEN envi_hora_inicio AND envi_hora_fin
            THEN 1
            ELSE 0
        END),
        sum(envi_costo)
    FROM GROUP_BY_PROMOCION.Envios
    JOIN GROUP_BY_PROMOCION.Ventas ON vent_codigo=envi_venta
    JOIN GROUP_BY_PROMOCION.DetallesVenta ON dven_venta=vent_codigo
    JOIN GROUP_BY_PROMOCION.Publicaciones ON publ_codigo=dven_publicacion
    JOIN GROUP_BY_PROMOCION.Almacenes ON alma_codigo=publ_almacen
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ualmacen ON ualmacen.bubi_localidad=alma_localidad
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ucliente ON ucliente.bubi_localidad=envi_domicilio
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON year(envi_fecha_entrega)=btie_anio AND month(envi_fecha_entrega)=btie_mes
    GROUP BY ualmacen.bubi_localidad, ucliente.bubi_localidad, btie_codigo
GO

/*
** Vistas
*/
-- Vista 1
CREATE VIEW GROUP_BY_PROMOCION.BI_PromedioDeTiempoDePublicaciones (anio, cuatrimestre, subrubro_detalle, rubro_detalle, horas_vigente_promedio)
AS
    SELECT 
        btie_anio,
        btie_cuatrimestre,
        brub_subrubro_detalle,
        brub_rubro_detalle,
        CONVERT(DECIMAL(10,2), sum(bpub_tiempo_vigente_total) / sum(bpub_cantidad))
    FROM GROUP_BY_PROMOCION.BI_Publicaciones 
    JOIN GROUP_BY_PROMOCION.BI_Rubros ON bpub_rubro=brub_subrubro
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON bpub_tiempo=btie_codigo
    GROUP BY btie_anio, btie_cuatrimestre, brub_rubro_detalle, brub_subrubro_detalle
GO

-- Vista 2
CREATE VIEW GROUP_BY_PROMOCION.BI_PromedioDeStockInicial (anio, marca, promedio_stock_inicial)
AS
    SELECT 
        btie_anio,
        bmar_detalle,
        CONVERT(DECIMAL(10,2), sum(bpub_stock_total) / sum(bpub_cantidad))
    FROM GROUP_BY_PROMOCION.BI_Publicaciones 
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON bpub_tiempo=btie_codigo
    JOIN GROUP_BY_PROMOCION.BI_Marcas ON bmar_codigo=bpub_marca
    GROUP BY btie_anio, bmar_detalle
GO

-- Vista 3
CREATE VIEW GROUP_BY_PROMOCION.BI_VentaPromedioMensual (anio, mes, provincia, detalle_provincia, venta_promedio)
AS
    SELECT 
        btie_anio,
        btie_mes,
        bubi_provincia,
        bubi_provincia_detalle,
        CONVERT(DECIMAL(10,2), sum(bven_monto) / sum(bven_cantidad))
    FROM GROUP_BY_PROMOCION.BI_Ventas
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON bven_tiempo=btie_codigo
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ON bven_ubicacion_almacen=bubi_localidad
    GROUP BY btie_anio, btie_mes, bubi_provincia_detalle, bubi_provincia
GO

-- Vista 4
CREATE VIEW GROUP_BY_PROMOCION.BI_RendimientoDeRubros (anio, cuatrimestre, localidad, localidad_detalle, edad_minima, edad_maxima, rubro, rubro_detalle, monto_vendido)
AS
    SELECT 
        btie_anio,
        btie_cuatrimestre,
        bubi_localidad,
        bubi_localidad_detalle,
        brec_minimo,
        brec_maximo,
        brub_rubro,
        brub_rubro_detalle,
        sum(bven_monto)
    FROM GROUP_BY_PROMOCION.BI_Ventas
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON bven_tiempo=btie_codigo
    JOIN GROUP_BY_PROMOCION.BI_Rubros ON brub_subrubro=bven_rubro
    JOIN GROUP_BY_PROMOCION.BI_RangosEtariosClientes ON brec_codigo=bven_rango_etario
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ON bubi_localidad=bven_ubicacion_cliente
    GROUP BY 
        btie_anio,
        btie_cuatrimestre,
        bubi_localidad,
        bubi_localidad_detalle,
        brec_minimo,
        brec_maximo,
        brub_rubro,
        brub_rubro_detalle
GO

/* Se usaria:
SELECT TOP 3 localidad, localidad_detalle, monto_vendido FROM GROUP_BY_PROMOCION.BI_PagoEnCuotas WHERE tipo_medio_de_pago='Tarjeta Debito' AND anio=2025 AND mes=1
ORDER BY monto_vendido DESC
GO
*/

-- Vista 5
CREATE VIEW GROUP_BY_PROMOCION.BI_VolumenDeVentas (anio, mes, hora_inicio, hora_fin, candidad_de_ventas)
AS
    SELECT 
        btie_anio,
        btie_mes,
        brhv_hora_inicio,
        brhv_hora_fin,
        sum(bven_cantidad)
    FROM GROUP_BY_PROMOCION.BI_Ventas
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON bven_tiempo=btie_codigo
    JOIN GROUP_BY_PROMOCION.BI_RangosHorariosVentas ON bven_rango_horario=brhv_codigo
    GROUP BY btie_anio, btie_mes, brhv_hora_inicio, brhv_hora_fin
GO

-- Vista 6
CREATE VIEW GROUP_BY_PROMOCION.BI_PagoEnCuotas (localidad, localidad_detalle, anio, mes, tipo_medio_de_pago, monto_vendido)
AS
    SELECT 
        bubi_localidad,
        bubi_localidad_detalle,
        btie_anio,
        btie_mes,
        btmd_descripcion,
        sum(bven_monto)
    FROM GROUP_BY_PROMOCION.BI_Ventas
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON bven_tiempo=btie_codigo
    JOIN GROUP_BY_PROMOCION.BI_TiposMedioDePago ON btmd_codigo=bven_tipo_medio_de_pago
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ON bven_ubicacion_cliente=bubi_localidad
    WHERE btmd_cuotas > 1
    GROUP BY btie_anio, btie_mes, btmd_tipo_medio_de_pago, btmd_descripcion, bubi_localidad, bubi_localidad_detalle
GO

/* Se usaria:
SELECT TOP 3 localidad, localidad_detalle, monto_vendido FROM GROUP_BY_PROMOCION.BI_PagoEnCuotas WHERE tipo_medio_de_pago='Tarjeta Debito' AND anio=2025 AND mes=1
ORDER BY monto_vendido DESC
GO
*/

-- Vista 7
CREATE VIEW GROUP_BY_PROMOCION.BI_PorcentajeCumplimientoDeEnvios (provincia, provincia_detalle, anio, mes, porcentaje_cumplidos)
AS
    SELECT 
        bubi_provincia,
        bubi_provincia_detalle,
        btie_anio,
        btie_mes,
        CONVERT(DECIMAL(10, 2), sum(benv_cantidad_cumplidos) / sum(benv_cantidad_total))
    FROM GROUP_BY_PROMOCION.BI_Envios
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON benv_tiempo=btie_codigo
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ON benv_ubicacion_almacen=bubi_localidad
    GROUP BY btie_anio, btie_mes, bubi_provincia, bubi_provincia_detalle
GO

-- Vista 8
CREATE VIEW GROUP_BY_PROMOCION.BI_LocalidadesConMayorCostoDeEnvio (localidad, localidad_detalle, costo_total_envio)
AS
    SELECT TOP 5
        bubi_localidad,
        bubi_localidad_detalle,
        CONVERT(DECIMAL(10, 2), sum(benv_monto))
    FROM GROUP_BY_PROMOCION.BI_Envios
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ON benv_ubicacion_cliente=bubi_localidad
    GROUP BY bubi_localidad, bubi_localidad_detalle
    ORDER BY 3 DESC
GO

-- Vista 9
CREATE VIEW GROUP_BY_PROMOCION.BI_PorcentajeFacturacionPorConcepto (anio, mes, detalle, porcentaje_del_monto_total)
AS
    SELECT
        btie_anio,
        btie_mes,
        bcfa_detalle,
        CONVERT(DECIMAL(10, 2), 
            sum(bfac_monto) / -- Monto total para ese periodo
            (SELECT sum(f2.bfac_monto) FROM GROUP_BY_PROMOCION.BI_Facturas f2
                JOIN GROUP_BY_PROMOCION.BI_Tiempos t2 ON t2.btie_codigo=f2.bfac_tiempo
                WHERE t2.btie_anio=t1.btie_anio AND t2.btie_mes=t1.btie_mes)
        )
    FROM GROUP_BY_PROMOCION.BI_Facturas f1
    JOIN GROUP_BY_PROMOCION.BI_Tiempos t1 ON btie_codigo=bfac_tiempo
    JOIN GROUP_BY_PROMOCION.BI_ConceptosFactura ON bfac_concepto=bcfa_codigo
    GROUP BY btie_anio, btie_mes, bcfa_codigo, bcfa_detalle
GO

-- Vista 10
CREATE VIEW GROUP_BY_PROMOCION.BI_FacturacionPorProvincia (anio, cuatrimestre, provincia, provincia_detalle, monto_facturado)
AS
    SELECT
        btie_anio,
        btie_cuatrimestre,
        bubi_provincia,
        bubi_provincia_detalle,
        CONVERT(DECIMAL(10, 2), sum(bfac_monto))
    FROM GROUP_BY_PROMOCION.BI_Facturas
    JOIN GROUP_BY_PROMOCION.BI_Tiempos ON btie_codigo=bfac_tiempo
    JOIN GROUP_BY_PROMOCION.BI_Ubicaciones ON bubi_localidad=bfac_ubicacion_vendedor
    GROUP BY btie_anio, btie_cuatrimestre, bubi_provincia, bubi_provincia_detalle
GO