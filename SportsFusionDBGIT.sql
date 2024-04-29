DROP database if EXISTS sportfusionDB;
CREATE DATABASE sportfusionDB;

USE sportfusionDB;

CREATE TABLE tb_deportes (
id_deporte INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_deporte VARCHAR(25)
);


-- inserciones de la tabla deportes 
INSERT INTO tb_deportes (nombre_deporte) VALUES 
('Fútbol'),
('Baloncesto'),
('Deportes de raqueta'),
('Natación'),
('Voleibol');

CREATE TABLE tb_nivel_usuarios(
id_nivel_usuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nivel_usuario ENUM('Cliente', 'Administrador')
);



CREATE TABLE tb_clientes (
id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_ciente VARCHAR(50),
dui_cliente VARCHAR(10) unique,
telefono_cliente VARCHAR(9),
correo_cliente VARCHAR(100),
dirección_cliente VARCHAR(250),
alias_cliente VARCHAR(50),
clave_cliente VARCHAR(64),
id_nivel_usuario INT,
CONSTRAINT FK_nivel_cliente
FOREIGN KEY(id_nivel_usuario) 
REFERENCES tb_nivel_usuarios (id_nivel_usuario)
);

-- inserciones de la tabla clientes 
INSERT INTO tb_clientes (nombre_ciente, dui_cliente, telefono_cliente, correo_cliente, dirección_cliente, alias_cliente, clave_cliente) VALUES 
('Ana García', '00123456-7', '11111111', 'anagarcia@example.com', 'Calle 1 #111', 'ana_g', 'abcd1234'),
('Luis Rodríguez', '12345678-9', '22222222', 'luisrodriguez@example.com', 'Avenida 2 #222', 'luisr', 'pass123'),
('Elena Martínez', '98765432-1', '33333333', 'elenamartinez@example.com', 'Pasaje 3 #333', 'elena_m', 'qwerty789'),
('David López', '86429753-1', '44444444', 'davidlopez@example.com', 'Calle 4 #444', 'davidl', '12345'),
('Sofía Pérez', '75318642-1', '55555555', 'sofiaperez@example.com', 'Avenida 5 #555', 'sofiap', 'passpass'),
('Jorge Ramírez', '64297531-1', '66666666', 'jorgeramirez@example.com', 'Pasaje 6 #666', 'jorger', 'ramirez123'),
('Marcela González', '53186429-1', '77777777', 'marcelagonzalez@example.com', 'Calle 7 #777', 'marcelag', '1234567'),
('Carlos Hernández', '42975318-1', '88888888', 'carloshernandez@example.com', 'Avenida 8 #888', 'carlosh', 'qazwsx'),
('Alejandra Díaz', '31864297-1', '99999999', 'alejandradiaz@example.com', 'Pasaje 9 #999', 'alejandrad', 'diaz123'),
('Miguel Torres', '75318642-2', '1010101010', 'migueltorres@example.com', 'Calle 10 #1010', 'miguelt', 'qwertyuiop'),
('Patricia Sánchez', '64297531-2', '1111111111', 'patriciasanchez@example.com', 'Avenida 11 #1111', 'patricias', 'pass1234'),
('Daniel Vásquez', '53186429-2', '1212121212', 'danielvasquez@example.com', 'Pasaje 12 #1212', 'danielv', 'password'),
('Monica Jiménez', '42975318-2', '1313131313', 'monicajimenez@example.com', 'Calle 13 #1313', 'monicaj', 'asdfgh'),
('Roberto Cruz', '31864297-2', '1414141414', 'robertocruz@example.com', 'Avenida 14 #1414', 'robertoc', 'qazwsxedc'),
('Carmen Gómez', '75318642-3', '1515151515', 'carmengomez@example.com', 'Pasaje 15 #1515', 'carmeng', 'carmen123'),
('Francisco Ruiz', '64297531-3', '1616161616', 'franciscoruiz@example.com', 'Calle 16 #1616', 'franciscor', 'passpass'),
('Raquel Castro', '53186429-3', '1717171717', 'raquelcastro@example.com', 'Avenida 17 #1717', 'raquelc', 'raquel123'),
('Diego Mendoza', '42975318-3', '1818181818', 'diegomendoza@example.com', 'Pasaje 18 #1818', 'diegom', 'password123'),
('Fernanda Ortega', '31864297-3', '1919191919', 'fernandaortega@example.com', 'Calle 19 #1919', 'fernandao', 'asdfgh123'),
('Andrés Flores', '75318642-4', '2020202020', 'andresflores@example.com', 'Avenida 20 #2020', 'andresf', 'qwerty123'),
('Lorena Reyes', '64297531-4', '2121212121', 'lorenareyes@example.com', 'Pasaje 21 #2121', 'lorenar', 'pass12345'),
('Santiago García', '53186429-4', '2222222222', 'santiagogarcia@example.com', 'Calle 22 #2222', 'santiagog', 'qazwsx123'),
('Camila Herrera', '42975318-4', '2333333333', 'camilaherrera@example.com', 'Avenida 23 #2333', 'camilah', 'camila123'),
('Carlos Pérez', '31864297-4', '2444444444', 'carlosperez@example.com', 'Pasaje 24 #2444', 'carlosp', 'password1234'),
('Verónica López', '75318642-5', '2555555555', 'veronicalopez@example.com', 'Calle 25 #2555', 'veronical', 'asdfgh1234');


