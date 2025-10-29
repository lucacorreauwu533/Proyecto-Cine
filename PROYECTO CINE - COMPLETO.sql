-- BASE DE DATOS - PROYECTO CINE :D

-- CREACIÓN DDL

DROP DATABASE IF EXISTS ProyectoCine;
CREATE DATABASE IF NOT EXISTS ProyectoCine;
USE ProyectoCine;

CREATE TABLE Cine ( -- Creación de la tabla CINE
    ID_Cine INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL, 
    Direccion VARCHAR(50),
    Telefono VARCHAR(20)
);

CREATE TABLE Sala ( -- Creación de la tabla SALA
    ID_Sala INT AUTO_INCREMENT PRIMARY KEY,
    Numero_Sala INT NOT NULL,
    Tipo_Sala VARCHAR(50),
    Capacidad INT,
    ID_Cine INT,
    FOREIGN KEY (ID_Cine) REFERENCES Cine(ID_Cine)
);

CREATE TABLE Pelicula ( -- Creación de la tabla PELICULA
    ID_Pelicula INT AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(100) NOT NULL,
    Duracion INT,
    Genero VARCHAR(20),
    Calificacion VARCHAR(10),
    Distribuidora VARCHAR(50),
    Pais_De_Origen VARCHAR(50),
    Fecha_Estreno DATE
);

CREATE TABLE Programacion ( -- Creación de la tabla PROGRAMACIÓN
    ID_Programacion INT AUTO_INCREMENT PRIMARY KEY,
    Responsable VARCHAR(50),
    Descripcion VARCHAR(100),
    Estado VARCHAR(20),
    Fecha_Creacion DATE,
    Fecha_Inicio DATE,
    Fecha_Fin DATE
);

CREATE TABLE Funcion ( -- Creación de la tabla FUNCION
    ID_Funcion INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE,
    Hora_Inicio TIME,
    Duracion INT,
    Tipo_Funcion VARCHAR(50),
    Estado VARCHAR(20),
    ID_Pelicula INT,
    ID_Sala INT,
    ID_Programacion INT,
    FOREIGN KEY (ID_Pelicula) REFERENCES Pelicula(ID_Pelicula),
    FOREIGN KEY (ID_Sala) REFERENCES Sala(ID_Sala),
    FOREIGN KEY (ID_Programacion) REFERENCES Programacion(ID_Programacion)
);

 -- Para añadir la FK con Funcion a la entidad de Programación, evitando errores.
ALTER TABLE Programacion
ADD COLUMN ID_Funcion INT;

ALTER TABLE Programacion
ADD FOREIGN KEY (ID_Funcion) REFERENCES Funcion(ID_Funcion);

CREATE TABLE Entrada ( -- Creación de la tabla ENTRADA
    ID_Entrada INT AUTO_INCREMENT PRIMARY KEY,
    Numero_Venta INT NOT NULL,
    Fecha_Venta DATE,
    Fecha_Hora_Funcion DATETIME,
    Precio_Cobrado DECIMAL(10,2),
    Estado VARCHAR(20),
    ID_Funcion INT,
    FOREIGN KEY (ID_Funcion) REFERENCES Funcion(ID_Funcion)
);

CREATE TABLE Tipo_Entrada ( -- Creación de la tabla TIPO ENTRADA
    ID_Tipo_Entrada INT AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(50),
    ID_Entrada INT, FOREIGN KEY (ID_Entrada) REFERENCES Entrada(ID_Entrada)
);

-- Para añadir la FK de Tipo de Entrada a la entidad Entrada
ALTER TABLE Entrada
ADD COLUMN ID_Tipo_Entrada INT;

ALTER TABLE Entrada
ADD FOREIGN KEY (ID_Tipo_Entrada) REFERENCES Tipo_Entrada(ID_Tipo_Entrada);

CREATE TABLE Precio ( -- Creación de la tabla PRECIO
    ID_Precio INT AUTO_INCREMENT PRIMARY KEY,
    Precio_Final DECIMAL(10,2),
    ID_Tipo_Entrada INT, FOREIGN KEY (ID_Tipo_Entrada) REFERENCES Tipo_Entrada(ID_Tipo_Entrada)
);

-------------------------------------------------------------------------------------------------------

-- CREACIÓN DML

-- Insertar valores a las tablas creadas

