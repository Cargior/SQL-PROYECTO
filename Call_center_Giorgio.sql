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

-- Crear tabla de motivos de certificados
CREATE TABLE Motivos_certificados (
    codigo VARCHAR(10) PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    penalidad BOOLEAN DEFAULT FALSE,
    requiere_documentacion BOOLEAN DEFAULT TRUE
);

-- Modificar tabla Justificados
-- Paso 1: Renombrar columna actual (opcional para preservar datos)
ALTER TABLE Justificados RENAME COLUMN Motivo_Ausencia TO motivo_texto_original;

-- Paso 2: Agregar nueva columna con FK
ALTER TABLE Justificados ADD COLUMN codigo_motivo VARCHAR(10);
ALTER TABLE Justificados ADD CONSTRAINT fk_codigo_motivo FOREIGN KEY (codigo_motivo) REFERENCES Motivos_certificados(codigo);

-- Carga de motivos de justificados --
INSERT INTO Motivos_certificados (codigo, descripcion, penalidad, requiere_documentacion) VALUES
('ENF', 'Enfermedad', FALSE, TRUE),
('EF', 'Familiar enfermo', FALSE, TRUE),
('DE', 'Día de examen', TRUE, FALSE),
('VAC', 'Vacaciones', FALSE, FALSE),
('TRN', 'Trámite', TRUE, FALSE);

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
  
    -- insertar valores servicio --


INSERT INTO Servicios (servicio)
VALUES ('RETENCION CABLE');



-- insertar valores nomina --

