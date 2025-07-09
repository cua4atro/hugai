# 7. Enumeraciones y Códigos de Error - Especificación HugAI v2

Esta sección define las enumeraciones clave y los códigos de error estándar utilizados en el protocolo HugAI v2.

---

## 7.1. Enumeraciones Clave

### governanceLevel
| Valor              | Descripción                                      |
|--------------------|-------------------------------------------------|
| autonomous         | El agente actúa sin intervención humana          |
| supervised         | Requiere revisiones/aprobaciones en puntos clave |
| human-in-the-loop  | Toda acción relevante requiere aprobación humana |
| manual             | Solo sugiere acciones, humano debe ejecutarlas   |

### decision (gobernanza)
| Valor           | Descripción                        |
|-----------------|-----------------------------------|
| approved        | Aprobado                           |
| rejected        | Rechazado                          |
| needs_revision  | Requiere revisión/cambios          |

### priority
| Valor     | Descripción                |
|-----------|---------------------------|
| low       | Baja prioridad             |
| medium    | Prioridad media            |
| high      | Alta prioridad             |
| critical  | Crítica/urgente            |

### logging.level
| Valor   | Descripción                |
|---------|---------------------------|
| error   | Solo errores graves        |
| warn    | Advertencias               |
| info    | Información general        |
| debug   | Depuración detallada       |
| trace   | Trazas completas           |

### environment
| Valor        | Descripción                |
|--------------|---------------------------|
| development  | Entorno de desarrollo      |
| staging      | Pre-producción/pruebas     |
| production   | Producción                 |

---

## 7.2. Códigos de Error Estándar

| Código    | Nombre                    | Descripción                                         | Uso Típico                       |
|-----------|---------------------------|-----------------------------------------------------|----------------------------------|
| -32700    | Parse Error               | Error al parsear el mensaje JSON                     | JSON mal formado                 |
| -32600    | Invalid Request           | La solicitud no es válida                            | Formato incorrecto               |
| -32601    | Method Not Found          | El método solicitado no existe                       | Método no implementado           |
| -32602    | Invalid Params            | Parámetros inválidos o faltantes                     | Error de validación              |
| -32603    | Internal Error            | Error interno del sistema/agente                     | Excepción inesperada             |
| -32000    | Governance Required       | Se requiere intervención/aprobación humana           | Falta de aprobación              |
| -32001    | Capability Not Allowed    | Capacidad no permitida para el agente                | Restricción de permisos          |
| -32002    | Tool Integration Error    | Error al interactuar con herramienta externa         | Fallo de integración             |
| -32003    | Audit Log Failure         | No se pudo registrar en auditoría                    | Problema de trazabilidad         |
| -32010    | Agent Not Found           | El agente solicitado no existe o no está disponible  | Error de ruteo o registro        |
| -32011    | Governance Violation      | Violación de política de gobernanza                  | Acción no permitida por reglas   |
| -32012    | Human Approval Required   | Se requiere aprobación humana explícita              | Checkpoint obligatorio           |
| -32013    | Workflow State Error      | Estado inconsistente en el flujo de trabajo          | Fase o transición inválida       |

---

## 7.3. Ejemplo de Uso en Mensajes

**Error de método no soportado:**
```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "error": { "code": -32601, "message": "Método no soportado" }
}
```

**Error de gobernanza requerida:**
```json
{
  "jsonrpc": "2.0",
  "id": 4,
  "error": { "code": -32000, "message": "Se requiere aprobación humana" }
}
```

**Error de agente no encontrado:**
```json
{
  "jsonrpc": "2.0",
  "id": 5,
  "error": { "code": -32010, "message": "El agente solicitado no existe" }
}
```

**Error de integración de herramienta:**
```json
{
  "jsonrpc": "2.0",
  "id": 6,
  "error": { "code": -32002, "message": "Error al interactuar con herramienta externa" }
}
```

---

> **Nota:** Los códigos negativos siguen la convención JSON-RPC. Se pueden definir códigos adicionales según necesidades del sistema y la evolución del protocolo. 