CREATE TABLE tb_administradores(
id_admin INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_admin VARCHAR(50),
dui_admin VARCHAR(10) UNIQUE,
telefono_admin VARCHAR(9),
correo_admin VARCHAR(100),
alias_admin VARCHAR(50),
clave_admin  VARCHAR(64),
id_nivel_usuario INT,
CONSTRAINT FK_nivel_admin
FOREIGN KEY(id_nivel_usuario) 
REFERENCES tb_nivel_usuarios (id_nivel_usuario)
);


CREATE TABLE tb_categorias(
id_categoria INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_categoria ENUM('Zapatillas', 'Jerseys', 'shorts', 'Sneakers', 'implementes')
);

CREATE TABLE tb_tipo_productos(
id_tipo_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
tipo_producto ENUM('Retro', 'Normal'),
id_categoria INT,
CONSTRAINT FK_categoria_tipoP
FOREIGN KEY(id_categoria) 
REFERENCES tb_categorias (id_categoria)
);




CREATE TABLE tb_opiniones(
id_opinion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
comentario VARCHAR(250),
opinion FLOAT
); 

-- inserciones de la tabla opiniones 
INSERT INTO tb_opiniones (comentario, opinion) VALUES 
('Excelente producto, muy cómodo.', 4.5),
('Buena relación calidad-precio.', 4.0),
('El producto no cumplió mis expectativas.', 2.5),
('Entrega rápida y buen servicio al cliente.', 4.8),
('El producto llegó dañado.', 1.0);



CREATE TABLE tb_productos(
    id_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_producto VARCHAR(30),
    descripcion VARCHAR(250),
    precio DECIMAL(5,2),
    CONSTRAINT check_precio CHECK(precio > 0),
    cantidad_disponible INT,
    CONSTRAINT check_stock CHECK(cantidad_disponible >= 0),
    imagen VARCHAR(30),
    genero ENUM('Hombre', 'Mujer', 'Infantil', 'Unisex'),
    id_tipo_producto INT,
    CONSTRAINT FK_tipoP_productos FOREIGN KEY(id_tipo_producto) REFERENCES tb_tipo_productos (id_tipo_producto)
);


