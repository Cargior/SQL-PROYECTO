
# 📘 Documentación del Esquema de Base de Datos: `call Center Carlos Giorgio`

## 🧱 introducción

A continuación se detallara las tablas y datos necesarios para poder aplicar un gestor de Nomina para un call center.

## 🧱 Objetivo

Ordenar y mantener una base de datos que permita no solo seguir el presentismo de los empleados, sino tambien obtener datos de la ocupación de los pisos, penalidades por servicio, metricas como ausentismo por motivo y por periodo, etc.

## 🧱 situación problematica

Actualmente el call center no posee una base de datos ordenada que permita hacer un seguimiento del presentismo de los empleados. Como concecuencia trae aparejados problemas en diferentes sectores como por ejemplo RRHH, planificación de site, liquidación de sueldos. 

## 🧱 Modelo de negocio

El mismo se basa en lograr tener la cantidad de operadores necesario segun la necesidad de cada cliente. Para esto es necesario lograr tener un seguimiento de las metricas que afectan al objetivo de lograr la eficiencia no solo en las horas pagas, sino en tener la cantidad de posiciones necesarias, y la cantidad de gente sentada de acuerdo a la planificación enviada por nuestros clientes.

## 🧱 Estructura General

Este esquema gestiona información de empleados, sus conexiones al sistema, ausencias justificadas, planificación de personal, requerimientos operativos por servicio y ocupación de los pisos que posee la empresa.

---

## 🧑‍💼 Tabla: Nomina
Contiene los datos principales de cada empleado.

| Columna         | Tipo        | Descripción                              |
|-----------------|-------------|------------------------------------------|
| Legajo          | INT         | Identificador único del empleado (PK)    |
| usuario         | VARCHAR(10) | Alias o usuario del sistema (UNIQUE)     |
| Estado          | VARCHAR(100)| Estado laboral                           |
| fecha_ingreso   | DATE        | Fecha de ingreso al sistema              |
| fecha_de_alta   | DATE        | Fecha de alta en el servicio             |
| hora_ingreso    | TIME        | Horario de entrada                       |
| hora_egreso     | TIME        | Horario de salida                        |
| franco_1        | VARCHAR(20) | Día de franco principal                  |
| franco_2        | VARCHAR(10) | Día de franco secundario                 |
| servicio        | VARCHAR(100)| Servicio asignado                        |
| mail            | VARCHAR(100)| Correo electrónico                       |

🔗 FK: servicio → Servicios(servicio)  
📌 Índices: usuario (UNIQUE), servicio

---

## 🧾 Tabla: Servicios
Define los servicios disponibles en la organización.

| Columna   | Tipo         | Descripción              |
|-----------|--------------|--------------------------|
| servicio  | VARCHAR(100) | Nombre del servicio (PK) |

---

## 🔌 Tabla: Conexiones_al_sistema
Registra las sesiones de conexión de cada usuario.

| Columna             | Tipo        | Descripción                         |
|---------------------|-------------|-------------------------------------|
| id                  | INT         | Identificador único (PK)            |
| usuario             | VARCHAR(10) | Usuario que se conecta              |
| conexion            | DATETIME    | Fecha y hora de conexión            |
| desconexion         | DATETIME    | Fecha y hora de desconexión         |
| horas_de_conexion   | TIME        | Duración total de la sesión         |
| servicio            | VARCHAR(100)| Servicio desde el que se conecta    |

🔗 FK: usuario → Nomina(usuario)  
📌 Índices: usuario, conexion, servicio

---

## 📆 Tabla: Justificados
Registra ausencias justificadas por empleado.

| Columna           | Tipo         | Descripción                         |
|-------------------|--------------|-------------------------------------|
| id                | INT          | Identificador único (PK)            |
| Legajo            | INT          | Legajo del empleado                 |
| Fecha             | DATE         | Fecha de la ausencia                |
| Motivo_Ausencia   | VARCHAR(100) | Motivo del justificativo            |

🔗 FK: Legajo → Nomina(Legajo)  
📌 Índices: Legajo, Fecha, Motivo_Ausencia

