drop table nomina;

-- crear base de datos--	
create database Call_center;

-- seleccionar la BBDD--
use Call_center;

-- creación de las tablas--
-- Tabla: Servicios
CREATE TABLE Servicios (
    servicio VARCHAR(100) PRIMARY KEY
);

-- Tabla: Nomina (referencia a Servicios)
CREATE TABLE Nomina (
    Legajo INT PRIMARY KEY,
    usuario VARCHAR(10) NOT NULL UNIQUE,
    Estado VARCHAR(100) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_de_alta DATE NOT NULL,
    hora_ingreso TIME NOT NULL,
    hora_egreso TIME NOT NULL,
    franco_1 VARCHAR(20),
    franco_2 VARCHAR(10),
    servicio VARCHAR(100) NOT NULL,
    mail VARCHAR(100) NOT NULL,
    FOREIGN KEY (servicio) REFERENCES Servicios(servicio)
);

-- Tabla: Planificado (referencia válida)
CREATE TABLE Planificado (
    FECHA DATE NOT NULL,
    FRANJA_HORARIA TIME NOT NULL,
    SERVICIO VARCHAR(100) NOT NULL,
    CANTIDAD_DE_PERSONAS INT NOT NULL,
    PRIMARY KEY (FECHA, FRANJA_HORARIA, SERVICIO),
    FOREIGN KEY (SERVICIO) REFERENCES Servicios(servicio)
);

-- Tabla: Requerido
CREATE TABLE Requerido (
    FECHA DATE NOT NULL,
    FRANJA_HORARIA TIME NOT NULL,
    SERVICIO VARCHAR(100) NOT NULL,
    CANTIDAD_DE_PERSONAS INT NOT NULL,
    PRIMARY KEY (FECHA, FRANJA_HORARIA, SERVICIO),
    FOREIGN KEY (SERVICIO) REFERENCES Servicios(servicio)
);

-- Tabla: Requerido_servicio
CREATE TABLE lay_out (
    SERVICIO VARCHAR(100) PRIMARY KEY,
    PISO VARCHAR(50) NOT NULL,
    Q__PA_ASIGNADAS INT NOT NULL,
    FOREIGN KEY (SERVICIO) REFERENCES Servicios(servicio)
);

-- Tabla: Justificados (modificada)
CREATE TABLE Justificados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Legajo INT NOT NULL,
    Fecha DATE NOT NULL,
    Motivo_Ausencia VARCHAR(100) NOT NULL,
    FOREIGN KEY (Legajo) REFERENCES Nomina(Legajo)
);
