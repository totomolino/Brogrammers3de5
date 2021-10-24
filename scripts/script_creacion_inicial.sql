use GD2C2021
go


-- creamos el schema

IF(NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'brog'))
  BEGIN
      exec ('CREATE SCHEMA [brog]');
    END


--CREAMOS LAS TABLAS

IF OBJECT_ID ('brog.MaterialesXtarea', 'U') IS NOT NULL  
   DROP TABLE brog.MaterialesXtarea; 
GO
CREATE TABLE [brog].[MaterialesXtarea] (
  [mxt_material] nvarchar(100) NOT NULL,
  [mxt_tarea] int NOT NULL,
  [mxt_cantidad] int NOT NULL
)

IF OBJECT_ID ('brog.Viaje', 'U') IS NOT NULL  
   DROP TABLE brog.Viaje; 
GO
CREATE TABLE [brog].[Viaje] (
  [viaj_id] int identity(1,1),
  [viaj_fecha_inicio] datetime2(7) NOT NULL,
  [viaj_fecha_fin] datetime2(3) NOT NULL,
  [viaj_consumo_combustible] decimal(18,2) NOT NULL,
  [viaj_camion] int NOT NULL,
  [viaj_chof] int NOT NULL,
  [viaj_recorrido] int NOT NULL,
  CONSTRAINT PK_Viaje PRIMARY KEY ([viaj_id])
)

IF OBJECT_ID ('brog.PaquetexViaje', 'U') IS NOT NULL  
   DROP TABLE brog.PaquetexViaje; 
GO
CREATE TABLE [brog].[PaquetexViaje] (
  [paqx_viaje] int NOT NULL,
  [paqx_paquete] int NOT NULL,
  [paqx_cantidad] Int NOT NULL,
);

IF OBJECT_ID ('brog.OtXtarea', 'U') IS NOT NULL  
   DROP TABLE brog.OtXtarea; 
GO
CREATE TABLE [brog].[OtXtarea] (
  [otxt_estado_tarea] nvarchar(255) NOT NULL,
  [otxt_fecha_inicio_estimada] datetime2(3) NOT NULL,
  [otxt_fecha_inicio] datetime2(3) NOT NULL,
  [otxt_fecha_fin] datetime2(3) NOT NULL,
  [otxt_tiempo_real] int NOT NULL,
  [otxt_orden_trabajo] int NOT NULL,
  [otxt_tarea] int NOT NULL,
  [otxt_mecanico] int NOT NULL
)


IF OBJECT_ID ('brog.Orden_trabajo', 'U') IS NOT NULL  
   DROP TABLE brog.Orden_trabajo; 
GO
CREATE TABLE [brog].[Orden_trabajo] (
  [ot_id] int identity(1,1),
  [ot_camion] int NOT NULL,
  [ot_fecha_realizacion] nvarchar(255) NOT NULL,
  CONSTRAINT PK_Orden_trabajo PRIMARY KEY ([ot_id])
)

IF OBJECT_ID ('brog.Camion', 'U') IS NOT NULL  
   DROP TABLE brog.Camion; 
GO
CREATE TABLE [brog].[Camion] (
  [cami_id] int identity(1,1),
  [cami_patente] nvarchar(255) NOT NULL,
  [cami_nro_chasis] nvarchar(255) NOT NULL,
  [cami_nro_motor] nvarchar(255) NOT NULL,
  [cami_fecha_alta] datetime2(3) NOT NULL,
  [cami_modelo] int NOT NULL,
  CONSTRAINT PK_Camion PRIMARY KEY ([cami_id])
)

IF OBJECT_ID ('brog.Mecanico', 'U') IS NOT NULL  
   DROP TABLE brog.Mecanico; 
GO
CREATE TABLE [brog].[Mecanico] (
  [meca_legajo] int ,
  [meca_nombre] nvarchar(255) NOT NULL,
  [meca_apellido] nvarchar(255) NOT NULL,
  [meca_dni] decimal(18,0) NOT NULL,
  [meca_direccion] nvarchar(255) NOT NULL,
  [meca_telefono] int NOT NULL,
  [meca_mail] nvarchar(255) NOT NULL,
  [meca_fechaNac] datetime2(3) NOT NULL,
  [meca_costoHora] int NOT NULL,
  [meca_taller] int NOT NULL,
  CONSTRAINT PK_Mecanico PRIMARY KEY ([meca_legajo])
)




IF OBJECT_ID ('brog.Paquete', 'U') IS NOT NULL  
   DROP TABLE brog.Paquete; 
