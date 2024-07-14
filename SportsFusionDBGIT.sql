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
VALUES('M'), ('S'), ('L'),('No aplica');


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
VALUES('Jerseys'), ('Sneakers'), ('Zapatillas deportivas'),('Articulos varios');

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
('Jersey Detroit Pistons 2005', 'Revive la gloria de los Detroit Pistons con esta auténtica camisa retro del 2005. Inspirada en la legendaria temporada en la que el equipo demostró su dominio en la NBA, esta prenda es perfecta para cualquier aficionado del baloncesto.', '666499134d74b.jpg',1,1,2,1),
('Camiseta de voleybol', 'Camiseta deportiva', '66649c7abe307.jpg',2,1,3,1),
('Jersey selección argentina', 'jersey del actual campeón del mundo', '6694571535e76.jpg',2,1,1,1),
('Jersey Arsenal 2004v', 'Jsersey del Arsenal de los invencibles de la temporada 2004', '669457e9bef94.jpg',1,1,1,1),
('Balón de volley', 'Balón marca Mikasa', '669458b5c35da.jpeg',2,4,3,2),
('Rodilleras', 'Rodilleras de volley', 'default.png',2,4,3,2),
('Jsersey Toronto Raptors', 'Jersey de los Toronto Raptors de la temporada 1999, con la dorsal 15 de Vince carter', '669459f95a009.jpg',1,1,2,1),
('Zapatillas Lebron 19', 'Zapatillas Nike Lebron 19 low', '66945a8090912.jpeg',2,3,2,1);

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
(20,20,2,3),
(50, 10,1,4),
(100, 30, 1,5),
(40, 50, 4,6),
(20,15,4,7),
(150,17,3,8),
(80,15,3,9);


SELECT * FROM tb_detalle_productos;
SELECT * FROM tb_productos;





            
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

CREATE TABLE tb_valoraciones(
id_valoracion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
comentario VARCHAR(250),
valoracion INT,
id_detalle int,
CONSTRAINT FK_valoracion_productos
FOREIGN KEY(id_detalle)
REFERENCES tb_detalle_pedidos (id_detalle),
id_cliente INT,
CONSTRAINT FK_cliente_valoracion_producto
FOREIGN KEY(id_cliente)
REFERENCES tb_clientes (id_cliente),
estado_valoracion BOOLEAN DEFAULT(1)
);

SELECT * FROM tb_valoraciones;


/*APARTADO PARA HACER LAS CONSULTAS QUE SE VAN A USAR EN LAS GRAFICAS*/

/*SELECT PARA LA GRAFICA DE PRODUCTOS MEJORES VALORADOS*/     
SELECT nombre_producto, AVG(valoracion) Promedio 
FROM tb_valoraciones
INNER JOIN 	tb_detalle_pedidos USING (id_detalle)
INNER JOIN tb_productos USING(id_producto)
GROUP BY nombre_producto
ORDER BY promedio DESC LIMIT 5  

SELECT id_valoracion
        FROM tb_valoraciones 
        WHERE id_detalle = 1 AND id_cliente = 1
	             
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
SELECT * FROM tb_tallas;
