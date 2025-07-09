# 3. Mensajes del Protocolo - Especificación HugAI v2

Esta sección describe los mensajes principales del protocolo HugAI v2, sus campos, propósito y ejemplos de uso.

---

## 3.1. Mensaje de Inicialización (`initialize`)

**Propósito:** Establecer la conexión, negociar capacidades y compartir información de contexto entre agentes, clientes y el sistema.

| Campo     | Tipo      | Requerido | Descripción                                  |
|-----------|-----------|-----------|----------------------------------------------|
| processId | number    | Sí        | Identificador del proceso cliente            |
| agentId   | string    | Sí        | Identificador del agente/cliente             |
| capabilities | object | Sí        | Capacidades soportadas                       |
| governanceLevel | string | Sí     | Nivel de gobernanza solicitado               |
| clientInfo | object   | No        | Información del cliente (nombre, versión)    |
| workspaceFolders | array | No     | Carpetas de trabajo asociadas                |

**Ejemplo:**
```json
{
  "jsonrpc": "2.0",
  "method": "initialize",
  "params": {
    "processId": 12345,
    "agentId": "demo-agent-1",
    "capabilities": { "code-generation": true, "testing": true },
    "governanceLevel": "supervised",
    "clientInfo": { "name": "HugAI Client", "version": "1.0.0" },
    "workspaceFolders": ["/proyecto/demo"]
  },
  "id": 1
}
```

---

## 3.2. Registro de Agente (`agent/register`)

**Propósito:** Registrar un agente en el sistema, anunciando sus capacidades y metadatos.

| Campo        | Tipo      | Requerido | Descripción                                  |
|--------------|-----------|-----------|----------------------------------------------|
| agentId      | string    | Sí        | Identificador único del agente               |
| capabilities | object    | Sí        | Capacidades y tareas soportadas              |
| governanceLevel | string | Sí        | Nivel de gobernanza soportado                |
| version      | string    | No        | Versión del agente                           |
| author       | string    | No        | Autor o equipo responsable                   |
| description  | string    | No        | Descripción breve                            |
| dependencies | string[]  | No        | Otros agentes requeridos                     |

**Ejemplo:**
```json
{
  "jsonrpc": "2.0",
  "method": "agent/register",
  "params": {
    "agentId": "advanced-agent-1",
    "capabilities": { "code-generation": true, "testing": true, "refactoring": true },
    "governanceLevel": "supervised",
    "version": "1.2.0",
    "author": "Equipo HugAI",
    "description": "Agente avanzado para generación y refactorización de código",
    "dependencies": ["test-agent", "review-agent"]
  },
  "id": 2
}
```

---

## 3.3. Solicitud de Tarea / Comunicación entre Agentes (`agent/request`)

**Propósito:** Solicitar la ejecución de una tarea o la colaboración entre agentes.

| Campo        | Tipo      | Requerido | Descripción                                  |
|--------------|-----------|-----------|----------------------------------------------|
| sourceAgent  | string    | Sí        | Agente que origina la solicitud              |
| targetAgent  | string    | Sí        | Agente destinatario                          |
| task         | string    | Sí        | Tarea a ejecutar                             |
| context      | object    | No        | Contexto adicional (archivos, datos, etc.)    |
| priority     | string    | No        | Prioridad: low, medium, high, critical        |

**Ejemplo:**
```json
{
  "jsonrpc": "2.0",
  "method": "agent/request",
  "params": {
    "sourceAgent": "demo-agent-1",
    "targetAgent": "test-agent-2",
    "task": "generate-tests",
    "context": { "file": "main.ts" },
    "priority": "high"
  },
  "id": 3
}
```

---

## 3.4. Respuesta (`response`)

**Propósito:** Devolver el resultado de una solicitud previa.

| Campo   | Tipo      | Requerido | Descripción                                  |
|---------|-----------|-----------|----------------------------------------------|
| id      | string/number | Sí    | Identificador de la solicitud original       |
| result  | object    | No        | Resultado de la operación                    |
| error   | object    | No        | Objeto de error si la operación falló        |

