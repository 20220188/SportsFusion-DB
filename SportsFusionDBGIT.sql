DROP database if EXISTS sportfusionDB;
CREATE DATABASE sportfusionDB;

USE sportfusionDB;

CREATE TABLE tb_deportes (
id_deporte INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_deporte VARCHAR(25),
estado_retro BOOLEAN,
imagen_deporte VARCHAR(25)
);




CREATE TABLE tb_clientes (
id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_ciente VARCHAR(50),
telefono_cliente VARCHAR(9),
correo_cliente VARCHAR(100),
dirección_cliente VARCHAR(250),
alias_cliente VARCHAR(50),
clave_cliente VARCHAR(64)
);




CREATE TABLE tb_administradores(
id_admin INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_admin VARCHAR(50),
apellido_admin VARCHAR(50),
correo_admin VARCHAR(100),
alias_admin VARCHAR(50),
clave_admin  VARCHAR(64)
);

SELECT * FROM tb_administradores;

CREATE TABLE tb_tallas(
id_talla INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
talla VARCHAR(10)
);


/*Tpo de producto es para definir si son coleccionable o de actualidad*/
CREATE TABLE tb_categorias(
id_categoria INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_categoria VARCHAR(30),
imagen_categoria varchar(25),
descripcion_categoria VARCHAR(200)
);

SELECT * FROM tb_categorias;


/*Categorias es para definir si son camisetas, medias, snekers, etc*/
CREATE TABLE tb_tipo_productos(
id_tipo_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
tipo_producto VARCHAR(25)
);


CREATE TABLE tb_opiniones(
id_opinion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
comentario VARCHAR(250),
opinion FLOAT
); 



CREATE TABLE tb_productos(
id_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_producto VARCHAR(30),
descripcion VARCHAR(250),
imagen VARCHAR(30),
genero VARCHAR(20),
id_tipo_producto INT,
CONSTRAINT FK_tipoP_productos 
FOREIGN KEY(id_tipo_producto) 
REFERENCES tb_tipo_productos (id_tipo_producto),
id_categoria INT,
CONSTRAINT FK_categoria_producto
FOREIGN KEY(id_categoria) 
REFERENCES tb_categorias (id_categoria)
);


/* detalle productos lleva precio, stock y llave foranea de tallas*/
CREATE TABLE tb_detalle_productos(
id_detalle_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
precio DECIMAL(5,2),
CONSTRAINT check_precio CHECK(precio > 0),
cantidad_disponible INT,
CONSTRAINT check_stock CHECK(cantidad_disponible >= 0),
id_talla INT,
CONSTRAINT FK_talla_detalle_producto
FOREIGN KEY(id_talla)
REFERENCES tb_tallas (id_talla)
);

CREATE TABLE tb_valoraciones_productos(
id_valoracion_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_opinion INT,
CONSTRAINT FK_ipinion_valoracion_producto
FOREIGN KEY(id_opinion)
REFERENCES tb_opiniones (id_opinion),
id_producto INT,
CONSTRAINT FK_producto_valoracion_producto
FOREIGN KEY(id_producto)
REFERENCES tb_productos (id_producto),
id_cliente INT,
CONSTRAINT FK_cliente_valoracion_producto
FOREIGN KEY(id_cliente)
REFERENCES tb_clientes (id_cliente)
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