---

## 📋 Tabla: Planificado
Define la planificación de personal por servicio y franja horaria.

| Columna               | Tipo        | Descripción                         |
|-----------------------|-------------|-------------------------------------|
| FECHA                 | DATE        | Fecha de planificación              |
| FRANJA_HORARIA        | TIME        | Franja horaria                      |
| SERVICIO              | VARCHAR(100)| Servicio planificado                |
| CANTIDAD_DE_PERSONAS  | INT         | Cantidad de personas requeridas     |

🔗 FK: SERVICIO → Servicios(servicio)  
🔑 PK compuesta: FECHA, FRANJA_HORARIA, SERVICIO  
📌 Índices: FECHA, SERVICIO

---

## 📌 Tabla: Requerido
Define los requerimientos reales por servicio y franja horaria.

| Columna               | Tipo        | Descripción                         |
|-----------------------|-------------|-------------------------------------|
| FECHA                 | DATE        | Fecha del requerimiento             |
| FRANJA_HORARIA        | TIME        | Franja horaria                      |
| SERVICIO              | VARCHAR(100)| Servicio requerido                  |
| CANTIDAD_DE_PERSONAS  | INT         | Cantidad de personas necesarias     |

🔗 FK: SERVICIO → Servicios(servicio)  
🔑 PK compuesta: FECHA, FRANJA_HORARIA, SERVICIO  
📌 Índices: FECHA, SERVICIO

---

## 🏢 Tabla: lay_out
Define características adicionales por servicio.

| Columna           | Tipo         | Descripción                         |
|-------------------|--------------|-------------------------------------|
| SERVICIO          | VARCHAR(100) | Servicio (PK)                       |
| PISO              | VARCHAR(50)  | Piso donde se presta el servicio    |
| Q__PA_ASIGNADAS   | INT          | Cantidad de PA asignadas            |

🔗 FK: SERVICIO → Servicios(servicio)


### 🕒 Tabla: horas_por_franja
Registra la cantidad de minutos conectados por usuario, servicio y franja horaria.

| Columna            | Tipo         | Descripción                                      |
|--------------------|--------------|--------------------------------------------------|
| usuario            | VARCHAR(10)  | Usuario del sistema                              |
| servicio           | VARCHAR(100) | Servicio asignado (FK → Servicios.servicio)      |
| fecha              | DATE         | Fecha de la franja                               |
| franja_inicio      | DATETIME     | Inicio de la franja de 30 minutos                |
| franja_fin         | DATETIME     | Fin de la franja de 30 minutos                   |
| minutos_conectados | INT          | Minutos conectados en esa franja (puede ser 0)   |

🔐 Clave primaria compuesta: `(usuario, fecha, franja_inicio, servicio)`  
🔗 FK: `servicio → Servicios(servicio)`

⚙️ Procedimiento Almacenado: sp_generar_horas_por_franja
Este procedimiento divide las sesiones de conexión de los empleados en franjas de 30 minutos y registra los minutos conectados por usuario, servicio y franja horaria en la tabla horas_por_franja.

📋 Tablas involucradas:
Conexiones_al_sistema: contiene los registros de conexión y desconexión por usuario.
Nomina: se utiliza para validar los usuarios y obtener el servicio asignado.
horas_por_franja: tabla destino donde se guarda el resumen por franja.
🎯 Objetivo:
Generar un resumen por usuario, servicio y franja horaria de 30 minutos, indicando cuántos minutos estuvo conectado en cada una. Si no hubo conexión en una franja, se registra igualmente con 0 minutos, asegurando que cada día tenga 48 franjas por usuario y servicio.

🧠 Lógica:
Recorre cada fecha con registros en Conexiones_al_sistema.
Divide el día en 48 franjas de 30 minutos.
Para cada franja:
Calcula los minutos conectados por usuario y servicio.
Inserta los datos en horas_por_franja.
Si no hubo conexión, inserta el registro con 0 minutos.
🧾 Ejemplo de ejecución:

CALL sp_generar_horas_por_franja();