**Ejemplo (éxito):**
```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "result": { "ack": true, "output": "Tests generados" }
}
```
**Ejemplo (error):**
```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "error": { "code": -32601, "message": "Método no soportado" }
}
```

---

## 3.5. Evento (`event`)

**Propósito:** Notificar cambios de estado, incidencias, progresos o sucesos relevantes.

| Campo   | Tipo      | Requerido | Descripción                                  |
|---------|-----------|-----------|----------------------------------------------|
| event   | string    | Sí        | Nombre del evento                            |
| data    | object    | No        | Datos asociados al evento                    |

**Ejemplo:**
```json
{
  "jsonrpc": "2.0",
  "method": "event",
  "params": {
    "event": "task-progress",
    "data": { "task": "generate-tests", "progress": 50 }
  }
}
```

---

## 3.6. Aprobación de Gobernanza (`governance/approval`)

**Propósito:** Gestionar puntos de control humano, aprobaciones, revisiones y auditoría de decisiones críticas.

| Campo      | Tipo      | Requerido | Descripción                                  |
|------------|-----------|-----------|----------------------------------------------|
| checkpoint | string    | Sí        | Nombre del punto de control                  |
| artifact   | object    | Sí        | Artefacto o evidencia a aprobar/revisar      |
| approver   | string    | Sí        | Identificador del aprobador humano           |
| decision   | string    | Sí        | approved, rejected, needs_revision           |
| feedback   | string    | No        | Comentarios o justificación                  |

**Ejemplo:**
```json
{
  "jsonrpc": "2.0",
  "method": "governance/approval",
  "params": {
    "checkpoint": "code-review",
    "artifact": { "file": "main.ts", "diff": "..." },
    "approver": "user-123",
    "decision": "approved",
    "feedback": "Cumple con los estándares."
  },
  "id": 4
}
```

---

## 3.7. Integración de Herramientas (`tool/integration`)

**Propósito:** Interactuar con sistemas externos, ejecutar comandos, recibir resultados o integrar eventos de herramientas de terceros.

| Campo   | Tipo      | Requerido | Descripción                                  |
|---------|-----------|-----------|----------------------------------------------|
| tool    | string    | Sí        | Nombre de la herramienta externa             |
| action  | string    | Sí        | Acción a ejecutar                            |
| data    | object    | No        | Datos o parámetros para la acción            |
| callback| string    | No        | Método/callback para recibir la respuesta    |

**Ejemplo:**
```json
{
  "jsonrpc": "2.0",
  "method": "tool/integration",
  "params": {
    "tool": "ci-pipeline",
    "action": "run-tests",
    "data": { "branch": "feature-x" },
    "callback": "event"
  },
  "id": 5
}
```

---

## 3.8. Auditoría y Trazabilidad (`audit/log`)

**Propósito:** Registrar acciones, decisiones y eventos relevantes para trazabilidad y cumplimiento.

| Campo   | Tipo      | Requerido | Descripción                                  |
|---------|-----------|-----------|----------------------------------------------|
| action  | string    | Sí        | Acción registrada                            |
| actor   | string    | Sí        | Agente o humano responsable                  |
| target  | string    | No        | Objeto o entidad afectada                    |
| details | object    | No        | Detalles adicionales                         |
| timestamp | string  | Sí        | Fecha y hora (ISO 8601)                      |

**Ejemplo:**
```json
{
  "jsonrpc": "2.0",
  "method": "audit/log",
  "params": {
    "action": "approval",
    "actor": "user-123",
    "target": "main.ts",
    "details": { "decision": "approved" },
    "timestamp": "2024-06-01T12:34:56Z"
  }
}
```

---

> **Nota:** Cada mensaje debe validarse contra su estructura y campos requeridos. Los ejemplos pueden extenderse según la evolución del protocolo. 