GO
CREATE TABLE [brog].[Paquete] (
  [paqu_id] int identity(1,1),
  [paqu_tipo] int NOT NULL,
  CONSTRAINT PK_Paquete PRIMARY KEY ([paqu_id])
)

IF OBJECT_ID ('brog.Materiales', 'U') IS NOT NULL  
   DROP TABLE brog.Materiales; 
GO

CREATE TABLE [brog].[Materiales] (
  [mate_id] nvarchar(100),
  [mate_descripcion] nvarchar(255) NOT NULL,
  [mate_precio] decimal(18,2) NOT NULL,
  CONSTRAINT PK_Materiales PRIMARY KEY ([mate_id])
)


IF OBJECT_ID ('brog.Tarea', 'U') IS NOT NULL  
   DROP TABLE brog.Tarea; 
GO
CREATE TABLE [brog].[Tarea] (
  [tare_id] int identity(1,1),
  [tare_desc] nvarchar(255) NOT NULL,
  [tare_tipo] nvarchar(255) NOT NULL,
  [tare_tiempo_estimado] int NOT NULL,
  CONSTRAINT PK_Tarea PRIMARY KEY ([tare_id])
)



IF OBJECT_ID ('brog.Taller', 'U') IS NOT NULL  
   DROP TABLE brog.Taller; 
GO
CREATE TABLE [brog].[Taller] (
  [tall_id] int identity(1,1),
  [tall_direccion] nvarchar(255) NOT NULL,
  [tall_telefono] decimal(18,0) NOT NULL,
  [tall_mail] nvarchar(255) NOT NULL,
  [tall_nombre] nvarchar(255) NOT NULL,
  [tall_ciudad] nvarchar(255) NOT NULL,
  CONSTRAINT PK_Taller PRIMARY KEY ([tall_id])
)

IF OBJECT_ID ('brog.Recorrido', 'U') IS NOT NULL  
   DROP TABLE brog.Recorrido; 
GO
CREATE TABLE [brog].[Recorrido] (
  [reco_id] int identity(1,1),
  [reco_ciudad_dest] nvarchar(255) NOT NULL,
  [reco_ciudad_origen] nvarchar(255) NOT NULL,
  [reco_precio] decimal(18,2) NOT NULL,
  [reco_km] int NOT NULL,
  CONSTRAINT PK_Recorrido PRIMARY KEY ([reco_id])
)


IF OBJECT_ID ('brog.Tipo_paquete', 'U') IS NOT NULL  
   DROP TABLE brog.Tipo_paquete; 
GO
CREATE TABLE [brog].[Tipo_paquete] (
  [tipa_id] int identity(1,1),
  [tipa_descripcion] nvarchar(255) NOT NULL,
  [tipa_peso_max] decimal(18,2) NOT NULL,
  [tipa_alto_max] decimal(18,2) NOT NULL,
  [tipa_ancho_max] decimal(18,2) NOT NULL,
  [tipa_largo_max] decimal(18,2) NOT NULL,
  [tipa_precio] decimal(18,2) NOT NULL,
  CONSTRAINT PK_Tipo_paquete PRIMARY KEY ([tipa_id])
)

IF OBJECT_ID ('brog.Chofer', 'U') IS NOT NULL  
   DROP TABLE brog.Chofer; 
GO
CREATE TABLE [brog].[Chofer] (
  [chof_legajo] int,
  [chof_nombre] nvarchar(255) NOT NULL,
  [chof_apellido] nvarchar(255) NOT NULL,
  [chof_direccion] nvarchar(255) NOT NULL,
  [chof_mail] nvarchar(255) NOT NULL,
  [chof_dni] decimal(18,0) NOT NULL,
  [chof_telefono] int NOT NULL,
  [chof_fecha_nac] datetime2(3) NOT NULL,
  [chof_costo_hora] int NOT NULL,
  CONSTRAINT PK_Chofer PRIMARY KEY ([chof_legajo])
)

IF OBJECT_ID ('brog.Modelo', 'U') IS NOT NULL  
   DROP TABLE brog.Modelo; 
GO
CREATE TABLE [brog].[Modelo] (
  [mode_id] int identity(1,1),
  [mode_nombre] nvarchar(255) NOT NULL,
  [mode_marca] nvarchar(255) NOT NULL,
  [mode_velocidad_max] int NOT NULL,
  [mode_capacidad_tanque] int NOT NULL,
  [mode_capacidad_carga] int NOT NULL,
  CONSTRAINT PK_Modelo PRIMARY KEY ([mode_id])
)

-----------------------------------------
-- PROCEDURES PARA MIGRACION


-- MIGRACION MATERIALES

