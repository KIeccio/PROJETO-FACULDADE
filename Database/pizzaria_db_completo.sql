/****** Object:  Database [pizzaria_db]    Script Date: 4/7/2025 4:34:27 PM ******/
CREATE DATABASE [pizzaria_db]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'pizzaria_db', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\pizzaria_db.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'pizzaria_db_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\pizzaria_db_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [pizzaria_db] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [pizzaria_db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [pizzaria_db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [pizzaria_db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [pizzaria_db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [pizzaria_db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [pizzaria_db] SET ARITHABORT OFF 
GO
ALTER DATABASE [pizzaria_db] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [pizzaria_db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [pizzaria_db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [pizzaria_db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [pizzaria_db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [pizzaria_db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [pizzaria_db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [pizzaria_db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [pizzaria_db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [pizzaria_db] SET  ENABLE_BROKER 
GO
ALTER DATABASE [pizzaria_db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [pizzaria_db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [pizzaria_db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [pizzaria_db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [pizzaria_db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [pizzaria_db] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [pizzaria_db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [pizzaria_db] SET RECOVERY FULL 
GO
ALTER DATABASE [pizzaria_db] SET  MULTI_USER 
GO
ALTER DATABASE [pizzaria_db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [pizzaria_db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [pizzaria_db] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [pizzaria_db] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [pizzaria_db] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [pizzaria_db] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'pizzaria_db', N'ON'
GO
ALTER DATABASE [pizzaria_db] SET QUERY_STORE = ON
GO
ALTER DATABASE [pizzaria_db] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/****** Object:  Table [dbo].[CategoriasPizza]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriasPizza](
	[categoria_id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NOT NULL,
	[descricao] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[categoria_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[cliente_id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](100) NOT NULL,
	[telefone] [varchar](20) NULL,
	[email] [varchar](100) NULL,
	[endereco] [varchar](200) NULL,
	[data_cadastro] [date] NOT NULL,
	[pontos_fidelidade] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComprasIngredientes]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComprasIngredientes](
	[compra_id] [int] IDENTITY(1,1) NOT NULL,
	[fornecedor_id] [int] NOT NULL,
	[funcionario_id] [int] NOT NULL,
	[data_compra] [date] NOT NULL,
	[valor_total] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[compra_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fornecedores]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fornecedores](
	[fornecedor_id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](100) NOT NULL,
	[telefone] [varchar](20) NULL,
	[email] [varchar](100) NULL,
	[endereco] [varchar](200) NULL,
	[cnpj] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[fornecedor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Funcionarios]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funcionarios](
	[funcionario_id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](100) NOT NULL,
	[cargo] [varchar](50) NOT NULL,
	[telefone] [varchar](20) NULL,
	[email] [varchar](100) NULL,
	[data_contratacao] [date] NOT NULL,
	[salario] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[funcionario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredientes]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredientes](
	[ingrediente_id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NOT NULL,
	[descricao] [varchar](200) NULL,
	[unidade_medida] [varchar](20) NOT NULL,
	[estoque_atual] [decimal](10, 2) NOT NULL,
	[estoque_minimo] [decimal](10, 2) NOT NULL,
	[preco_por_unidade] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ingrediente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItensCompra]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItensCompra](
	[item_id] [int] IDENTITY(1,1) NOT NULL,
	[compra_id] [int] NOT NULL,
	[ingrediente_id] [int] NOT NULL,
	[quantidade] [decimal](10, 2) NOT NULL,
	[preco_unitario] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItensPedido]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItensPedido](
	[item_id] [int] IDENTITY(1,1) NOT NULL,
	[pedido_id] [int] NOT NULL,
	[pizza_id] [int] NULL,
	[quantidade] [int] NOT NULL,
	[tamanho] [varchar](20) NOT NULL,
	[preco_unitario] [decimal](10, 2) NOT NULL,
	[observacoes] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pagamentos]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagamentos](
	[pagamento_id] [int] IDENTITY(1,1) NOT NULL,
	[pedido_id] [int] NOT NULL,
	[forma_pagamento] [varchar](50) NOT NULL,
	[valor] [decimal](10, 2) NOT NULL,
	[data_hora] [datetime] NOT NULL,
	[status] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pagamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[pedido_id] [int] IDENTITY(1,1) NOT NULL,
	[cliente_id] [int] NULL,
	[funcionario_id] [int] NULL,
	[data_hora] [datetime] NOT NULL,
	[status] [varchar](20) NOT NULL,
	[tipo_entrega] [varchar](20) NOT NULL,
	[endereco_entrega] [varchar](200) NULL,
	[valor_total] [decimal](10, 2) NOT NULL,
	[observacoes] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[pedido_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pizza_Ingredientes]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pizza_Ingredientes](
	[pizza_id] [int] NOT NULL,
	[ingrediente_id] [int] NOT NULL,
	[quantidade] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pizza_id] ASC,
	[ingrediente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pizzas]    Script Date: 4/7/2025 4:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pizzas](
	[pizza_id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NOT NULL,
	[descricao] [varchar](200) NULL,
	[categoria_id] [int] NULL,
	[preco_medio] [decimal](10, 2) NOT NULL,
	[tamanho_padrao] [varchar](20) NULL,
	[disponivel] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[pizza_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CategoriasPizza] ON 

INSERT [dbo].[CategoriasPizza] ([categoria_id], [nome], [descricao]) VALUES (1, N'Tradicional', N'Pizzas clássicas com sabores consagrados')
INSERT [dbo].[CategoriasPizza] ([categoria_id], [nome], [descricao]) VALUES (2, N'Especial', N'Pizzas com combinações especiais da casa')
INSERT [dbo].[CategoriasPizza] ([categoria_id], [nome], [descricao]) VALUES (3, N'Vegetariana', N'Pizzas sem ingredientes de origem animal')
SET IDENTITY_INSERT [dbo].[CategoriasPizza] OFF
GO
SET IDENTITY_INSERT [dbo].[Ingredientes] ON 

INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (1, N'Mussarela', NULL, N'kg', CAST(10.00 AS Decimal(10, 2)), CAST(2.00 AS Decimal(10, 2)), CAST(25.90 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (2, N'Tomate', NULL, N'kg', CAST(5.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (3, N'Manjericão', NULL, N'g', CAST(500.00 AS Decimal(10, 2)), CAST(100.00 AS Decimal(10, 2)), CAST(0.15 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (4, N'Pepperoni', NULL, N'kg', CAST(8.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(32.75 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (5, N'Calabresa', NULL, N'kg', CAST(7.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(28.90 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (6, N'Brócolis', NULL, N'kg', CAST(4.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(12.50 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (7, N'Bacon', NULL, N'kg', CAST(6.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(35.00 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (8, N'Catupiry', NULL, N'kg', CAST(5.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(42.00 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (9, N'Provolone', NULL, N'kg', CAST(4.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(38.50 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (10, N'Parmesão', NULL, N'kg', CAST(3.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(45.00 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (11, N'Gorgonzola', NULL, N'kg', CAST(3.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(48.00 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (12, N'Frango desfiado', NULL, N'kg', CAST(6.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(22.00 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (13, N'Presunto', NULL, N'kg', CAST(5.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(30.00 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (14, N'Ovos', NULL, N'dz', CAST(10.00 AS Decimal(10, 2)), CAST(2.00 AS Decimal(10, 2)), CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (15, N'Cebola', NULL, N'kg', CAST(4.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(6.50 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (16, N'Azeitona', NULL, N'kg', CAST(3.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(28.00 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (17, N'Pimentão', NULL, N'kg', CAST(3.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(9.00 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (18, N'Orégano', NULL, N'g', CAST(300.00 AS Decimal(10, 2)), CAST(50.00 AS Decimal(10, 2)), CAST(0.20 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (19, N'Alho', NULL, N'kg', CAST(2.00 AS Decimal(10, 2)), CAST(0.50 AS Decimal(10, 2)), CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (20, N'Milho', NULL, N'kg', CAST(4.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(7.50 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (21, N'Ervilha', NULL, N'kg', CAST(3.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), CAST(9.00 AS Decimal(10, 2)))
INSERT [dbo].[Ingredientes] ([ingrediente_id], [nome], [descricao], [unidade_medida], [estoque_atual], [estoque_minimo], [preco_por_unidade]) VALUES (22, N'Molho de tomate', NULL, N'kg', CAST(8.00 AS Decimal(10, 2)), CAST(2.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Ingredientes] OFF
GO
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (4, 1, CAST(0.15 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (4, 2, CAST(0.10 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (4, 5, CAST(0.20 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (4, 15, CAST(0.02 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (5, 1, CAST(0.18 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (5, 6, CAST(0.15 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (5, 7, CAST(0.12 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (5, 20, CAST(0.10 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (6, 1, CAST(0.15 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (6, 8, CAST(0.10 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (6, 9, CAST(0.10 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (6, 10, CAST(0.08 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (6, 20, CAST(0.10 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (7, 1, CAST(0.10 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (7, 8, CAST(0.15 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (7, 11, CAST(0.18 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (7, 20, CAST(0.10 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (8, 1, CAST(0.15 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (8, 12, CAST(0.12 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (8, 13, CAST(2.00 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (8, 14, CAST(0.08 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (8, 15, CAST(0.05 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (8, 16, CAST(0.06 AS Decimal(10, 2)))
INSERT [dbo].[Pizza_Ingredientes] ([pizza_id], [ingrediente_id], [quantidade]) VALUES (8, 20, CAST(0.10 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Pizzas] ON 

INSERT [dbo].[Pizzas] ([pizza_id], [nome], [descricao], [categoria_id], [preco_medio], [tamanho_padrao], [disponivel]) VALUES (1, N'Calabresa', NULL, 1, CAST(48.00 AS Decimal(10, 2)), N'Média', 1)
INSERT [dbo].[Pizzas] ([pizza_id], [nome], [descricao], [categoria_id], [preco_medio], [tamanho_padrao], [disponivel]) VALUES (2, N'Brócolis com Bacon', NULL, 2, CAST(58.00 AS Decimal(10, 2)), N'Média', 1)
INSERT [dbo].[Pizzas] ([pizza_id], [nome], [descricao], [categoria_id], [preco_medio], [tamanho_padrao], [disponivel]) VALUES (3, N'Quatro Queijos', NULL, 2, CAST(62.00 AS Decimal(10, 2)), N'Média', 1)
INSERT [dbo].[Pizzas] ([pizza_id], [nome], [descricao], [categoria_id], [preco_medio], [tamanho_padrao], [disponivel]) VALUES (4, N'Frango Catupiry', NULL, 2, CAST(56.00 AS Decimal(10, 2)), N'Média', 1)
INSERT [dbo].[Pizzas] ([pizza_id], [nome], [descricao], [categoria_id], [preco_medio], [tamanho_padrao], [disponivel]) VALUES (5, N'Portuguesa', NULL, 1, CAST(54.00 AS Decimal(10, 2)), N'Média', 1)
INSERT [dbo].[Pizzas] ([pizza_id], [nome], [descricao], [categoria_id], [preco_medio], [tamanho_padrao], [disponivel]) VALUES (6, N'Calabresa', NULL, 1, CAST(48.00 AS Decimal(10, 2)), N'Média', 1)
INSERT [dbo].[Pizzas] ([pizza_id], [nome], [descricao], [categoria_id], [preco_medio], [tamanho_padrao], [disponivel]) VALUES (7, N'Brócolis com Bacon', NULL, 2, CAST(58.00 AS Decimal(10, 2)), N'Média', 1)
INSERT [dbo].[Pizzas] ([pizza_id], [nome], [descricao], [categoria_id], [preco_medio], [tamanho_padrao], [disponivel]) VALUES (8, N'Quatro Queijos', NULL, 2, CAST(62.00 AS Decimal(10, 2)), N'Média', 1)
INSERT [dbo].[Pizzas] ([pizza_id], [nome], [descricao], [categoria_id], [preco_medio], [tamanho_padrao], [disponivel]) VALUES (9, N'Frango Catupiry', NULL, 2, CAST(56.00 AS Decimal(10, 2)), N'Média', 1)
INSERT [dbo].[Pizzas] ([pizza_id], [nome], [descricao], [categoria_id], [preco_medio], [tamanho_padrao], [disponivel]) VALUES (10, N'Portuguesa', NULL, 1, CAST(54.00 AS Decimal(10, 2)), N'Média', 1)
SET IDENTITY_INSERT [dbo].[Pizzas] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Forneced__35BD3E4817C9CEB6]    Script Date: 4/7/2025 4:34:28 PM ******/
ALTER TABLE [dbo].[Fornecedores] ADD UNIQUE NONCLUSTERED 
(
	[cnpj] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_ingredientes_nome]    Script Date: 4/7/2025 4:34:28 PM ******/
CREATE NONCLUSTERED INDEX [idx_ingredientes_nome] ON [dbo].[Ingredientes]
(
	[nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_itenspedido_pedido]    Script Date: 4/7/2025 4:34:28 PM ******/
CREATE NONCLUSTERED INDEX [idx_itenspedido_pedido] ON [dbo].[ItensPedido]
(
	[pedido_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_itenspedido_pizza]    Script Date: 4/7/2025 4:34:28 PM ******/
CREATE NONCLUSTERED INDEX [idx_itenspedido_pizza] ON [dbo].[ItensPedido]
(
	[pizza_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_pedidos_cliente]    Script Date: 4/7/2025 4:34:28 PM ******/
CREATE NONCLUSTERED INDEX [idx_pedidos_cliente] ON [dbo].[Pedidos]
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_pedidos_data]    Script Date: 4/7/2025 4:34:28 PM ******/
CREATE NONCLUSTERED INDEX [idx_pedidos_data] ON [dbo].[Pedidos]
(
	[data_hora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_pedidos_funcionario]    Script Date: 4/7/2025 4:34:28 PM ******/
CREATE NONCLUSTERED INDEX [idx_pedidos_funcionario] ON [dbo].[Pedidos]
(
	[funcionario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Clientes] ADD  DEFAULT ((0)) FOR [pontos_fidelidade]
GO
ALTER TABLE [dbo].[Pizzas] ADD  DEFAULT ((1)) FOR [disponivel]
GO
ALTER TABLE [dbo].[ComprasIngredientes]  WITH CHECK ADD  CONSTRAINT [FK_Compras_Fornecedores] FOREIGN KEY([fornecedor_id])
REFERENCES [dbo].[Fornecedores] ([fornecedor_id])
GO
ALTER TABLE [dbo].[ComprasIngredientes] CHECK CONSTRAINT [FK_Compras_Fornecedores]
GO
ALTER TABLE [dbo].[ComprasIngredientes]  WITH CHECK ADD  CONSTRAINT [FK_Compras_Funcionarios] FOREIGN KEY([funcionario_id])
REFERENCES [dbo].[Funcionarios] ([funcionario_id])
GO
ALTER TABLE [dbo].[ComprasIngredientes] CHECK CONSTRAINT [FK_Compras_Funcionarios]
GO
ALTER TABLE [dbo].[ItensCompra]  WITH CHECK ADD  CONSTRAINT [FK_ItensCompra_Compras] FOREIGN KEY([compra_id])
REFERENCES [dbo].[ComprasIngredientes] ([compra_id])
GO
ALTER TABLE [dbo].[ItensCompra] CHECK CONSTRAINT [FK_ItensCompra_Compras]
GO
ALTER TABLE [dbo].[ItensCompra]  WITH CHECK ADD  CONSTRAINT [FK_ItensCompra_Ingredientes] FOREIGN KEY([ingrediente_id])
REFERENCES [dbo].[Ingredientes] ([ingrediente_id])
GO
ALTER TABLE [dbo].[ItensCompra] CHECK CONSTRAINT [FK_ItensCompra_Ingredientes]
GO
ALTER TABLE [dbo].[ItensPedido]  WITH CHECK ADD  CONSTRAINT [FK_ItensPedido_Pedidos] FOREIGN KEY([pedido_id])
REFERENCES [dbo].[Pedidos] ([pedido_id])
GO
ALTER TABLE [dbo].[ItensPedido] CHECK CONSTRAINT [FK_ItensPedido_Pedidos]
GO
ALTER TABLE [dbo].[ItensPedido]  WITH CHECK ADD  CONSTRAINT [FK_ItensPedido_Pizzas] FOREIGN KEY([pizza_id])
REFERENCES [dbo].[Pizzas] ([pizza_id])
GO
ALTER TABLE [dbo].[ItensPedido] CHECK CONSTRAINT [FK_ItensPedido_Pizzas]
GO
ALTER TABLE [dbo].[Pagamentos]  WITH CHECK ADD  CONSTRAINT [FK_Pagamentos_Pedidos] FOREIGN KEY([pedido_id])
REFERENCES [dbo].[Pedidos] ([pedido_id])
GO
ALTER TABLE [dbo].[Pagamentos] CHECK CONSTRAINT [FK_Pagamentos_Pedidos]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Clientes] FOREIGN KEY([cliente_id])
REFERENCES [dbo].[Clientes] ([cliente_id])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Clientes]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Funcionarios] FOREIGN KEY([funcionario_id])
REFERENCES [dbo].[Funcionarios] ([funcionario_id])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Funcionarios]
GO
ALTER TABLE [dbo].[Pizza_Ingredientes]  WITH CHECK ADD  CONSTRAINT [FK_PizzaIngredientes_Ingrediente] FOREIGN KEY([ingrediente_id])
REFERENCES [dbo].[Ingredientes] ([ingrediente_id])
GO
ALTER TABLE [dbo].[Pizza_Ingredientes] CHECK CONSTRAINT [FK_PizzaIngredientes_Ingrediente]
GO
ALTER TABLE [dbo].[Pizza_Ingredientes]  WITH CHECK ADD  CONSTRAINT [FK_PizzaIngredientes_Pizza] FOREIGN KEY([pizza_id])
REFERENCES [dbo].[Pizzas] ([pizza_id])
GO
ALTER TABLE [dbo].[Pizza_Ingredientes] CHECK CONSTRAINT [FK_PizzaIngredientes_Pizza]
GO
ALTER TABLE [dbo].[Pizzas]  WITH CHECK ADD  CONSTRAINT [FK_Pizzas_Categoria] FOREIGN KEY([categoria_id])
REFERENCES [dbo].[CategoriasPizza] ([categoria_id])
GO
ALTER TABLE [dbo].[Pizzas] CHECK CONSTRAINT [FK_Pizzas_Categoria]
GO
ALTER DATABASE [pizzaria_db] SET  READ_WRITE 
GO
