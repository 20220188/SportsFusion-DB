DROP database if EXISTS sportfusionDB;
CREATE DATABASE sportfusionDB;

USE sportfusionDB;

CREATE TABLE tb_deportes (
id_deporte INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_deporte VARCHAR(25) unique,
estado_retro TINYINT(1),
imagen_deporte VARCHAR(25)
);

INSERT INTO tb_deportes(nombre_deporte, estado_retro, imagen_deporte)
VALUES('Futbol', 1, '66649908c4213.jpg'),
('Baloncesto', 1, '66649c2c8ac95.jpg'),
('Voleybol', 0, '66649c3408966.jpg');



CREATE TABLE tb_clientes (
id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_cliente VARCHAR(50),
telefono_cliente VARCHAR(9) unique,
correo_cliente VARCHAR(100) unique,
dirección_cliente VARCHAR(250),
clave_cliente VARCHAR(64),
estado_cliente BOOLEAN DEFAULT(1)
);

SELECT * FROM tb_clientes;



CREATE TABLE tb_administradores(
id_admin INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_admin VARCHAR(50),
apellido_admin VARCHAR(50),
correo_admin VARCHAR(100) unique,
alias_admin VARCHAR(50) unique,
clave_admin  VARCHAR(64)
);


SELECT * FROM tb_administradores;

CREATE TABLE tb_tallas(
id_talla INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
talla VARCHAR(10) unique
);

INSERT INTO tb_tallas(talla)
VALUES('M'), ('S'), ('L');


/*Tpo de producto es para definir si son coleccionable o de actualidad*/
CREATE TABLE tb_categorias(
id_categoria INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_categoria VARCHAR(30) unique,
imagen_categoria varchar(25),
descripcion_categoria VARCHAR(200)
);

SELECT * FROM tb_categorias;

INSERT INTO tb_categorias(nombre_categoria, imagen_categoria, descripcion_categoria)
VALUES('Coleccionable', 'default.png', 'Articulos deportivos coleccionables'),
('De Actualidad', 'default.png', 'Articulos deportivos de temporadas recientes');


/*Categorias es para definir si son camisetas, medias, snekers, etc*/
CREATE TABLE tb_tipo_productos(
id_tipo_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
tipo_producto VARCHAR(25) unique
);

INSERT INTO tb_tipo_productos(tipo_producto)
VALUES('Jerseys'), ('Sneakers'), ('Zapatillas deportivas');

CREATE TABLE tb_opiniones(
id_opinion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
comentario VARCHAR(250),
opinion int
); 

INSERT INTO tb_opiniones(comentario,opinion)
VALUES('Producto de muy buena calidad',5),
('Producto de calidad aceptable', 3),
('Producto de muy mala calidad', 1);



CREATE TABLE tb_generos(
id_genero INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
genero VARCHAR(10) unique
);

INSERT INTO tb_generos(genero)
VALUES('Hombre'),('Mujer'),('Niños');


CREATE TABLE tb_productos(
id_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_producto VARCHAR(30),
descripcion VARCHAR(250),
imagen VARCHAR(30),
id_categoria INT,
CONSTRAINT FK_categoria_producto
FOREIGN KEY(id_categoria) 
REFERENCES tb_categorias (id_categoria),
id_tipo_producto INT,
CONSTRAINT FK_tipoP_productos 
FOREIGN KEY(id_tipo_producto) 
REFERENCES tb_tipo_productos (id_tipo_producto),
id_deporte INT,
CONSTRAINT FK_deporte_producto 
FOREIGN KEY(id_deporte) 
REFERENCES tb_deportes(id_deporte),
id_genero INT,
CONSTRAINT FK_genero_producto
FOREIGN KEY(id_genero) 
REFERENCES tb_generos (id_genero)
);

insert INTO tb_productos(nombre_producto, descripcion, imagen, id_categoria, id_tipo_producto, id_deporte,id_genero)
VALUES('Jersey FC Barcelona', 'Jersey del mejor equipo', '6664991c37339.jpg',2,1,1,1),
('Jersey Detroit Pistons 2005', 'Jersey de campeones', '666499134d74b.jpg',1,1,2,1),
('Camiseta de voleybol', 'Camiseta deportiva', '66649c7abe307.jpg',2,1,3,1);