INSERT INTO Nomina (Legajo, usuario, Estado, fecha_ingreso, fecha_de_alta, hora_ingreso, hora_egreso, franco_1, franco_2, servicio, mail)
VALUES
(202600, 'U561875', 'ACTIVO TELETRABAJO', '2013/04/22', '2013/04/22', '08:30:00', '14:30:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'U561875@CAT-TECHNOLOGIES.COM'),
(8979, 'U614832', 'ACTIVO ON SITE', '2014/04/07', '2014/04/07', '15:00:00', '21:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'JECANAS@CAT-TECHNOLOGIES.COM'),
(205849, 'U578398', 'ACTIVO ON SITE', '2015/03/09', '2015/03/09', '08:00:00', '14:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'MATABORDA@CAT-TECHNOLOGIES.COM'),
(9739, 'U614946', 'ACTIVO TELETRABAJO', '2016/03/01', '2016/03/01', '08:30:00', '14:30:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'DTAPIA@CAT-TECHNOLOGIES.COM'),
(14898, 'U626769', 'ACTIVO TELETRABAJO', '2019/10/21', '2019/10/21', '08:00:00', '14:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'U626769@CAT-TECHNOLOGIES.COM'),
(14935, 'U625958', 'ACTIVO ON SITE', '2019/11/04', '2019/11/04', '09:00:00', '15:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'U625958@CAT-TECHNOLOGIES.COM'),
(16894, 'u921825', 'ACTIVO ON SITE', '2021/12/15', '2021/12/15', '09:00:00', '15:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'gfmaldonado@cat-technologies.com'),
(17911, 'u925305', 'ACTIVO TELETRABAJO', '2022/04/12', '2022/04/12', '08:00:00', '14:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'mbenitez@cat-technologies.com'),
(19891, 'u932961', 'ACTIVO TELETRABAJO', '2023/01/23', '2023/01/23', '08:30:00', '14:30:00', 'Domingo', 'Lunes', 'RETENCION CABLE', 'ndiaz@cat-technologies.com'),
(17988, 'u925873', 'ACTIVO ON SITE', '2022/04/26', '2022/04/26', '09:00:00', '15:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'waleman@cat-technologies.com'),
(18259, 'u927123', 'ACTIVO TELETRABAJO', '2022/06/23', '2022/06/23', '09:00:00', '15:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'mquiroga@cat-technologies.com'),
(18640, 'u928572', 'ACTIVO TELETRABAJO', '2022/08/10', '2022/08/10', '09:00:00', '15:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'lmsanchez@cat-technologies.com'),
(18741, 'u928733', 'ACTIVO TELETRABAJO', '2022/08/24', '2022/08/24', '15:00:00', '20:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'jlgomez@cat-technologies.com'),
(18999, 'u929678', 'ACTIVO TELETRABAJO', '2022/09/22', '2022/09/22', '08:30:00', '14:30:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'SGUERZOARU17@GMAIL.COM'),
(19102, 'u930002', 'ACTIVO ON SITE', '2022/10/03', '2022/10/03', '08:00:00', '14:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'fcoria@cat-technologies.com'),
(19879, 'u932906', 'ACTIVO TELETRABAJO', '2023/01/19', '2023/01/19', '09:00:00', '15:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'gaguirre@cat-technologies.com'),
(20666, 'u934788', 'ACTIVO ON SITE', '2023/05/02', '2023/05/02', '15:00:00', '21:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', ''),
(21115, 'u936818', 'ACTIVO TELETRABAJO', '2023/10/19', '2023/10/19', '09:00:00', '15:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', ''),
(21354, 'u938103', 'ACTIVO TELETRABAJO', '2023/12/20', '2023/12/20', '08:00:00', '14:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'aaavila@cat-technologies.com'),
(21472, 'u938619', 'ACTIVO TELETRABAJO', '2024/01/02', '2024/01/02', '15:00:00', '21:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'abromero@cat-technologies.com'),
(21590, 'u939164', 'ACTIVO ON SITE', '2024/01/10', '2024/01/10', '09:00:00', '15:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'laescobar@cat-technologies.com'),
(21802, 'u939690', 'ACTIVO TELETRABAJO', '2024/01/25', '2024/01/25', '16:00:00', '22:00:00', 'Domingo', 'Viernes', 'RETENCION CABLE', 'fjsantoro@cat-technologies.com'),
(21810, 'u939700', 'ACTIVO ON SITE', '2024/01/25', '2024/01/25', '16:00:00', '22:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'apboscoscuro@cat-technologies.com'),
(15357, 'u939746', 'ACTIVO TELETRABAJO', '2020/09/01', '2020/09/01', '08:00:00', '14:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'mcastiglione@cat-technologies.com'),
(21829, 'u939751', 'ACTIVO TELETRABAJO', '2024/01/25', '2024/01/25', '09:00:00', '15:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'merios@cat-technologies.com'),
(21823, 'u939771', 'ACTIVO ON SITE', '2024/01/25', '2024/01/25', '15:00:00', '21:00:00', 'Domingo', 'Lunes', 'RETENCION CABLE', 'lmgutierrez@cat-technologies.com'),
(19795, 'u935107', 'ACTIVO TELETRABAJO', '2023/01/10', '2023/01/10', '08:00:00', '14:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'mjaquet@cat-technologies.com'),
(23203, 'u402299', 'ACTIVO ON SITE', '2024/12/23', '2024/12/23', '15:00:00', '21:00:00', 'Domingo', 'Martes', 'RETENCION CABLE', ''),
(22853, 'u401134', 'ACTIVO ON SITE', '2024/11/07', '2024/11/07', '15:00:00', '21:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'nicarbajal@cat-technologies.com'),
(22858, 'u401139', 'ACTIVO ON SITE', '2024/11/07', '2024/11/07', '15:00:00', '21:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'rslopez@cat-technologies.com'),
(22862, 'u401143', 'ACTIVO TELETRABAJO', '2024/11/07', '2024/11/07', '16:00:00', '22:00:00', 'Sábado', 'Domingo', 'RETENCION CABLE', 'mamenalled@cat-technologies.com'),
(22930,'u401401','ACTIVO ON SITE','2024-11-25','2024-11-25','08:00:00','14:00:00','Sábado','Domingo','RETENCION CABLE','cbalda@cat-technologies.com'),
(22913,'u401332','ACTIVO ON SITE','2024-11-24','2024-11-24','15:00:00','21:00:00','Lunes','Viernes','RETENCION CABLE','wdgutierrez@cat-technologies.com'),
(22915,'u401334','ACTIVO TELETRABAJO','2024-11-24','2024-11-24','16:00:00','22:00:00','Lunes','Viernes','RETENCION CABLE','cmapaza@cat-technologies.com'),
(22919,'u401338','ACTIVO ON SITE','2024-11-24','2024-11-24','15:00:00','21:00:00','Lunes','Viernes','RETENCION CABLE','sgfuentes@cat-technologies.com'),
(22622,'u400345','ACTIVO ON SITE','2024-09-11','2024-09-11','08:00:00','14:00:00','Sábado','Domingo','RETENCION CABLE','camagan@cat-technologies.com'),
(23319,'u403012','ACTIVO ON SITE','2025-01-21','2025-01-21','08:00:00','14:00:00','Sábado','Domingo','RETENCION CABLE','svjuarez@cat-technologies.com'),
(23551,'U403568','ACTIVO ON SITE','2025-02-12','2025-02-12','09:00:00','15:00:00','Sábado','Domingo','RETENCION CABLE','svjuarez@cat-technologies.com'),
(23569,'U403586','ACTIVO TELETRABAJO','2025-02-12','2025-02-12','16:00:00','22:00:00','Sábado','Domingo','RETENCION CABLE','svjuarez@cat-technologies.com'),
(23553,'U403570','ACTIVO ON SITE','2025-02-12','2025-02-12','08:00:00','14:00:00','Sábado','Domingo','RETENCION CABLE','svjuarez@cat-technologies.com'),
(23848,'u405126','ACTIVO ON SITE','2025-06-17','2025-06-17','09:00:00','15:00:00','Jueves','Viernes','RETENCION CABLE','aamontenegro@cat-technologies.com'),
(23849,'u405127','ACTIVO ON SITE','2025-06-17','2025-06-17','08:00:00','14:00:00','Jueves','Viernes','RETENCION CABLE','effiguere@cat-technologies.com'),
(23852,'u405130','ACTIVO ON SITE','2025-06-17','2025-06-17','16:00:00','22:00:00','Jueves','Viernes','RETENCION CABLE','arsilva@cat-technologies.com'),
(23854,'u405132','ACTIVO ON SITE','2025-06-17','2025-06-17','16:00:00','22:00:00','Jueves','Viernes','RETENCION CABLE','rfmacias@cat-technologies.com'),
(23905,'u405397','ACTIVO ON SITE','2025-07-03','2025-07-03','15:00:00','21:00:00','Domingo','Lunes','RETENCION CABLE','lfarfaro@cat-technologies.com'),
(23906,'u405398','ACTIVO ON SITE','2025-07-03','2025-07-03','15:00:00','21:00:00','Domingo','Lunes','RETENCION CABLE','zlsperanza@cat-technologies.com'),
(23909,'u405401','ACTIVO ON SITE','2025-07-03','2025-07-03','16:00:00','22:00:00','Domingo','martes','RETENCION CABLE','ftvargas@cat-technologies.com'),
(23910,'u405402','ACTIVO ON SITE','2025-07-03','2025-07-03','16:00:00','22:00:00','Domingo','Miércoles','RETENCION CABLE','daaguero@cat-technologies.com'),
(23912,'u405404','ACTIVO ON SITE','2025-07-03','2025-07-03','16:00:00','22:00:00','Domingo','Miércoles','RETENCION CABLE','lgrios@cat-technologies.com');
-- carga de tabla conexiones al sistema --
-- Se adjunta CVS en GITHUB--
-- carga de tabla requerido --
-- Se adjunta CVS en GITHUB--

-- crea tabla horas por franja --
CREATE TABLE horas_por_franja (
    usuario VARCHAR(10) NOT NULL,
    servicio VARCHAR(100) NOT NULL, -- FK → Servicios(servicio)
    fecha DATE NOT NULL,
    franja_inicio DATETIME NOT NULL,
    franja_fin DATETIME NOT NULL,
    minutos_conectados INT DEFAULT 0,
    CONSTRAINT PK_horas_por_franja PRIMARY KEY (usuario, fecha, franja_inicio, servicio)
);

-- crea el store procedure para dividir por franjas las conexiones trayendo el servicio por usuario--
DELIMITER $$

CREATE PROCEDURE sp_generar_horas_por_franja()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE fecha_actual DATE;

    DECLARE cur CURSOR FOR
        SELECT DISTINCT DATE(conexion) FROM Conexiones_al_sistema;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO fecha_actual;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET @franja_inicio = CONCAT(fecha_actual, ' 00:00:00');
        WHILE @franja_inicio < CONCAT(DATE_ADD(fecha_actual, INTERVAL 1 DAY), ' 00:00:00') DO
            SET @franja_fin = DATE_ADD(@franja_inicio, INTERVAL 30 MINUTE);

            -- Insertar minutos conectados
            INSERT INTO horas_por_franja (usuario, servicio, fecha, franja_inicio, franja_fin, minutos_conectados)
            SELECT
                n.usuario,
                n.servicio,
                fecha_actual,
                @franja_inicio,
                @franja_fin,
                SUM(
                    TIMESTAMPDIFF(
                        MINUTE,
                        GREATEST(c.conexion, @franja_inicio),
                        LEAST(c.desconexion, @franja_fin)
                    )
                ) AS minutos_conectados
            FROM Conexiones_al_sistema c
            JOIN Nomina n ON c.usuario = n.usuario
            WHERE c.conexion < @franja_fin AND c.desconexion > @franja_inicio
            GROUP BY n.usuario, n.servicio;

            -- Insertar 0 minutos si no hubo conexión
            INSERT INTO horas_por_franja (usuario, servicio, fecha, franja_inicio, franja_fin, minutos_conectados)
            SELECT
                n.usuario,
                n.servicio,
                fecha_actual,
                @franja_inicio,
                @franja_fin,
                0
            FROM Nomina n
            WHERE NOT EXISTS (
                SELECT 1
                FROM Conexiones_al_sistema c
                WHERE c.usuario = n.usuario
                  AND c.conexion < @franja_fin
                  AND c.desconexion > @franja_inicio
            );

            SET @franja_inicio = @franja_fin;
        END WHILE;
    END LOOP;

    CLOSE cur;
END$$

DELIMITER 
-- muestra el resultado del store procedure --
CALL sp_generar_horas_por_franja();

-- Vista horas por franja --
CREATE VIEW vista_total_horas_por_franja AS
SELECT
    fecha,
    franja_inicio,
    franja_fin,
    ROUND(SUM(minutos_conectados) / 60, 2) AS total_horas
FROM horas_por_franja
GROUP BY fecha, franja_inicio, franja_fin
ORDER BY fecha, franja_inicio;
-- ver vista horas por franja --
select * from vista_total_horas_por_franja;

-- Vista horas por empleados --
CREATE VIEW vista_total_por_empleado AS
SELECT
    fecha,
    usuario,
    ROUND(SUM(minutos_conectados) / 60, 2) AS total_horas
FROM horas_por_franja
GROUP BY fecha, usuario
ORDER BY usuario;

-- ver vista horas por franja --
select * from vista_total_por_empleado;


-- Carga de un certificado --

INSERT INTO Justificados (id, Legajo, Fecha, codigo_motivo)
VALUES (1, 22622, '2025-09-02', 'ENF'); -- 'ENF' sería el código en Motivos_certificados


-- store procedure para estandarizar la carga de justificados --
DELIMITER $$

CREATE PROCEDURE sp_insertar_justificacion_con_usuario (
    IN p_legajo INT,
    IN p_fecha DATE,
    IN p_codigo_motivo VARCHAR(10),
    IN p_usuario_carga VARCHAR(50)
)
BEGIN
    DECLARE v_exists_legajo INT;
    DECLARE v_exists_motivo INT;
    DECLARE v_penalidad BOOLEAN;
    DECLARE v_documentacion BOOLEAN;

    -- Validar existencia del legajo
    SELECT COUNT(*) INTO v_exists_legajo
    FROM Nomina
    WHERE Legajo = p_legajo;

    -- Validar existencia del motivo
    SELECT COUNT(*) INTO v_exists_motivo
    FROM Motivos_certificados
    WHERE codigo = p_codigo_motivo;

    -- Si ambos existen, continuar
    IF v_exists_legajo > 0 AND v_exists_motivo > 0 THEN

        -- Obtener atributos del motivo
        SELECT penalidad, requiere_documentacion
        INTO v_penalidad, v_documentacion
        FROM Motivos_certificados
        WHERE codigo = p_codigo_motivo;

        -- Insertar justificación
        INSERT INTO Justificados (Legajo, Fecha, codigo_motivo, usuario_carga)
        VALUES (p_legajo, p_fecha, p_codigo_motivo, p_usuario_carga);

        -- Mostrar mensaje
        SELECT CONCAT(
            'Justificación registrada por ', p_usuario_carga,
            '. Penalidad: ', IF(v_penalidad, 'Sí', 'No'),
            '. Requiere documentación: ', IF(v_documentacion, 'Sí', 'No'),
            '.'
        ) AS mensaje_resultado;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Legajo o motivo no válido.';
    END IF;
END $$

DELIMITER ;


-- modifica la tabla justificados para cargar el usuario que realiza la carga --
	ALTER TABLE Justificados ADD COLUMN usuario_carga VARCHAR(50);

-- ejecuta carga ejemplo --
CALL sp_insertar_justificacion_con_usuario('22853', '2025-09-07', 'DE', 'csgiorgio');

-- sotore procedure para presentismo --
DELIMITER $$

CREATE PROCEDURE sp_estado_presentismo_por_fecha (
    IN p_fecha DATE
)
BEGIN
    SELECT 
        n.Legajo,
        n.usuario,
        n.servicio,
        COALESCE(
            CASE 
                WHEN c.usuario IS NOT NULL THEN 'Conectado'
                WHEN j.codigo_motivo IS NOT NULL THEN mc.descripcion
                ELSE 'AI'
            END,
            'AI'
        ) AS estado,
        c.conexion,
        c.desconexion,
        j.Fecha AS fecha_justificada,
        j.codigo_motivo,
        j.usuario_carga
    FROM Nomina n
    LEFT JOIN (
        SELECT usuario, MIN(conexion) AS conexion, MAX(desconexion) AS desconexion
        FROM Conexiones_al_sistema
        WHERE DATE(conexion) = p_fecha
        GROUP BY usuario
    ) c ON n.usuario = c.usuario
    LEFT JOIN Justificados j ON n.Legajo = j.Legajo AND j.Fecha = p_fecha
    LEFT JOIN Motivos_certificados mc ON j.codigo_motivo = mc.codigo;
END $$

DELIMITER ;

-- ejecución --
CALL sp_estado_presentismo_por_fecha('2025-09-07');