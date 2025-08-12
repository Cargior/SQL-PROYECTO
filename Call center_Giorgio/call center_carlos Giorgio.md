📘 Documentación de la Base de Datos
🗂 Nombre de la Base de Datos
nombre_de_la_base
🧱 Estructura de Tablas
📄 Tabla: usuarios
| Columna | Tipo de Dato | Clave Primaria | Nulo | Descripción | 
| id | INT | ✅ | ❌ | Identificador único del usuario | 
| nombre | VARCHAR(100) | ❌ | ❌ | Nombre completo del usuario | 
| email | VARCHAR(100) | ❌ | ❌ | Correo electrónico | 
| fecha_reg | DATE | ❌ | ❌ | Fecha de registro | 


📄 Tabla: productos
| Columna | Tipo de Dato | Clave Primaria | Nulo | Descripción | 
| id | INT | ✅ | ❌ | Identificador único del producto | 
| nombre | VARCHAR(100) | ❌ | ❌ | Nombre del producto | 
| precio | DECIMAL(10,2) | ❌ | ❌ | Precio del producto | 
| stock | INT | ❌ | ❌ | Cantidad disponible | 


🔗 Relaciones
- usuarios puede tener múltiples pedidos
- productos pueden estar en múltiples pedidos
📌 Notas Técnicas
- Motor de base de datos: PostgreSQL / MySQL / SQLite
- Codificación: UTF-8
- Reglas de normalización aplicadas: 3FN

