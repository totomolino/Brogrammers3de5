SELECT MATERIAL_COD,MATERIAL_DESCRIPCION,MATERIAL_PRECIO from gd_esquema.Maestra 
where MATERIAL_COD <> 'null'
group by MATERIAL_COD,MATERIAL_DESCRIPCION, MATERIAL_PRECIO
order by MATERIAL_DESCRIPCION


select TAREA_CODIGO, TAREA_DESCRIPCION, TAREA_FECHA_FIN, TAREA_FECHA_INICIO,TAREA_FECHA_INICIO_PLANIFICADO,TAREA_TIEMPO_ESTIMADO,TIPO_TAREA, count(material_cod)
from gd_esquema.Maestra where TAREA_DESCRIPCION <> 'null'
group by TAREA_CODIGO, TAREA_DESCRIPCION, TAREA_FECHA_FIN, TAREA_FECHA_INICIO,TAREA_FECHA_INICIO_PLANIFICADO,TAREA_TIEMPO_ESTIMADO,TIPO_TAREA
order by TAREA_CODIGO


SELECT TAREA_CODIGO,MATERIAL_COD,MATERIAL_DESCRIPCION, COUNT(MATERIAL_COD) / (select count(distinct convert(varchar,TAREA_FECHA_FIN)+convert(varchar, TAREA_FECHA_INICIO)+convert(varchar, TAREA_FECHA_INICIO_PLANIFICADO)+str(TAREA_TIEMPO_ESTIMADO)+ CAMION_PATENTE)
FROM gd_esquema.Maestra
WHERE TAREA_CODIGO= G1.TAREA_CODIGO)
FROM gd_esquema.Maestra G1 where TAREA_DESCRIPCION <> 'null'
group by  TAREA_CODIGO,MATERIAL_COD,MATERIAL_DESCRIPCION
order by TAREA_CODIGO


select count(distinct convert(varchar,G1.TAREA_FECHA_FIN)+convert(varchar, G1.TAREA_FECHA_INICIO)+convert(varchar, G1.TAREA_FECHA_INICIO_PLANIFICADO)+str(G1.TAREA_TIEMPO_ESTIMADO))
FROM gd_esquema.Maestra G1
WHERE 1= G1.TAREA_CODIGO
GROUP BY TAREA_CODIGO

SELECT TAREA_CODIGO,MATERIAL_COD, COUNT(MATERIAL_COD) / (select count(distinct otxt_id)
FROM brog.OtXtarea
WHERE otxt_tarea = G1.TAREA_CODIGO)
FROM gd_esquema.Maestra g1 where TAREA_DESCRIPCION <> 'null'
group by  TAREA_CODIGO,MATERIAL_COD
order by TAREA_CODIGO

select * from brog.Tarea



select tare_id, count(MATERIAL_COD) 
from gd_esquema.Maestra 
join brog.Tarea on TAREA_DESCRIPCION = tare_desc
--join brog.Materiales on MATERIAL_DESCRIPCION = mate_descripcion
where MATERIAL_COD <> 'null'
group by tare_id

select TAREA_CODIGO ,TAREA_DESCRIPCION,TIPO_TAREA,TAREA_TIEMPO_ESTIMADO, MATERIAL_COD from gd_esquema.Maestra where tipo_tarea <> 'null'
order by TAREA_DESCRIPCION


select TAREA_CODIGO ,TAREA_DESCRIPCION,TIPO_TAREA,TAREA_TIEMPO_ESTIMADO, COUNT(MATERIAL_COD)
from gd_esquema.Maestra 
join brog.Camion on CAMION_PATENTE = cami_patente
join brog.Orden_trabajo on cami_id = ot_camion
join brog.OtXtarea on (otxt_orden_trabajo = ot_id)
where TAREA_CODIGO = 1
group by ot_id, TAREA_CODIGO ,TAREA_DESCRIPCION,TIPO_TAREA,TAREA_TIEMPO_ESTIMADO, MATERIAL_COD 
order by TAREA_DESCRIPCION

select TAREA_CODIGO, TAREA_FECHA_INICIO_PLANIFICADO, TAREA_FECHA_INICIO, TAREA_FECHA_FIN,COUNT(MATERIAL_COD), CAMION_PATENTE
from gd_esquema.Maestra 
where MATERIAL_COD <> 'null'  AND CAMION_PATENTE = '03W274PV76YDU76O2762SN' AND TAREA_FECHA_INICIO = '2019-01-09 00:00:00.000' AND TAREA_FECHA_FIN = '2019-01-11 00:00:00.000'
group by TAREA_CODIGO,TAREA_FECHA_INICIO_PLANIFICADO, TAREA_FECHA_INICIO, TAREA_FECHA_FIN, MECANICO_NRO_LEGAJO, CAMION_PATENTE, MATERIAL_COD, MATERIAL_DESCRIPCION, MATERIAL_PRECIO
ORDER BY CAMION_PATENTE

