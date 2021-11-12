use GD2C2021
go



--Funciones

IF OBJECT_ID ('brog.dameRangoEdad', 'FN') IS NOT NULL  
   DROP FUNCTION brog.dameRangoEdad; 
GO

CREATE FUNCTION brog.dameRangoEdad(@fechaNacimiento smalldatetime)
RETURNS nvarchar(255)
AS
BEGIN
	
	declare @edad int
	declare @rango nvarchar(255)

	set @rango = 'rango invalido'
	set @edad = DATEDIFF(year,@fechaNacimiento,getDate())

	if(@edad between 18 and 30)
		set @rango = '18-30 anios'
	else if(@edad between 31 and 50)
		set @rango = '31-50 anios'
	else set @rango = '> 50 anios'

	return @rango
END 
GO


IF OBJECT_ID ('brog.damePrimerFecha', 'FN') IS NOT NULL  
   DROP FUNCTION brog.damePrimerFecha; 
GO
CREATE FUNCTION brog.damePrimerFecha(@orden int)
returns smalldatetime
as
begin
	declare @primerFecha smalldatetime
	select @primerFecha = min(otxt_fecha_inicio) from brog.OtXtarea
	where otxt_orden_trabajo = @orden

	return @primerFecha
end
go



IF OBJECT_ID ('brog.dameUltimaFecha', 'FN') IS NOT NULL  
   DROP FUNCTION brog.dameUltimaFecha; 
GO
CREATE FUNCTION brog.dameUltimaFecha(@orden int)
returns smalldatetime
as
begin
	declare @ultimaFecha smalldatetime
	select @ultimaFecha = max(otxt_fecha_fin) from brog.OtXtarea
	where otxt_orden_trabajo = @orden

	return @ultimaFecha
end
go

	

-- CREACION DE TABLAS DE DIMENSIONES

--DIMENSION CAMION