-- inserciones de la tabla productos 
INSERT INTO tb_productos (nombre_producto, descripcion, precio, cantidad_disponible, imagen, genero, id_tipo_producto) VALUES 
('Camiseta Nike Dri-FIT', 'Camiseta deportiva Nike Dri-FIT para entrenamiento.', 29.99, 50, 'nike_camiseta.jpg', 'Hombre', 2),
('Pantalón Adidas', 'Pantalón deportivo Adidas de poliéster con cintura elástica.', 34.99, 40, 'adidas_pantalón.jpg', 'Mujer', 2),
('Calcetines Puma', 'Calcetines deportivos Puma de algodón transpirable.', 9.99, 60, 'puma_calcetines.jpg', 'Unisex', 1),
('Gorra Reebok', 'Gorra deportiva Reebok de algodón con visera curva.', 19.99, 30, 'reebok_gorra.jpg', 'Unisex', 1),
('Balón de Baloncesto Spalding', 'Balón de baloncesto Spalding de cuero sintético con buen agarre.', 24.99, 25, 'spalding_balón.jpg', 'Infantil', 2),
('Gafas de Natación Speedo', 'Gafas de natación Speedo antiempañantes con ajuste cómodo.', 14.99, 20, 'speedo_gafas.jpg', 'Unisex', 1),
('Raqueta de Tenis Wilson', 'Raqueta de tenis Wilson para jugadores intermedios.', 89.99, 15, 'wilson_raqueta.jpg', 'Unisex', 1),
('Chaqueta Deportiva Nike', 'Chaqueta deportiva Nike con tecnología de control de temperatura.', 59.99, 35, 'nike_chaqueta.jpg', 'Mujer', 2),
('Mochila Adidas', 'Mochila deportiva Adidas con compartimento para portátil.', 49.99, 25, 'adidas_mochila.jpg', 'Unisex', 1),
('Pelota de Rugby Gilbert', 'Pelota de rugby Gilbert con agarre antideslizante.', 29.99, 20, 'gilbert_pelota.jpg', 'Infantil', 2),
('Guantes de Portero Nike', 'Guantes de portero Nike con espuma absorbente de impactos.', 39.99, 10, 'nike_guantes.jpg', 'Hombre', 1),
('Pesa Rusa Everlast', 'Pesa rusa Everlast de hierro fundido con revestimiento de vinilo.', 49.99, 20, 'everlast_pesa.jpg', 'Unisex', 1),
('Botella de Agua Adidas', 'Botella de agua Adidas con diseño ergonómico y boquilla retráctil.', 9.99, 30, 'adidas_botella.jpg', 'Unisex', 1),
('Rodillera McDavid', 'Rodillera McDavid para protección y estabilización de la rodilla.', 19.99, 15, 'mcdavid_rodillera.jpg', 'Unisex', 1),
('Bañador Speedo', 'Bañador Speedo de tejido resistente al cloro y secado rápido.', 34.99, 20, 'speedo_bañador.jpg', 'Hombre', 2),
('Reloj Deportivo Garmin', 'Reloj deportivo Garmin con GPS y monitor de frecuencia cardíaca.', 199.99, 5, 'garmin_reloj.jpg', 'Unisex', 1),
('Bicicleta de Montaña Specialized', 'Bicicleta de montaña Specialized con cuadro de aluminio y suspensión delantera.', 899.99, 2, 'specialized_bicicleta.jpg', 'Unisex', 1),
('Cuerda de Saltar Everlast', 'Cuerda de saltar Everlast de PVC ajustable para entrenamiento cardiovascular.', 14.99, 30, 'everlast_cuerda.jpg', 'Unisex', 1),
('Gel Energético PowerBar', 'Gel energético PowerBar con carbohidratos de liberación rápida.', 2.99, 50, 'powerbar_gel.jpg', 'Unisex', 1),
('Toalla Deportiva Nike', 'Toalla deportiva Nike de microfibra absorbente y secado rápido.', 19.99, 20, 'nike_toalla.jpg', 'Unisex', 1);




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

INSERT INTO tb_valoraciones_productos (id_opinion, id_producto, id_cliente) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);
-- Agregar más inserciones si es necesario


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

-- inserciones de la tabla productos_deportes
INSERT INTO tb_productos_deportes (id_producto, id_deporte) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 1);
-- Agregar más inserciones si es necesario



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

-- inserciones de la tabla pedidos
INSERT INTO tb_pedidos (direccion_pedido, estado_pedido, fecha_registro, id_cliente) VALUES 
('Calle A #123', 'Pendiente', '2024-03-01', 1),
('Avenida B #456', 'Finalizado', '2024-03-02', 2),
('Pasaje C #789', 'Entregado', '2024-03-03', 3),
('Plaza D #321', 'Anulado', '2024-03-04', 4),
('Calle E #654', 'Pendiente', '2024-03-05', 5),
('Calle F #789', 'Pendiente', '2024-03-06', 6),
('Avenida G #123', 'Finalizado', '2024-03-07', 7),
('Pasaje H #456', 'Entregado', '2024-03-08', 8),
('Calle I #789', 'Pendiente', '2024-03-09', 9),
('Avenida J #321', 'Finalizado', '2024-03-10', 10),
('Calle K #654', 'Entregado', '2024-03-11', 11),
('Pasaje L #789', 'Pendiente', '2024-03-12', 12),
('Avenida M #123', 'Finalizado', '2024-03-13', 13),
('Calle N #456', 'Entregado', '2024-03-14', 14),
('Pasaje O #789', 'Pendiente', '2024-03-15', 15),
('Avenida P #321', 'Finalizado', '2024-03-16', 16),
('Calle Q #654', 'Entregado', '2024-03-17', 17),
('Pasaje R #789', 'Pendiente', '2024-03-18', 18),
('Avenida S #123', 'Finalizado', '2024-03-19', 19),
('Calle T #456', 'Entregado', '2024-03-20', 20),
('Pasaje U #789', 'Pendiente', '2024-03-21', 21),
('Avenida V #321', 'Finalizado', '2024-03-22', 22),
('Calle W #654', 'Entregado', '2024-03-23', 23),
('Pasaje X #789', 'Pendiente', '2024-03-24', 24),
('Avenida Y #123', 'Finalizado', '2024-03-25', 25);


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

-- inserciones de la tabla detalle pedidos
INSERT INTO tb_detalle_pedidos (cantidad_pedido, precio_pedido, id_pedido, id_producto) VALUES 
(2, 199.98, 1, 1),
(1, 39.99, 2, 2),
(3, 89.97, 3, 3),
(1, 79.99, 4, 4),
(4, 79.96, 5, 5);
-- Agregar más inserciones si es necesario
