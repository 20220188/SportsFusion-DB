DROP DATABASE if EXISTS sportfusionDB;

CREATE DATABASE sportfusionDB;

USE sportfusionDB;

CREATE TABLE tb_deportes (
id_deporte INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_deporte VARCHAR(25)
);

CREATE TABLE tb_generos (
id_genero int PRIMARY KEY AUTO_INCREMENT NOT NULL,
genero VARCHAR(20)
);

CREATE TABLE tb_registros (
  id_registro INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  usuario VARCHAR(30),
  clave VARCHAR(20),
  nombre VARCHAR(50),
  correo VARCHAR(40)
);

CREATE TABLE tb_clientes (
id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR(50),
dui_cliente VARCHAR(10),
telefono_cliente VARCHAR(9),
correo_cliente VARCHAR(100),
dirección_cliente VARCHAR(250)
);

CREATE TABLE tb_logins(
id_login  INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_registro INT,
CONSTRAINT FK_registro_login
FOREIGN KEY (id_registro)
REFERENCES tb_registros (id_registro)
);

CREATE TABLE tb_tipo_productos(
id_tipo_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
tipo_producto VARCHAR(30)
);

CREATE TABLE tb_productos(
id_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_producto VARCHAR(30),
descripcion varchar(250),
precio DECIMAL(5,2),
cantidad_disponible INT ,
imagen VARCHAR(30),
genero ENUM('Hombre', 'Mujer', 'Infantil'),
id_tipo_producto INT,
CONSTRAINT FK_tipoP_productos
FOREIGN KEY(id_tipo_producto)
REFERENCES tb_tipo_productos (id_tipo_producto)
);

CREATE TABLE tb_productos_deportes(
id_proDep INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_producto INT, 
CONSTRAINT FK_producto_proDep
FOREIGN KEY(id_producto)
REFERENCES tb_productos (id_producto),
id_deporte INT,
CONSTRAINT FK_deportes_proDep
FOREIGN KEY(id_deporte)
REFERENCES tb_deportes (id_deporte)
);


CREATE TABLE tb_pedidos (
id_pedido INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
direccion_pedido VARCHAR(250),
estado_pedido ENUM('Pendiente', 'Finalizado', 'Entregado', 'Anulado'),
fecha_registro DATE,
id_cliente INT,
CONSTRAINT FK_pedido_cliente
FOREIGN KEY(id_cliente)
REFERENCES tb_clientes (id_cliente)
);

CREATE TABLE tb_detalle_pedidos (
id_detalle INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
cantidad_pedido SMALLINT(6),
precio_pedido NUMERIC(5,2),
id_pedido INT,
CONSTRAINT FK_detalle_pedido
FOREIGN KEY(id_pedido)
REFERENCES tb_pedidos (id_pedido),
id_producto INT, 
CONSTRAINT FK_detalle_producto
FOREIGN KEY(id_producto)
REFERENCES tb_productos (id_producto)
);