SELECT * FROM tb_productos;



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
REFERENCES tb_tallas (id_talla),
id_producto INT,
CONSTRAINT FK_detalleP_producto
FOREIGN KEY(id_producto) 
REFERENCES tb_productos (id_producto)
);

INSERT INTO tb_detalle_productos(precio, cantidad_disponible, id_talla, id_producto)
VALUES(29.99,15,1,1),
(45,10,3,2),
(20,20,2,3);

SELECT * FROM tb_detalle_productos;
SELECT * FROM tb_productos;



CREATE TABLE tb_valoraciones_productos(
id_valoracion_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_opinion INT,
CONSTRAINT FK_ipinion_valoracion_producto
FOREIGN KEY(id_opinion)
REFERENCES tb_opiniones (id_opinion),
id_detalle_producto INT,
CONSTRAINT FK_producto_valoracion_producto
FOREIGN KEY(id_detalle_producto)
REFERENCES tb_detalle_productos (id_detalle_producto),
id_cliente INT,
CONSTRAINT FK_cliente_valoracion_producto
FOREIGN KEY(id_cliente)
REFERENCES tb_clientes (id_cliente),
estado_valoracion BOOLEAN
);

SELECT * FROM tb_valoraciones_productos;

        
        
/*
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
*/


CREATE TABLE tb_pedidos (
id_pedido INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
fecha_registro DATETIME NOT NULL DEFAULT current_timestamp(),
id_cliente INT,
estado_pedido ENUM ('Pendiente','Aceptado'),
CONSTRAINT FK_pedido_cliente
FOREIGN KEY(id_cliente)
REFERENCES tb_clientes (id_cliente)
);


SELECT * FROM tb_clientes;

CREATE TABLE tb_detalle_pedidos (
id_detalle INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
cantidad_pedido SMALLINT(6),
precio_pedido NUMERIC(5,2),
id_pedido INT,
CONSTRAINT FK_pedido_detalle_pedido
FOREIGN KEY(id_pedido)
REFERENCES tb_pedidos (id_pedido),
id_producto INT, 
CONSTRAINT FK_detalle_producto
FOREIGN KEY(id_producto)
REFERENCES tb_productos (id_producto)
);

SELECT id_detalle, nombre_producto, precio_pedido, cantidad_pedido
                FROM tb_detalle_pedidos 
                INNER JOIN tb_pedidos USING(id_pedido)
                INNER JOIN tb_productos USING(id_producto)
                WHERE id_pedido = 4;
                
DELIMITER //

CREATE PROCEDURE sp_actualizar_cantidad_producto(
    IN p_id_detalle INT,
    IN p_nueva_cantidad INT
)
BEGIN
    DECLARE v_cantidad_anterior INT;
    DECLARE v_id_producto INT;
    
    -- Obtener la cantidad anterior y el identificador del producto
    SELECT cantidad_pedido, id_producto
    INTO v_cantidad_anterior, v_id_producto
    FROM tb_detalle_pedidos
    WHERE id_detalle = p_id_detalle;
    
    -- Calcular la diferencia de cantidad
    SET @diferencia = p_nueva_cantidad - v_cantidad_anterior;
    
    -- Actualizar la cantidad disponible en tb_detalle_productos
    UPDATE tb_detalle_productos
    SET cantidad_disponible = cantidad_disponible - @diferencia
    WHERE id_producto = v_id_producto;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_update_cantidad_pedido
BEFORE UPDATE ON tb_detalle_pedidos
FOR EACH ROW
BEGIN
    -- Llamar al procedimiento almacenado para actualizar la cantidad de productos
    CALL sp_actualizar_cantidad_producto(OLD.id_detalle, NEW.cantidad_pedido);
END //

DELIMITER ;	



SELECT * FROM tb_productos;
SELECT * FROM tb_detalle_productos;
SELECT * FROM tb_detalle_pedidos;
SELECT * FROM tb_pedidos;
SELECT * FROM tb_clientes;
