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


-- CREACION DE TABLAS DE DIMENSIONES

--DIMENSION CAMION

IF OBJECT_ID ('brog.BI_Camion', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Camion; 
GO
CREATE TABLE [brog].[BI_Camion] (
  [cami_id] int identity(1,1),
  [cami_patente] nvarchar(255) NOT NULL,
  [cami_nro_chasis] nvarchar(255) NOT NULL,
  [cami_nro_motor] nvarchar(255) NOT NULL,
  [cami_fecha_alta] datetime2(3) NOT NULL,
  --[cami_modelo] int NOT NULL,
  CONSTRAINT PK_Camion PRIMARY KEY ([cami_id])
)

--DIMENSION MECANICO

IF OBJECT_ID ('brog.BI_Mecanico', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Mecanico; 
GO
CREATE TABLE [brog].[BI_Mecanico] (
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

--DIMENSION TIPO TAREA

IF OBJECT_ID ('brog.BI_Tipo_Tarea', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Tipo_Tarea; 
GO
CREATE TABLE [brog].[BI_Tipo_Tarea] (
  [tare_id] int identity(1,1),
  [tare_desc] nvarchar(255) NOT NULL
  CONSTRAINT PK_Tarea PRIMARY KEY ([tare_id])
)


--DIMENSION TALLER

IF OBJECT_ID ('brog.BI_Taller', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Taller; 
GO
CREATE TABLE [brog].[BI_Taller] (
  [tall_id] int identity(1,1),
  [tall_direccion] nvarchar(255) NOT NULL,
  [tall_telefono] decimal(18,0) NOT NULL,
  [tall_mail] nvarchar(255) NOT NULL,
  [tall_nombre] nvarchar(255) NOT NULL,
  [tall_ciudad] nvarchar(255) NOT NULL,
  CONSTRAINT PK_Taller PRIMARY KEY ([tall_id])
)


--DIMENSION RECORRIDO

IF OBJECT_ID ('brog.BI_Recorrido', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Recorrido; 
GO
CREATE TABLE [brog].[BI_Recorrido] (
  [reco_id] int identity(1,1),
  [reco_ciudad_dest] nvarchar(255) NOT NULL,
  [reco_ciudad_origen] nvarchar(255) NOT NULL,
  [reco_precio] decimal(18,2) NOT NULL,
  [reco_km] int NOT NULL,
  CONSTRAINT PK_Recorrido PRIMARY KEY ([reco_id])
)

-- DIMENSION CHOFER

IF OBJECT_ID ('brog.BI_Chofer', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Chofer; 
GO
CREATE TABLE [brog].[BI_Chofer] (
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

-- DIMENSION MODELO

IF OBJECT_ID ('brog.BI_Modelo', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Modelo; 
GO
CREATE TABLE [brog].[BI_Modelo] (
  [mode_id] int identity(1,1),
  [mode_nombre] nvarchar(255) NOT NULL,
  [mode_marca] nvarchar(255) NOT NULL,
  [mode_velocidad_max] int NOT NULL,
  [mode_capacidad_tanque] int NOT NULL,
  [mode_capacidad_carga] int NOT NULL,
  CONSTRAINT PK_Modelo PRIMARY KEY ([mode_id])
)

-- DIMENSION MARCA

IF OBJECT_ID ('brog.BI_Marca', 'U') IS NOT NULL  
   DROP TABLE brog.BI_Marca; 
GO
CREATE TABLE [brog].[BI_Marca] (
  [marca_id] int identity(1,1),
  [marca_nombre] nvarchar(255),
  CONSTRAINT PK_Modelo PRIMARY KEY ([marca_id])
)

--DIMENSION TIEMPO

IF OBJECT_ID ('brog.BI_tiempo', 'U') IS NOT NULL  
   DROP TABLE brog.BI_tiempo; 
GO
CREATE TABLE [brog].[BI_tiempo](
  [tiem_id] int identity(1,1),
  [tiem_anio] int not null,
  [tiem_cuatri] int not null,
  CONSTRAINT PK_Modelo PRIMARY KEY ([tiem_id])
)


--MIGRACION DE DATOS


--DIMENSION CAMION

insert into brog.BI_Camion
select cami_id,cami_patente,cami_nro_chasis,cami_nro_motor,cami_fecha_alta from brog.Camion
order by cami_id
go

--DIMENSION MECANICO

insert into brog.BI_Mecanico
select meca_legajo, meca_nombre, meca_apellido, meca_dni, meca_direccion, meca_telefono, meca_mail, meca_fechaNac, meca_costoHora from brog.Mecanico
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
select mode_id, mode_velocidad_max, mode_capacidad_tanque, mode_capacidad_carga, mode_nombre from brog.Modelo
order by mode_id

-- DIMENSION MARCA

insert into brog.BI_Marca
select mode_marca from brog.Modelo
order by mode_id



--DIMENSION TIEMPO

--insert into brog.BI_tiempo
--select year(), DATEPART(quarter, ) 



-- TABLAS DE HECHO

