USE [master]
GO
/****** Object:  Database [oxxo]    Script Date: 28/07/2018 02:37:48 p. m. ******/
CREATE DATABASE [oxxo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'oxxo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\oxxo.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'oxxo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\oxxo_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [oxxo] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [oxxo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [oxxo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [oxxo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [oxxo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [oxxo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [oxxo] SET ARITHABORT OFF 
GO
ALTER DATABASE [oxxo] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [oxxo] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [oxxo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [oxxo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [oxxo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [oxxo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [oxxo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [oxxo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [oxxo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [oxxo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [oxxo] SET  ENABLE_BROKER 
GO
ALTER DATABASE [oxxo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [oxxo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [oxxo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [oxxo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [oxxo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [oxxo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [oxxo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [oxxo] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [oxxo] SET  MULTI_USER 
GO
ALTER DATABASE [oxxo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [oxxo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [oxxo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [oxxo] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [oxxo]
GO
/****** Object:  StoredProcedure [dbo].[SP_Abono_Refrendo]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Abono_Refrendo](@placas varchar(10), @pago float, @result int output)
as
declare @refrendo float;
declare @refrendoNuevo float;
declare @refrendoFinal float;
declare @idRef smallint;
begin transaction;
set @idRef = (select id from tbl_refrendo where placa = @placas);
set @refrendo = (select saldo from tbl_refrendo where id = @idRef);
set @refrendoNuevo = @pago + @refrendo;
update tbl_refrendo set saldo = @refrendoNuevo where id = @idRef;
set @refrendoFinal = (select saldo from tbl_refrendo where id = @idRef);
if(@refrendo<>@refrendoFinal)
begin
commit transaction;
--select 1 as result;
set @result = 1;
end
else
begin
rollback transaction
set @result = 0;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Alta_Cliente]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Alta_Cliente](@nombre varchar(30), @a_paterno varchar(40), @a_materno varchar(40), @telefono varchar(15), @idProveedor tinyint, @result int output)
as
declare @dataUsu int;
declare @dataUsu2 int;
declare @dataPerson int;
declare @dataPerson2 int;
declare @idPerson smallint;
declare @idTelefonia bigint;
begin transaction
set @idTelefonia = (select max(id) from tbl_telefonia)+1;
if @idTelefonia is null
begin
set @idTelefonia = 1
end
set @dataUsu = (select count(*) from tbl_telefonia);
set @dataPerson = (select count(*) from tbl_persona);
insert into tbl_persona values(@nombre, @a_paterno, @a_materno, @telefono);
set @dataPerson2 = (select count(*) from tbl_persona);
if(@dataPerson<@dataPerson2)
begin
set @idPerson = (select max(id) from tbl_persona);
insert into tbl_telefonia values(@idTelefonia, @idProveedor, 0, @idPerson);
set @dataUsu2 = (select count(*) from tbl_telefonia);
if(@dataUsu<@dataUsu2)
begin
commit transaction;
--select 1 as result;
set @result = 1;
end
else
begin
rollback transaction;
--select 0 as result;
set @result = 0;
end
end
else
begin
rollback transaction
--select 0 as result;
set @result = 0;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Alta_Refrendo]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Alta_Refrendo](@nombre varchar(30), @a_paterno varchar(40), @a_materno varchar(40), @telefono varchar(15), @placas varchar(10), @result int output)
as
declare @dataUsu int;
declare @dataUsu2 int;
declare @dataPerson int;
declare @dataPerson2 int;
declare @idPerson smallint;
declare @idRefrendo smallint;
begin transaction
set @idRefrendo = (select max(id) from tbl_refrendo)+1;

if @idRefrendo is null
begin 
set @idRefrendo = 1
end

set @dataUsu = (select count(*) from tbl_refrendo);
set @dataPerson = (select count(*) from tbl_persona);
insert into tbl_persona values(@nombre, @a_paterno, @a_materno, @telefono);
set @dataPerson2 = (select count(*) from tbl_persona);
if(@dataPerson<@dataPerson2)
begin
set @idPerson = (select max(id) from tbl_persona);
insert into tbl_refrendo values(@idRefrendo, 0, @idPerson, GETDATE(), @placas);
set @dataUsu2 = (select count(*) from tbl_refrendo);
if(@dataUsu<@dataUsu2)
begin
commit transaction;
--select 1 as result;
set @result = 1;
end
else
begin
rollback transaction;
--select 0 as result;
set @result = 0;
end
end
else
begin
rollback transaction
--select 0 as result;
set @result = 0;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Alta_Saldo]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Alta_Saldo](@NumTel varchar(15), @idTelefonia tinyint, @monto float, @result int OUTPUT)
as
begin
declare @countMove int;
declare @countUso int;
declare @countTelefonia int;
declare @montoTotal float;
declare @countUso2 int;
declare @idUso int;
declare @countMove2 int;
declare @montoActual float;
declare @montoNuevo float;
declare @countTelefonia2 int;
declare @idUser smallint;
declare @montoTotal2 float;
declare @idTelefoniaT bigint;
begin transaction
set @idTelefoniaT = (select t.id from tbl_telefonia as t inner join tbl_persona as p on t.id_persona = p.id where p.telefono = @NumTel);
if (select count(*) from tbl_telefonia where id = @idTelefoniaT)>0
begin
set @countMove = (select count(*) from tbl_movimiento_telefonia);
set @countUso = (select count(*) from clt_uso);
set @montoTotal = (select saldo from tbl_telefonia where id = @idTelefoniaT);
insert into clt_uso values(@idTelefonia, 1, 0, @idTelefoniaT)
set @countUso2 = (select count(*) from clt_uso);
if (@countUso<@countUso2)
begin
set @idUso = (select MAX(id) from clt_uso);
if @idUso is null
begin 
set @idUso = 1
end
insert into tbl_movimiento_telefonia values(@idTelefoniaT, @monto, @idUso, GETDATE(), 0)
set @countMove2 = (select count(*) from tbl_movimiento_telefonia);
if(@countMove<@countMove2)
begin
set @montoActual = (select saldo from tbl_telefonia where id = @idTelefoniaT);
set @montoNuevo = @montoActual+@monto;
set @idUser = (select p.id from tbl_persona as p inner join tbl_telefonia as t on p.id = t.id_persona where t.id = @idTelefoniaT );
update tbl_telefonia set saldo = @montoNuevo where id = @idTelefoniaT;
set @montoTotal2 = (select saldo from tbl_telefonia where id = @idTelefoniaT);
if(@montoTotal<@montoTotal2)
begin
commit transaction
-- select 1 result;
	set @result = 1;
end
else
begin
rollback transaction
-- select 0 as result;
	set @result = 0;
end
end
else
begin
rollback transaction
-- select 0 as result;
	set @result = 0;
end
end
else
begin
rollback transaction 
-- select 0 as result;
	set @result = 0;
end
end
else
begin
rollback transaction 
-- select 0 as result;
	set @result = 0;
end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Alta_Usu]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Alta_Usu](@usuario varchar(20), @psw varchar(255), @nombre varchar(30), @a_paterno varchar(40), @a_materno varchar(40), @telefono varchar(15), @result int output)
as
declare @dataUsu int;
declare @dataUsu2 int;
declare @dataPerson int;
declare @dataPerson2 int;
declare @idPerson smallint;
begin transaction
set @dataUsu = (select count(*) from tbl_usuario);
set @dataPerson = (select count(*) from tbl_persona);
insert into tbl_persona values(@nombre, @a_paterno, @a_materno, @telefono);
set @dataPerson2 = (select count(*) from tbl_persona);
if(@dataPerson<@dataPerson2)
begin
set @idPerson = (select max(id) from tbl_persona);
if @idPerson is null
begin
set @idPerson = 1
end
insert into tbl_usuario(usuario, psw, id_persona)values(@usuario, HashBytes('SHA1', @psw), @idPerson);
set @dataUsu2 = (select count(*) from tbl_usuario);
if(@dataUsu<@dataUsu2)
begin
commit transaction;
--select 1 as result;
set @result = 1;
end
else
begin
rollback transaction;
--select 0 as result;
set @result = 0;
end
end
else
begin
rollback transaction
--select 0 as result;
set @result = 0;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ConsultarSaldo_Refrendo]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[SP_ConsultarSaldo_Refrendo]
	@IdPlaca varchar(10)

AS
BEGIN
SET NOCOUNT ON;

	SELECT	P.nombre, P.a_paterno, P.a_materno,
			R.placa,R.saldo
	FROM dbo.tbl_persona P
	INNER JOIN  dbo.tbl_refrendo R
	 ON R.id_persona=P.Id
	WHERE R.placa=@IdPlaca

END



GO
/****** Object:  StoredProcedure [dbo].[SP_Pago_Refrendo]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Pago_Refrendo](@placas varchar(10), @pago float, @result int output)
as
declare @refrendo float;
declare @refrendoNuevo float;
declare @refrendoFinal float;
declare @idRefrendo smallint;
begin transaction;
set @idRefrendo = (select id from tbl_refrendo where placa = @placas);
set @refrendo = (select saldo from tbl_refrendo where id = @idRefrendo);
set @refrendoNuevo = @refrendo - @pago;
update tbl_refrendo set saldo = @refrendoNuevo where id = @idRefrendo;
set @refrendoFinal = (select saldo from tbl_refrendo where id = @idRefrendo);
if(@refrendo<>@refrendoFinal)
begin
commit transaction;
--select 1 as result;
set @result = 1;
end
else
begin
rollback transaction
--select 0 as result;
set @result = 0;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Uso_Tel]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Uso_Tel](@tipoUso bigint, @idTelefonia tinyint, @tiempo float, @NumTel varchar(15), @result int output)
as
begin
declare @countMove int;
declare @countUso int;
declare @countTelefonia int;
declare @montoTotal float;
declare @countUso2 int;
declare @idUso int;
declare @countMove2 int;
declare @montoActual float;
declare @montoNuevo float;
declare @countTelefonia2 int;
declare @idUser smallint;
declare @montoTotal2 float;
declare @constoTran float;
declare @costoTranFinal float;
declare @impuestos float;
declare @impuestosFinal float;
declare @finalCosto float;
declare @idTelefoniaT bigint;
begin transaction
set @idTelefoniaT = (select t.id from tbl_telefonia as t inner join tbl_persona as p on t.id_persona = p.id where p.telefono = @NumTel);
if (select count(*) from tbl_telefonia where id = @idTelefoniaT)>0
begin
set @countMove = (select count(*) from tbl_movimiento_telefonia);
set @countUso = (select count(*) from clt_uso);
set @montoTotal = (select saldo from tbl_telefonia where id = @idTelefoniaT);
set @constoTran = (select costo from clt_tipo_movimiento where id = @tipoUso)
insert into clt_uso values(@idTelefonia, @tipoUso, @constoTran, @idTelefoniaT)
set @countUso2 = (select count(*) from clt_uso);
if (@countUso<@countUso2)
begin
set @idUso = (select MAX(id) from clt_uso);
if @idUso is null
begin
set @idUso = 1;
end
set @costoTranFinal = @constoTran * @tiempo;
set @impuestos = (select impuestos from clt_proveedor_telefonia where id = @idTelefonia);
set @impuestosFinal = @impuestos * @costoTranFinal;
set @finalCosto = @impuestosFinal+@costoTranFinal;
insert into tbl_movimiento_telefonia values(@idTelefoniaT, @finalCosto, @idUso, GETDATE(), @tiempo)
set @countMove2 = (select count(*) from tbl_movimiento_telefonia);
if(@countMove<@countMove2)
begin
set @montoActual = (select saldo from tbl_telefonia where id = @idTelefoniaT);
set @montoNuevo = @montoActual-@finalCosto;
set @idUser = (select p.id from tbl_persona  as p inner join tbl_telefonia as t on p.id = t.id_persona where t.id = @idTelefoniaT);
update tbl_telefonia set saldo = @montoNuevo where id = @idTelefoniaT;
set @montoTotal2 = (select saldo from tbl_telefonia where id = @idTelefoniaT);
if(@montoTotal>=@montoTotal2)
begin
commit transaction
--select 1 result;
set @result = 1;
end
else
begin
rollback transaction
--select 0 as result;
set @result = 0;
end
end
else
begin
rollback transaction
--select 0 as result;
set @result = 0;
end
end
else
begin
rollback transaction 
--select 0 as result;
set @result = 0;
end
end
else
begin
rollback transaction 
--select 0 as result;
set @result = 0;
end
end
GO
/****** Object:  Table [dbo].[clt_proveedor_telefonia]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[clt_proveedor_telefonia](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](50) NULL,
	[impuestos] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[clt_tipo_movimiento]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[clt_tipo_movimiento](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[tipo] [varchar](50) NOT NULL,
	[descripcion] [varchar](50) NULL,
	[costo] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[clt_uso]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clt_uso](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[id_proveedor] [tinyint] NOT NULL,
	[id_tipo_movimiento] [tinyint] NOT NULL,
	[costo] [float] NOT NULL,
	[id_telefonia] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_movimiento_telefonia]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_movimiento_telefonia](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_telefonia] [bigint] NOT NULL,
	[monto] [float] NOT NULL,
	[id_uso] [tinyint] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[tiempo] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_persona]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_persona](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](30) NOT NULL,
	[a_paterno] [varchar](40) NOT NULL,
	[a_materno] [varchar](40) NOT NULL,
	[telefono] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_refrendo]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_refrendo](
	[id] [smallint] NOT NULL,
	[saldo] [float] NOT NULL,
	[id_persona] [smallint] NOT NULL,
	[fecha] [datetime] NULL,
	[placa] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[placa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_telefonia]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_telefonia](
	[id] [bigint] NOT NULL,
	[id_proveedor] [tinyint] NOT NULL,
	[saldo] [float] NOT NULL,
	[id_persona] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_usuario]    Script Date: 28/07/2018 02:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_usuario](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[usuario] [varchar](20) NOT NULL,
	[psw] [varchar](255) NOT NULL,
	[fecha_login] [datetime] NULL,
	[fecha_logout] [datetime] NULL,
	[id_persona] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tbl_refrendo] ADD  DEFAULT ('4578') FOR [placa]
GO
ALTER TABLE [dbo].[clt_uso]  WITH CHECK ADD FOREIGN KEY([id_proveedor])
REFERENCES [dbo].[clt_proveedor_telefonia] ([id])
GO
ALTER TABLE [dbo].[clt_uso]  WITH CHECK ADD FOREIGN KEY([id_tipo_movimiento])
REFERENCES [dbo].[clt_tipo_movimiento] ([id])
GO
ALTER TABLE [dbo].[tbl_movimiento_telefonia]  WITH CHECK ADD FOREIGN KEY([id_telefonia])
REFERENCES [dbo].[tbl_telefonia] ([id])
GO
ALTER TABLE [dbo].[tbl_movimiento_telefonia]  WITH CHECK ADD FOREIGN KEY([id_uso])
REFERENCES [dbo].[clt_uso] ([id])
GO
ALTER TABLE [dbo].[tbl_refrendo]  WITH CHECK ADD FOREIGN KEY([id_persona])
REFERENCES [dbo].[tbl_persona] ([id])
GO
ALTER TABLE [dbo].[tbl_telefonia]  WITH CHECK ADD FOREIGN KEY([id_persona])
REFERENCES [dbo].[tbl_persona] ([id])
GO
ALTER TABLE [dbo].[tbl_usuario]  WITH CHECK ADD FOREIGN KEY([id_persona])
REFERENCES [dbo].[tbl_persona] ([id])
GO
USE [master]
GO
ALTER DATABASE [oxxo] SET  READ_WRITE 
GO
