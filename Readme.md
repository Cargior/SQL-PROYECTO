# 📘 Documentación de la Base de Datos

## 🗂 Nombre de la Base de Datos
`CGestor de presentismo`

---

## 🧱 Estructura de Tablas

### 📄 Tabla: `Nomina`

| Columna         | Tipo de Dato   | Clave     | Descripción                          |
|-----------------|----------------|-----------|--------------------------------------|
| `Legajo`        | INT            | FK        | Identificador del empleado           |
| `usuario`       | VARCHAR(10)    | PK        | Código único del usuario             |
| `Estado`        | VARCHAR(100)   |           | Estado actual del empleado           |
| `fecha_ingreso` | DATE           |           | Fecha de ingreso                     |
| `fecha_de_alta` | DATE           |           | Fecha de alta                        |
| `hora_ingreso`  | TIME           |           | Hora de ingreso                      |
| `hora_egreso`   | TIME           |           | Hora de egreso                       |
| `franco_1`      | VARCHAR(20)    |           | Día de franco 1                      |
| `franco_2`      | VARCHAR(10)    |           | Día de franco 2                      |
| `servicio`      | VARCHAR(100)   | FK        | Servicio asignado                    |
| `mail`          | VARCHAR(100)   |           | Correo electrónico                   |

---

### 📄 Tabla: `Conexiones_al_sistema`

| Columna             | Tipo de Dato   | Clave     | Descripción                          |
|---------------------|----------------|-----------|--------------------------------------|
| `usuario`           | VARCHAR(10)    | PK, FK    | Referencia a `Nomina.usuario`        |
| `conexion`          | DATETIME       |           | Fecha y hora de conexión             |
| `desconexion`       | DATETIME       |           | Fecha y hora de desconexión          |
| `horas_de_conexion` | TIME           |           | Duración total de conexión           |
| `servicio`          | VARCHAR(100)   | PK, FK    | Referencia a `Nomina.servicio`       |

---

### 📄 Tabla: `Justificados`

| Columna           | Tipo de Dato   | Clave     | Descripción                          |
|-------------------|----------------|-----------|--------------------------------------|
| `Legajo`          | INT            | PK, FK    | Referencia a `Nomina.legajo`         |
| `Fecha`           | DATE           |           | Fecha de la ausencia                 |
| `Motivo_Ausencia` | VARCHAR(100)   |           | Motivo del justificativo             |

---

### 📄 Tabla: `Planificado`

| Columna               | Tipo de Dato   | Clave     | Descripción                          |
|-----------------------|----------------|-----------|--------------------------------------|
| `FECHA`               | DATE           |           | Fecha planificada                    |
| `FRANJA_HORARIA`      | TIME           |           | Horario planificado                  |
| `SERVICIO`            | VARCHAR(100)   | PK, FK    | Referencia a `Nomina.servicio`       |
| `CANTIDAD_DE_PERSONAS`| INT            |           | Cantidad de personas requeridas      |

---

### 📄 Tabla: `Requerido`

| Columna               | Tipo de Dato   | Clave     | Descripción                          |
|-----------------------|----------------|-----------|--------------------------------------|
| `FECHA`               | DATE           |           | Fecha requerida                      |
| `FRANJA_HORARIA`      | TIME           |           | Horario requerido                    |
| `SERVICIO`            | VARCHAR(100)   | PK, FK    | Referencia a `Nomina.servicio`       |
| `CANTIDAD_DE_PERSONAS`| INT            |           | Cantidad de personas necesarias      |

---

### 📄 Tabla: `Requerido_servicio`

| Columna           | Tipo de Dato   | Clave     | Descripción                          |
|-------------------|----------------|-----------|--------------------------------------|
| `SERVICIO`        | VARCHAR(100)   | PK, FK    | Referencia a `Nomina.servicio`       |
| `PISO`            | VARCHAR(50)    |           | Piso asignado                        |
| `Q__PA_ASIGNADAS` | INT            |           | Cantidad de personas asignadas       |

---

## 🔗 Relaciones entre Tablas

- `Nomina.usuario` → `Conexiones_al_sistema.usuario`
- `Nomina.servicio` → `Conexiones_al_sistema.servicio`, `Planificado.servicio`, `Requerido.servicio`, `Requerido_servicio.servicio`
- `Nomina.legajo` → `Justificados.legajo`

---

## 🧭 Diagrama Entidad-Relación (ERD)

![Diagrama ERD](sandbox:/mnt/data/erd_diagram.png)