-- Valores para la tabla de Cine
INSERT INTO Cine (Nombre, Direccion, Telefono)
VALUES
('Cinemark Caballito', 'Av. La Plata 96', '1123458795'),
('Cinemark Abasto', 'Av. Corrientes 3247', '1129845670');

-- Valores para la tabla de Sala
INSERT INTO Sala (Numero_Sala, Tipo_Sala, Capacidad, ID_Cine)
VALUES
(1, '3D', 120, 1),
(2, '2D', 90, 1),
(1, 'IMAX', 200, 2);

-- Valores para la tabla de Pelicula
INSERT INTO Pelicula (Titulo, Duracion, Genero, Calificacion, Distribuidora, Pais_De_Origen, Fecha_Estreno)
VALUES
('La razón de estar contigo', 120, 'Comedia', 'ATP', 'Universal Pictures Home Entertainment', 'EEUU', '2017-02-02'),
('Star Wars: El ascenso de Skywalker', 142, 'Ciencia Ficción', '+16', 'Walt Disney Studios Motion Pictures', 'EEUU', '2019-12-19'),
('Intensamente 2', 96, 'Animación', 'ATP', 'Walt Disney Studios Motion Pictures', 'EEUU', '2024-06-10'),
('Wicked', 160, 'Musical', 'ATP', 'Universal Studios', 'EEUU', '2024-11-22'),
('El Conjuro 4', 135, 'Terror', '+16', 'Warner Bros. Pictures', 'EEUU', '2025-09-05'),
('Los 4 Fantasticos: Primeros Pasos', 115, 'Ciencia Ficción', '+13', 'Walt Disney Studios Motion Pictures', 'EEUU', '2025-07-24');

-- Valores para la tabla de Programación
INSERT INTO Programacion (Responsable, Descripcion, Estado, Fecha_Creacion, Fecha_Inicio, Fecha_Fin)
VALUES
('Jairo Vivar', 'Responsable de la semana del 15 al 21 de Octubre', 'Activa', '2025-10-14', '2025-10-15', '2025-10-25');

-- Valores para la tabla de Funcion
INSERT INTO Funcion (Fecha, Hora_Inicio, Duracion, Tipo_Funcion, Estado, ID_Pelicula, ID_Sala, ID_Programacion)
VALUES
('2025-10-17', '18:00:00', 190, 'Estreno', 'Activa', 1, 1, 1),
('2025-10-17', '20:30:00', 100, 'Normal', 'Activa', 2, 2, 1),
('2025-10-18', '22:00:00', 120, 'Preestreno', 'Activa', 3, 3, 1),
('2025-10-19', '23:00:00', 145, 'Normal', 'Activa', 4, 1, 1),
('2025-10-20', '19:30:00', 117, 'Reestreno', 'Activa', 5, 2, 1),
('2025-10-21', '17:00:00', 100, 'Infantil', 'Activa', 6, 3, 1);

-- Valores para la tabla de Tipo de Entrada
INSERT INTO Tipo_Entrada (Descripcion)
VALUES
('Mayor'),
('Menor'),
('Jubilado');

-- Valores para la tabla de Precio
INSERT INTO Precio (Precio_Final, ID_Tipo_Entrada)
VALUES
(15000.00, 1),
(13000.00, 2),
(10000.00, 3);

-- Valores para la tabla de Entrada
INSERT INTO Entrada (Numero_Venta, Fecha_Venta, Fecha_Hora_Funcion, Precio_Cobrado, Estado, ID_Funcion, ID_Tipo_Entrada)
VALUES
(1001, '2025-10-16', '2025-10-17 18:00:00', 15000.00, 'Vendida', 1, 1),
(1002, '2025-10-16', '2025-10-17 20:30:00', 13000.00, 'Vendida', 2, 2),
(1003, '2025-10-17', '2025-10-18 22:00:00', 10000.00, 'Reservada', 3, 3),
(1004, '2025-10-18', '2025-10-19 23:00:00', 15000.00, 'Vendida', 4, 1),
(1005, '2025-10-19', '2025-10-20 19:30:00', 15000.00, 'Vendida', 5, 1),
(1006, '2025-10-20', '2025-10-21 17:00:00', 13000.00, 'Vendida', 6, 2);

-- Consultas :3

-- Consulta N°1: Listar todas las películas con su calificación y país de origen
SELECT Titulo, Calificacion, Pais_De_Origen
FROM Pelicula;