IF OBJECT_ID ('brog.BI_Camion', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Camion; 
GO
CREATE TABLE [brog].[BI_Camion] (
  [cami_id] int NOT NULL,
  [cami_patente] nvarchar(255) NOT NULL,
  [cami_nro_chasis] nvarchar(255) NOT NULL,
  [cami_nro_motor] nvarchar(255) NOT NULL,
  [cami_fecha_alta] datetime2(3) NOT NULL,
  --[cami_modelo] int NOT NULL,
  CONSTRAINT PK_BI_Camion PRIMARY KEY ([cami_id])
)

--DIMENSION MECANICO

IF OBJECT_ID ('brog.BI_Mecanico', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Mecanico; 
GO
CREATE TABLE [brog].[BI_Mecanico] (
  [meca_legajo] int NOT NULL,
  [meca_nombre] nvarchar(255) NOT NULL,
  [meca_apellido] nvarchar(255) NOT NULL,
  [meca_dni] decimal(18,0) NOT NULL,
  [meca_direccion] nvarchar(255) NOT NULL,
  [meca_telefono] int NOT NULL,
  [meca_mail] nvarchar(255) NOT NULL,
  [meca_fechaNac] datetime2(3) NOT NULL,
  [meca_costoHora] int NOT NULL,
--  [meca_taller] int NOT NULL,
  [meca_rango_edad] nvarchar(255) NOT NULL,
  CONSTRAINT PK_BI_Mecanico PRIMARY KEY ([meca_legajo])
)

--DIMENSION TIPO TAREA

IF OBJECT_ID ('brog.BI_Tipo_Tarea', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Tipo_Tarea; 
GO
CREATE TABLE [brog].[BI_Tipo_Tarea] (
  [tare_id] int NOT NULL,
  [tare_desc] nvarchar(255) NOT NULL
  CONSTRAINT PK_BI_Tarea PRIMARY KEY ([tare_id])
)


--DIMENSION TALLER

IF OBJECT_ID ('brog.BI_Taller', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Taller; 
GO
CREATE TABLE [brog].[BI_Taller] (
  [tall_id] int NOT NULL,
  [tall_direccion] nvarchar(255) NOT NULL,
  [tall_telefono] decimal(18,0) NOT NULL,
  [tall_mail] nvarchar(255) NOT NULL,
  [tall_nombre] nvarchar(255) NOT NULL,
  [tall_ciudad] nvarchar(255) NOT NULL,
  CONSTRAINT PK_BI_Taller PRIMARY KEY ([tall_id])
)


--DIMENSION RECORRIDO

IF OBJECT_ID ('brog.BI_Recorrido', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Recorrido; 
GO
CREATE TABLE [brog].[BI_Recorrido] (
  [reco_id] int NOT NULL,
  [reco_ciudad_dest] nvarchar(255) NOT NULL,
  [reco_ciudad_origen] nvarchar(255) NOT NULL,
  [reco_precio] decimal(18,2) NOT NULL,
  [reco_km] int NOT NULL,
  CONSTRAINT PK_BI_Recorrido PRIMARY KEY ([reco_id])
)

-- DIMENSION CHOFER

IF OBJECT_ID ('brog.BI_Chofer', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Chofer; 
GO
CREATE TABLE [brog].[BI_Chofer] (
  [chof_legajo] int NOT NULL,
  [chof_nombre] nvarchar(255) NOT NULL,
  [chof_apellido] nvarchar(255) NOT NULL,
  [chof_direccion] nvarchar(255) NOT NULL,
  [chof_mail] nvarchar(255) NOT NULL,
  [chof_dni] decimal(18,0) NOT NULL,
  [chof_telefono] int NOT NULL,
  [chof_fecha_nac] datetime2(3) NOT NULL,
  [chof_costo_hora] int NOT NULL,
  [chof_rango_edad] nvarchar(255) NOT NULL,
  CONSTRAINT PK_BI_Chofer PRIMARY KEY ([chof_legajo])
)

-- DIMENSION MODELO

IF OBJECT_ID ('brog.BI_Modelo', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Modelo; 
GO
CREATE TABLE [brog].[BI_Modelo] (
  [mode_id] int NOT NULL,
  [mode_nombre] nvarchar(255) NOT NULL,
--  [mode_marca] nvarchar(255) NOT NULL,
  [mode_velocidad_max] int NOT NULL,
  [mode_capacidad_tanque] int NOT NULL,
  [mode_capacidad_carga] int NOT NULL,
  CONSTRAINT PK_BI_Modelo PRIMARY KEY ([mode_id])
)

-- DIMENSION MARCA

IF OBJECT_ID ('brog.BI_Marca', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Marca; 
GO
CREATE TABLE [brog].[BI_Marca] (
  [marca_id] int identity(1,1),
  [marca_nombre] nvarchar(255),
  CONSTRAINT PK_BI_Marca PRIMARY KEY ([marca_id])
)

--DIMENSION TIEMPO

IF OBJECT_ID ('brog.BI_tiempo', 'U') IS NOT NULL  
   DROP TABLE brog.BI_tiempo; 
GO
CREATE TABLE [brog].[BI_tiempo](
  [tiem_id] int identity(1,1),
  [tiem_anio] int not null,
  [tiem_cuatri] int not null,
  CONSTRAINT PK_BI_Tiempo PRIMARY KEY ([tiem_id])
)


--DIMENSION MATERIALES

IF OBJECT_ID ('brog.BI_Materiales', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Materiales; 
GO
CREATE TABLE [brog].[BI_Materiales](
  [mate_id] nvarchar(100) NOT NULL,
  [mate_descripcion] nvarchar(255) not null,
  [mate_precio] decimal(18,2) not null,
  CONSTRAINT PK_BI_Materiales PRIMARY KEY ([mate_id])
)



--MIGRACION DE DATOS


--DIMENSION CAMION

insert into brog.BI_Camion
select cami_id,cami_patente,cami_nro_chasis,cami_nro_motor,cami_fecha_alta from brog.Camion
order by cami_id
go

--DIMENSION MECANICO

insert into brog.BI_Mecanico
select meca_legajo, meca_nombre, meca_apellido, meca_dni, meca_direccion, meca_telefono, meca_mail, meca_fechaNac, meca_costoHora, brog.dameRangoEdad(meca_fechaNac) from brog.Mecanico
order by meca_legajo


--DIMENSION TIPO TAREA

insert into brog.BI_Tipo_Tarea
select tare_id, tare_desc from brog.Tarea
order by tare_id


--DIMENSION TALLER

insert into brog.BI_Taller
select tall_id, tall_direccion, tall_telefono, tall_mail, tall_nombre, tall_ciudad from brog.Taller
order by tall_id


--DIMENSION RECORRIDO

insert into brog.BI_Recorrido
select reco_id, reco_ciudad_dest, reco_ciudad_origen, reco_precio, reco_km from brog.Recorrido
order by reco_id

-- DIMENSION CHOFER

insert into brog.BI_Chofer
select chof_legajo, chof_nombre, chof_apellido, chof_direccion, chof_mail, chof_dni, chof_telefono, chof_fecha_nac, chof_costo_hora, brog.dameRangoEdad(chof_fecha_nac) from brog.Chofer
order by chof_legajo

-- DIMENSION MODELO

insert into brog.BI_Modelo 
select mode_id, mode_nombre, mode_velocidad_max, mode_capacidad_tanque, mode_capacidad_carga from brog.Modelo
order by mode_id

-- DIMENSION MARCA

insert into brog.BI_Marca
select mode_marca from brog.Modelo
order by mode_id



--DIMENSION TIEMPO

insert into brog.BI_tiempo
select distinct year(otxt_fecha_inicio), DATEPART(quarter,otxt_fecha_inicio) from brog.OtXtarea
UNION
(select distinct year(viaj_fecha_inicio), DATEPART(quarter,viaj_fecha_inicio) from brog.Viaje)


-- DIMENSION MATERIALES

INSERT INTO brog.BI_Materiales
select mate_id, mate_descripcion, mate_precio from brog.Materiales
order by mate_id



-- TABLAS DE HECHO

IF OBJECT_ID ('brog.BI_hecho_arreglo', 'U') IS NOT NULL  
   DROP TABLE brog.BI_hecho_arreglo; 
GO
CREATE TABLE [brog].[BI_hecho_arreglo](
  [id_tall] int,
  [id_mode] int,
  [id_tare] int,
  [id_cami] int,
  [legajo_meca] int,
  [id_marca] int,
  [id_tiem] int,
  [id_mate] nvarchar(100),
  [tiempo_arreglo] int,
  [mate_cant] int  
)

insert into brog.BI_hecho_arreglo
select tall_id, md2.mode_id, tare_id, c2.cami_id, m1.meca_legajo, marca_id, tiem_id, mxt_material, otxt_tiempo_real, mxt_cantidad
from brog.OtXtarea
join brog.BI_Tipo_Tarea on tare_id = otxt_tarea
join brog.BI_Mecanico m1 on m1.meca_legajo = otxt_mecanico
join brog.Mecanico m on m1.meca_legajo = m.meca_legajo
join brog.BI_Taller on m.meca_taller = tall_id
join brog.BI_tiempo on year(otxt_fecha_inicio) = tiem_anio and DATEPART(quarter,otxt_fecha_inicio) = tiem_cuatri
join brog.Orden_trabajo on otxt_orden_trabajo = ot_id
join brog.Camion c on ot_camion = c.cami_id
join brog.BI_Camion c2 on c.cami_id = c2.cami_id
join brog.Modelo md1 on md1.mode_id = c.cami_modelo
join brog.BI_Modelo md2 on md2.mode_id = cami_modelo
join brog.BI_Marca on md1.mode_marca = marca_nombre
join brog.MaterialesXtarea on mxt_tarea = tare_id


IF OBJECT_ID ('brog.BI_hecho_envio', 'U') IS NOT NULL
   DROP TABLE brog.BI_hecho_envio; 
GO
CREATE TABLE [brog].[BI_hecho_envio](
  [chof_legajo] int,
  [reco_id] int,
  [cami_id] int,
  [tiem_id] int  
)

-- CONSTRAINTS

-- FK HECHO ARREGLO
ALTER TABLE brog.BI_hecho_arreglo
ADD CONSTRAINT FK_BI_taller FOREIGN KEY (id_tall) REFERENCES brog.BI_taller(tall_id),
	CONSTRAINT FK_BI_modelo FOREIGN KEY (id_mode) REFERENCES brog.BI_Modelo(mode_id),
	CONSTRAINT FK_BI_tarea FOREIGN KEY (id_tare) REFERENCES brog.BI_tipo_tarea(tare_id),
	CONSTRAINT FK_BI_camion FOREIGN KEY (id_cami) REFERENCES brog.BI_camion(cami_id),
	CONSTRAINT FK_BI_mecanico FOREIGN KEY (legajo_meca) REFERENCES brog.BI_mecanico(meca_legajo),
	CONSTRAINT FK_BI_marca FOREIGN KEY (id_marca) REFERENCES brog.BI_marca(marca_id),
	CONSTRAINT FK_BI_tiempo FOREIGN KEY (id_tiem) REFERENCES brog.BI_tiempo(tiem_id),
	CONSTRAINT FK_BI_material FOREIGN KEY (id_mate) REFERENCES brog.BI_materiales(mate_id)
GO



-- VISTAS


create view brog.BI_maximo_tiempo_fuera_de_servicio
as
	
	select distinct  id_cami Camion , tiem_cuatri Cuatrimestre, max(tiempo_arreglo) tiempoMaximo 
	from brog.BI_hecho_arreglo
	join brog.BI_tiempo on id_tiem = tiem_id
	group by tiem_cuatri,id_cami
	order by id_cami
go



create view brog.BI_costo_total_mantenimiento_x_camion
as
	
	select id_Cami, id_tall, tiem_cuatri, sum(mate_cant * mate_precio) + sum( meca_costoHora * tiempo_arreglo)  costoTotal
	from brog.BI_hecho_arreglo
	join brog.BI_tiempo on id_tiem = tiem_id
	join brog.BI_Materiales on id_mate = mate_id
	join brog.BI_Mecanico on meca_legajo = legajo_meca
	group by id_cami, id_tall, tiem_cuatri
	order by tiem_cuatri, id_tall, id_cami
	
go



create view brog.BI_desvio_promedio_tarea_x_taller
as
	

go

create view brog.BI_5_tareas_mas_realizadas_x_modelo_camion
as
	

go

create view brog.BI_10_materiales_mas_utilizados
as
	select top 10 mate_descripcion from brog.BI_hecho_arreglo
	join brog.BI_Materiales on mate_id = id_mate
	group by mate_descripcion, id_tall
	order by count(id_mate) desc

go

create view brog.BI_facturacion_total_x_recorrido
as


go

create view brog.BI_costo_promedio_x_rango_etario_de_choferes
as


go

create view brog.BI_ganancia_x_camion
as


go



