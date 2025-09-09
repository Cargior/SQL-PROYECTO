drop table nomina;

-- crear base de datos--	
create database Call_center;

-- seleccionar la BBDD--
use Call_center;

-- creación de tablas --
-- Tabla: Servicios--
CREATE TABLE Servicios (
    servicio VARCHAR(100) PRIMARY KEY
);

-- Tabla: Nomina--
CREATE TABLE Nomina (
    Legajo INT PRIMARY KEY,
    usuario VARCHAR(10) UNIQUE,
    Estado VARCHAR(100),
    fecha_ingreso DATE,
    fecha_de_alta DATE,
    hora_ingreso TIME,
    hora_egreso TIME,
    franco_1 VARCHAR(20),
    franco_2 VARCHAR(10),
    servicio VARCHAR(100),
    mail VARCHAR(100),
    FOREIGN KEY (servicio) REFERENCES Servicios(servicio),
    INDEX idx_servicio_nomina (servicio)
);

-- Tabla: Conexiones_al_sistema --
CREATE TABLE Conexiones_al_sistema (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(10),
    conexion DATETIME,
    desconexion DATETIME,
    horas_de_conexion TIME,
    servicio VARCHAR(100),
    FOREIGN KEY (usuario) REFERENCES Nomina(usuario),
    INDEX idx_usuario_conexiones (usuario),
    INDEX idx_conexion_fecha (conexion),
    INDEX idx_servicio_conexiones (servicio)
);

-- Tabla: Justificados --
CREATE TABLE Justificados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Legajo INT,
    Fecha DATE,
    Motivo_Ausencia VARCHAR(100),
    FOREIGN KEY (Legajo) REFERENCES Nomina(Legajo),
    INDEX idx_legajo_justificados (Legajo),
    INDEX idx_fecha_justificados (Fecha),
    INDEX idx_motivo_justificados (Motivo_Ausencia)
);

-- Tabla: Planificado --
CREATE TABLE Planificado (
    FECHA DATE,
    FRANJA_HORARIA TIME,
    SERVICIO VARCHAR(100),
    CANTIDAD_DE_PERSONAS INT,
    PRIMARY KEY (FECHA, FRANJA_HORARIA, SERVICIO),
    FOREIGN KEY (SERVICIO) REFERENCES Servicios(servicio),
    INDEX idx_fecha_planificado (FECHA),
    INDEX idx_servicio_planificado (SERVICIO)
);

-- Tabla: Requerido --
CREATE TABLE Requerido (
    FECHA DATE,
    FRANJA_HORARIA TIME,
    SERVICIO VARCHAR(100),
    CANTIDAD_DE_PERSONAS INT,
    PRIMARY KEY (FECHA, FRANJA_HORARIA, SERVICIO),
    FOREIGN KEY (SERVICIO) REFERENCES Servicios(servicio),
    INDEX idx_fecha_requerido (FECHA),
    INDEX idx_servicio_requerido (SERVICIO)
);

-- Tabla: lay_out --
CREATE TABLE lay_out (
    SERVICIO VARCHAR(100) PRIMARY KEY,
    PISO VARCHAR(50),
    Q__PA_ASIGNADAS INT,
    FOREIGN KEY (SERVICIO) REFERENCES Servicios(servicio)
);