IF OBJECT_ID ('brog.migracionMateriales', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionMateriales; 
GO
create procedure brog.migracionMateriales
as
begin
	insert into brog.Materiales
	select distinct MATERIAL_COD,MATERIAL_DESCRIPCION,MATERIAL_PRECIO from gd_esquema.Maestra where MATERIAL_COD <> 'null'
end
go

-- MIGRACION TAREAS
	
IF OBJECT_ID ('brog.migracionTareas', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionTareas; 
GO

create procedure brog.migracionTareas
as
begin
	
	--como las que estan cargadas tienen codigo apago el autoincremento de la PK
	set identity_insert brog.tarea on
	insert into brog.Tarea (tare_id,tare_desc,tare_tipo, tare_tiempo_estimado)
	select distinct TAREA_CODIGO ,TAREA_DESCRIPCION,TIPO_TAREA,TAREA_TIEMPO_ESTIMADO from gd_esquema.Maestra where tipo_tarea <> 'null'
	
	--Ahora vuelvo a cambiarlo como antes para las nuevas tareas

	set identity_insert brog.tarea off
end
GO


-- MIGRACION TALLER

IF OBJECT_ID ('brog.migracionTaller', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionTaller; 
GO

create procedure brog.migracionTaller
as
begin
	insert into brog.Taller
	select distinct TALLER_DIRECCION,TALLER_TELEFONO,TALLER_MAIL,TALLER_NOMBRE,TALLER_CIUDAD from gd_esquema.Maestra where TALLER_DIRECCION <> 'null'

end
GO

-- MIGRACION RECORRIDO

IF OBJECT_ID ('brog.migracionRecorrido', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionRecorrido; 
GO

create procedure brog.migracionRecorrido
as
begin
	insert into brog.Recorrido
	select distinct RECORRIDO_CIUDAD_DESTINO,RECORRIDO_CIUDAD_ORIGEN,RECORRIDO_PRECIO,RECORRIDO_KM from gd_esquema.Maestra where RECORRIDO_CIUDAD_DESTINO <> 'null'
	
end
GO

-- MIGRACION TIPO PAQUETE

IF OBJECT_ID ('brog.migracionTipoPaquete', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionTipoPaquete; 
GO

create procedure brog.migracionTipoPaquete
as
begin
	insert into brog.Tipo_paquete
	select DISTINCT PAQUETE_DESCRIPCION, PAQUETE_PESO_MAX, PAQUETE_ALTO_MAX, PAQUETE_ANCHO_MAX, PAQUETE_LARGO_MAX, PAQUETE_PRECIO from gd_esquema.Maestra where PAQUETE_DESCRIPCION <> 'null'

end
GO

-- MIGRACION CHOFER

IF OBJECT_ID ('brog.migracionChofer', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionChofer; 
GO

create procedure brog.migracionChofer
as
begin
	insert into brog.Chofer
	select distinct CHOFER_NRO_LEGAJO, CHOFER_NOMBRE, CHOFER_APELLIDO, CHOFER_DIRECCION, CHOFER_MAIL, CHOFER_DNI, CHOFER_TELEFONO, CHOFER_FECHA_NAC, CHOFER_COSTO_HORA from gd_esquema.Maestra where CHOFER_NOMBRE <> 'null'
end
GO

-- MIGRACION MODELO

IF OBJECT_ID ('brog.migracionModelo', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionModelo; 
GO

create procedure brog.migracionModelo
as
begin
	insert into brog.Modelo
	select distinct MODELO_CAMION, MARCA_CAMION_MARCA, MODELO_VELOCIDAD_MAX,MODELO_CAPACIDAD_TANQUE,MODELO_CAPACIDAD_CARGA from gd_esquema.Maestra where CHOFER_NOMBRE <> 'null'
	
end
GO

-- MIGRACION CAMION

IF OBJECT_ID ('brog.migracionCamion', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionCamion; 
GO

create procedure brog.migracionCamion
as
begin
	insert into brog.Camion
	select distinct CAMION_PATENTE, CAMION_NRO_CHASIS, CAMION_NRO_MOTOR,CAMION_FECHA_ALTA, mode_id
	from gd_esquema.Maestra join brog.Modelo on mode_nombre = MODELO_CAMION
	where CAMION_PATENTE <> 'null'
end
GO

-- MIGRACION DE ORDEN DE TRABAJO

IF OBJECT_ID ('brog.migracionOT', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionOT; 
GO

create procedure brog.migracionOT
as
begin
	insert into brog.Orden_trabajo
	select DISTINCT  cami_id, ORDEN_TRABAJO_FECHA
	from gd_esquema.Maestra join brog.Camion on cami_patente = CAMION_PATENTE
	where ORDEN_TRABAJO_FECHA <> 'NULL'

end
GO

-- MIGRACION MATERIAL POR TAREA

IF OBJECT_ID ('brog.migracionMaterialxTarea', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionMaterialxTarea; 
GO

create procedure brog.migracionMaterialxTarea
as
begin
	insert into brog.MaterialesXtarea
	select mate_id,tare_id, count(MATERIAL_COD) 
	from gd_esquema.Maestra 
	join brog.Tarea on TAREA_DESCRIPCION = tare_desc
	join brog.Materiales on MATERIAL_DESCRIPCION = mate_descripcion
	where MATERIAL_COD <> 'null'
	group by mate_id,tare_id	
end
GO

select mate_id,tare_id--, count(MATERIAL_COD) 
from gd_esquema.Maestra 
	join brog.Tarea on TAREA_DESCRIPCION = tare_desc
	join brog.Materiales on MATERIAL_DESCRIPCION = mate_descripcion
where MATERIAL_COD <> 'null'
--group by mate_id,tare_id	

select  TAREA_CODIGO ,TAREA_DESCRIPCION,TIPO_TAREA,TAREA_TIEMPO_ESTIMADO, MATERIAL_COD  from gd_esquema.Maestra where tipo_tarea <> 'null'
--group by TAREA_CODIGO ,TAREA_DESCRIPCION,TIPO_TAREA,TAREA_TIEMPO_ESTIMADO, MATERIAL_COD
ORDER BY TAREA_DESCRIPCION

-- MIGRACION MECANICO

IF OBJECT_ID ('brog.migracionMecanico', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionMecanico; 
GO

create procedure brog.migracionMecanico
as
begin
	insert into brog.Mecanico
	select distinct MECANICO_NRO_LEGAJO, MECANICO_NOMBRE, MECANICO_APELLIDO, MECANICO_DNI, MECANICO_DIRECCION, MECANICO_TELEFONO, MECANICO_MAIL, MECANICO_FECHA_NAC, MECANICO_COSTO_HORA, tall_id
	from gd_esquema.Maestra join brog.Taller on TALLER_NOMBRE = tall_nombre
	where MECANICO_NOMBRE <> 'null'
	
end
GO

-- MIGRACION ORDEN X TAREA

IF OBJECT_ID ('brog.migracionOrdenxTarea', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionOrdenxTarea; 
GO

create procedure brog.migracionOrdenxTarea
as
begin
	insert into brog.OtXtarea
	select distinct ORDEN_TRABAJO_ESTADO, TAREA_FECHA_INICIO_PLANIFICADO, TAREA_FECHA_INICIO, TAREA_FECHA_FIN, DATEDIFF(DAY, TAREA_FECHA_INICIO, TAREA_FECHA_FIN), ot_id, tare_id, meca_legajo 
	from gd_esquema.Maestra
	join brog.Camion on CAMION_PATENTE = cami_patente 
	join brog.Orden_trabajo on (ot_fecha_realizacion = ORDEN_TRABAJO_FECHA and ot_camion = cami_id)
	join brog.Tarea on TIPO_TAREA = tare_tipo
	join brog.Mecanico on MECANICO_NRO_LEGAJO = meca_legajo
	where ORDEN_TRABAJO_ESTADO <> 'null'	
end
GO


-- MIGRACION VIAJE

IF OBJECT_ID ('brog.migracionViaje', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionViaje; 
GO

create procedure brog.migracionViaje
as
begin
	insert into brog.Viaje
	select distinct VIAJE_FECHA_INICIO,VIAJE_FECHA_FIN,VIAJE_CONSUMO_COMBUSTIBLE, cami_id, CHOFER_NRO_LEGAJO, reco_id 
	from gd_esquema.Maestra
	join brog.Camion on CAMION_PATENTE = cami_patente
	join brog.Recorrido on RECORRIDO_CIUDAD_DESTINO = reco_ciudad_dest and RECORRIDO_CIUDAD_ORIGEN = reco_ciudad_origen and RECORRIDO_PRECIO = reco_precio and RECORRIDO_KM = reco_km -- puse todos xq es posible que se repitan y matchee con cualquiera
	where VIAJE_FECHA_INICIO IS NOT NULL
	
end
GO

-- MIGRACION PAQUETE

IF OBJECT_ID ('brog.migracionPaquete', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionPaquete; 
GO

create procedure brog.migracionPaquete
as
begin
	insert into brog.Paquete
	select tipa_id 
	from gd_esquema.Maestra join brog.Tipo_paquete on PAQUETE_DESCRIPCION = tipa_descripcion
	where CHOFER_NOMBRE <> 'null'
	
end
GO

-- MIGRACION PAQUETE X VIAJE

IF OBJECT_ID ('brog.migracionPaquetexviaje', 'P') IS NOT NULL  
   DROP PROCEDURE brog.migracionPaquetexviaje; 
GO

create procedure brog.migracionPaquetexviaje
as
begin
	insert into brog.Paquetexviaje
	select viaj_id, paqu_id,sum(PAQUETE_CANTIDAD)
	from gd_esquema.Maestra 
	join brog.Camion on CAMION_PATENTE = cami_patente
	join brog.Viaje on (VIAJE_FECHA_INICIO = viaj_fecha_inicio and viaj_camion = cami_id)
	join brog.Tipo_paquete on PAQUETE_DESCRIPCION = tipa_descripcion
	join brog.Paquete on PAQUETE_DESCRIPCION = paqu_id	
	group by viaj_id, paqu_id
end
GO


IF OBJECT_ID('migracion','P') IS NOT NULL
DROP PROCEDURE migracion
GO



create procedure brog.migracion 
as
begin
	exec brog.migracionMateriales
	exec brog.migracionTareas
	exec brog.migracionTaller
	exec brog.migracionRecorrido
	exec brog.migracionTipoPaquete
	exec brog.migracionChofer
	exec brog.migracionModelo
	exec brog.migracionCamion
	exec brog.migracionOT
	exec brog.migracionMaterialxTarea
	exec brog.migracionMecanico
	exec brog.migracionOrdenxTarea
	exec brog.migracionViaje
	exec brog.migracionPaquete
	exec brog.migracionPaquetexviaje
end
GO

exec brog.migracion

--  ----CONSTRAINTS ---->



-- FK CAMION
ALTER TABLE [brog].[Camion]
ADD CONSTRAINT FK_Camion FOREIGN KEY (cami_modelo) REFERENCES brog.Modelo(mode_id)
GO

-- FK ORDEN TRABAJO
ALTER TABLE [brog].[Orden_trabajo] 
ADD  CONSTRAINT FK_Orden_trabajo FOREIGN KEY (ot_camion) REFERENCES brog.Camion(cami_id)
GO

-- FK MATERIALESXTAREA
ALTER TABLE [brog].[MaterialesXtarea] 
ADD
  CONSTRAINT FK_material FOREIGN KEY (mxt_material) REFERENCES brog.Materiales(mate_id),
  CONSTRAINT FK_tarea FOREIGN KEY (mxt_tarea) REFERENCES brog.Tarea(tare_id)
GO

--FK MECANICO
ALTER TABLE [brog].[Mecanico] 
ADD CONSTRAINT FK_Mecanico FOREIGN KEY (meca_taller) REFERENCES brog.Taller(tall_id)
GO

--FK OTXTAREA
ALTER TABLE [brog].[OtXtarea] 
ADD 
  CONSTRAINT FK_OtXorder FOREIGN KEY (otxt_orden_trabajo) REFERENCES brog.Orden_trabajo(ot_id),
  CONSTRAINT FK_OtXtarea FOREIGN KEY (otxt_tarea) REFERENCES brog.Tarea(tare_id),
  CONSTRAINT FK_OtXmecanico FOREIGN KEY (otxt_mecanico) REFERENCES brog.Mecanico(meca_legajo)
GO

-- FK VIAJE
ALTER TABLE [brog].[Viaje] 
ADD 
  CONSTRAINT FK_Viaje_camion FOREIGN KEY (viaj_camion) REFERENCES brog.Camion(cami_id),
  CONSTRAINT FK_Viaje_chof FOREIGN KEY (viaj_chof) REFERENCES brog.Chofer(chof_id),
  CONSTRAINT FK_Viaje_recorrido FOREIGN KEY (viaj_recorrido) REFERENCES brog.Recorrido(reco_id)
GO

--FK PAQUETE
ALTER TABLE [brog].[Paquete]
ADD
  CONSTRAINT FK_Paquete_tipo FOREIGN KEY (paqu_tipo) REFERENCES brog.Tipo_paquete(tipa_id)
GO

--FK PAQUETEXVIAJE
ALTER TABLE [brog].[PaquetexViaje] 
ADD
  CONSTRAINT FK_Paqx_viaje FOREIGN KEY (paqx_viaje) REFERENCES brog.Viaje(viaj_id),
  CONSTRAINT FK_Paqx_paquete FOREIGN KEY (paqu_paquete) REFERENCES brog.Viaje(paqu_id)
GO
  
  







