-- Consulta N°2: Mostrar las funciones programadas con su sala y tipo de función
SELECT F.ID_Funcion, P.Titulo, S.Numero_Sala, F.Tipo_Funcion, F.Fecha, F.Hora_Inicio
FROM Funcion F
JOIN Pelicula P ON F.ID_Pelicula = P.ID_Pelicula
JOIN Sala S ON F.ID_Sala = S.ID_Sala;

-- Consulta N°3: Mostrar todas las entradas vendidas con datos de película y función
SELECT E.Numero_Venta, P.Titulo, F.Fecha, F.Hora_Inicio, E.Precio_Cobrado, E.Estado
FROM Entrada E
JOIN Funcion F ON E.ID_Funcion = F.ID_Funcion
JOIN Pelicula P ON F.ID_Pelicula = P.ID_Pelicula;

-- Consulta N°4: Listar todas las películas disponibles para menores (Apta para todo público)
SELECT Titulo, Genero, Calificacion
FROM Pelicula
WHERE Calificacion = 'ATP';

-- Consulta N°5: Mostrar qué funciones admiten entradas solo para mayores de 16
SELECT F.ID_Funcion, P.Titulo, P.Calificacion
FROM Funcion F
JOIN Pelicula P ON F.ID_Pelicula = P.ID_Pelicula
WHERE P.Calificacion = '+16';

-- Consulta N°6: Ver las funciones que pertenecen a la programación activa
SELECT F.ID_Funcion, P.Titulo, Prog.Descripcion, Prog.Estado
FROM Funcion F
JOIN Pelicula P ON F.ID_Pelicula = P.ID_Pelicula
JOIN Programacion Prog ON F.ID_Programacion = Prog.ID_Programacion
WHERE Prog.Estado = 'Activa';

-- Consulta N°7: Mostrar la recaudación total dada por tipo de entrada
SELECT T.Descripcion AS Tipo_Entrada, SUM(E.Precio_Cobrado) AS Total_Recaudado
FROM Entrada E
JOIN Tipo_Entrada T ON E.ID_Tipo_Entrada = T.ID_Tipo_Entrada
GROUP BY T.Descripcion;

-- Consulta N°8: Mostrar todas las funciones del Cine Caballito
SELECT C.Nombre AS Cine, S.Numero_Sala, P.Titulo, F.Fecha, F.Hora_Inicio
FROM Funcion F
JOIN Sala S ON F.ID_Sala = S.ID_Sala
JOIN Cine C ON S.ID_Cine = C.ID_Cine
JOIN Pelicula P ON F.ID_Pelicula = P.ID_Pelicula
WHERE C.Nombre = 'Cinemark Caballito';

-- Consulta N°9: Listar películas que duran más de 2 horas
SELECT Titulo, Duracion
FROM Pelicula
WHERE Duracion > 120;

-- Consulta N°10: Mostrar la cantidad total de entradas vendidas por función
SELECT F.ID_Funcion, P.Titulo, COUNT(E.ID_Entrada) AS Cantidad_Vendida
FROM Funcion F
JOIN Pelicula P ON F.ID_Pelicula = P.ID_Pelicula
JOIN Entrada E ON F.ID_Funcion = E.ID_Funcion
WHERE E.Estado = 'Vendida'
GROUP BY F.ID_Funcion, P.Titulo;

-- Consulta N°11: Precio con descuento para jubilado o para menores.
SELECT 
    E.Numero_Venta, -- Número único de la venta de entrada
    P.Titulo, -- Titulo de la pelicula
    T.Descripcion AS Tipo_Entrada, -- T.Descripcion es el Tipo de Entrada (si es jubilado o menor)
    E.Precio_Cobrado AS Precio_Original, -- El precio original de la venta
    CASE 
        WHEN T.Descripcion = 'Jubilado' THEN E.Precio_Cobrado * 0.90  -- 10% de descuento para los jubilados
        WHEN T.Descripcion = 'Menor' THEN E.Precio_Cobrado * 0.95     -- 5% de descuento para los menores
        ELSE E.Precio_Cobrado                                           -- Para los mayores, sin descuento
    END AS Precio_Con_Descuento,
    E.Estado -- Muestra si la entrada esta vendida o reservada.
FROM Entrada E -- Une Entrada con Tipo de Entrada, la Funcion y la Pelicula :3
JOIN Tipo_Entrada T ON E.ID_Tipo_Entrada = T.ID_Tipo_Entrada
JOIN Funcion F ON E.ID_Funcion = F.ID_Funcion
JOIN Pelicula P ON F.ID_Pelicula = P.ID_Pelicula;