select distinct TAREA_CODIGO, TAREA_DESCRIPCION,TIPO_TAREA,TAREA_TIEMPO_ESTIMADO,COUNT(MATERIAL_COD)
from gd_esquema.Maestra 
where MATERIAL_COD <> 'null'  AND CAMION_PATENTE = '03W274PV76YDU76O2762SN'
group by TAREA_CODIGO, TAREA_DESCRIPCION,TIPO_TAREA,TAREA_TIEMPO_ESTIMADO, MATERIAL_COD, ORDEN_TRABAJO_ESTADO, TAREA_FECHA_INICIO_PLANIFICADO, TAREA_FECHA_INICIO, TAREA_FECHA_FIN 
ORDER BY TAREA_DESCRIPCION

select distinct TAREA_CODIGO, TAREA_DESCRIPCION,TIPO_TAREA,TAREA_TIEMPO_ESTIMADO,COUNT(MATERIAL_COD)
from gd_esquema.Maestra 
join brog.Camion on CAMION_PATENTE = cami_patente
join brog.Orden_trabajo on cami_id = ot_camion
join brog.OtXtarea on (otxt_orden_trabajo = ot_id)
where MATERIAL_COD <> 'null'
group by TAREA_CODIGO, TAREA_DESCRIPCION,TIPO_TAREA,TAREA_TIEMPO_ESTIMADO, otxt_id
ORDER BY TAREA_DESCRIPCION

select * from gd_esquema.Maestra where tipo_tarea <> 'null'
order by TAREA_CODIGO

select * from brog.OtXtarea
--ORDER BY 
select MATERIAL_COD, MATERIAL_DESCRIPCION from gd_esquema.Maestra 
where ORDEN_TRABAJO_ESTADO <> 'null'
and tarea_codigo = 1
group by TAREA_FECHA_FIN, TAREA_FECHA_INICIO,TAREA_FECHA_INICIO_PLANIFICADO,TAREA_TIEMPO_ESTIMADO, MATERIAL_COD, MATERIAL_DESCRIPCION
--group by MATERIAL_COD, MATERIAL_DESCRIPCION

-- pruebas paquete x viaje

select viaj_id, tipa_id, tipa_descripcion, sum(PAQUETE_CANTIDAD)
from gd_esquema.Maestra 
join brog.Camion on CAMION_PATENTE = cami_patente
join brog.Viaje on (VIAJE_FECHA_INICIO = viaj_fecha_inicio and VIAJE_FECHA_FIN = viaj_fecha_fin and viaj_camion = cami_id and CHOFER_NRO_LEGAJO = viaj_chof)
join brog.Tipo_paquete on PAQUETE_DESCRIPCION = tipa_descripcion
group by viaj_id, tipa_id, tipa_descripcion
order by viaj_id, tipa_id

select * from brog.Viaje


select DISTINCT VIAJE_FECHA_INICIO, VIAJE_FECHA_FIN, VIAJE_CONSUMO_COMBUSTIBLE, CHOFER_NRO_LEGAJO, CAMION_PATENTE from gd_esquema.Maestra where CHOFER_NRO_LEGAJO = '110271' and VIAJE_FECHA_INICIO = '2019-12-24 00:00:00.0000000' and VIAJE_FECHA_FIN = '2019-12-25 00:00:00.000'
order by VIAJE_FECHA_INICIO

select VIAJE_FECHA_INICIO, VIAJE_FECHA_FIN, VIAJE_CONSUMO_COMBUSTIBLE, CHOFER_NRO_LEGAJO, CAMION_PATENTE from gd_esquema.Maestra where CHOFER_NRO_LEGAJO = '110271' and VIAJE_FECHA_INICIO = '2019-12-24 00:00:00.0000000' and VIAJE_FECHA_FIN = '2019-12-25 00:00:00.000'
group by VIAJE_FECHA_INICIO, VIAJE_FECHA_FIN, VIAJE_CONSUMO_COMBUSTIBLE, CHOFER_NRO_LEGAJO, CAMION_PATENTE 
order by VIAJE_FECHA_INICIO

select distinct VIAJE_FECHA_INICIO,VIAJE_FECHA_FIN,VIAJE_CONSUMO_COMBUSTIBLE, cami_id, CHOFER_NRO_LEGAJO, reco_id
from gd_esquema.Maestra
join brog.Camion on CAMION_PATENTE = cami_patente
join brog.Recorrido on (RECORRIDO_CIUDAD_DESTINO = reco_ciudad_dest and RECORRIDO_CIUDAD_ORIGEN = reco_ciudad_origen ) -- puse todos xq es posible que se repitan y matchee con cualquiera)
where VIAJE_FECHA_INICIO IS NOT NULL and CHOFER_NRO_LEGAJO = '110271' and VIAJE_FECHA_INICIO = '2019-12-24 00:00:00.0000000' and VIAJE_FECHA_FIN = '2019-12-25 00:00:00.000'


select * from gd_esquema.Maestra

select paqx_viaje, tipa_descripcion, paqx_cantidad
from brog.PaquetexViaje join brog.Tipo_paquete on paqx_tipo = tipa_id
order by paqx_viaje