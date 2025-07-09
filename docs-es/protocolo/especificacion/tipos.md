# 2. Tipos y Estructuras Base - Especificación HugAI v2

Esta sección define los tipos y estructuras fundamentales del protocolo HugAI v2. Todos los mensajes y flujos del protocolo se basan en estos tipos.

---

## 2.1. Mensaje JSON-RPC Base

| Campo     | Tipo                | Requerido | Descripción                                      |
|-----------|---------------------|-----------|--------------------------------------------------|
| jsonrpc   | string ("2.0")      | Sí        | Versión del protocolo JSON-RPC                    |
| method    | string              | Sí        | Nombre del método/procedimiento                  |
| params    | object (opcional)   | No        | Parámetros específicos del método                 |
| id        | string / number     | Opcional  | Identificador único de la solicitud/respuesta     |

---

## 2.2. Agente

| Campo           | Tipo                | Requerido | Descripción                                      |
|-----------------|---------------------|-----------|--------------------------------------------------|
| agentId         | string              | Sí        | Identificador único del agente                   |
| type            | string (enum)       | Sí        | Tipo de agente (análisis, implementación, etc.)  |
| capabilities    | string[]            | Sí        | Lista de capacidades/tareas soportadas           |
| governanceLevel | string (enum)       | Sí        | Nivel de gobernanza: autonomous, supervised, manual |
| version         | string              | No        | Versión del agente                              |
| author          | string              | No        | Autor o equipo responsable                      |
| description     | string              | No        | Descripción breve del agente                    |
| dependencies    | string[]            | No        | Otros agentes requeridos                        |

---

## 2.3. Capacidad de Agente

| Campo      | Tipo      | Requerido | Descripción                                  |
|------------|-----------|-----------|----------------------------------------------|
| name       | string    | Sí        | Nombre de la capacidad/tarea                 |
| inputs     | string[]  | No        | Tipos de entrada requeridos                  |
| outputs    | string[]  | No        | Tipos de salida generados                    |
| params     | object    | No        | Parámetros de configuración específicos      |

---

## 2.4. Objeto de Workflow

| Campo           | Tipo                | Requerido | Descripción                                  |
|-----------------|---------------------|-----------|----------------------------------------------|
| id              | string              | Sí        | Identificador único del workflow             |
| projectId       | string              | Sí        | Proyecto asociado                            |
| currentPhase    | string (enum)       | Sí        | Fase actual (planning, design, etc.)         |
| status          | string (enum)       | Sí        | Estado general (in_progress, completed, etc.)|
| phases          | object[]            | Sí        | Lista de fases y su información              |
| governanceRules | object[]            | Sí        | Reglas de gobernanza aplicadas               |
| requirements    | object              | Sí        | Requerimientos del workflow                  |
| createdAt       | string (ISO date)   | Sí        | Fecha de creación                            |
| updatedAt       | string (ISO date)   | Sí        | Fecha de última actualización                |

---

## 2.5. Objeto de Aprobación/Gobernanza

| Campo      | Tipo      | Requerido | Descripción                                  |
|------------|-----------|-----------|----------------------------------------------|
| checkpoint | string    | Sí        | Nombre del punto de control                  |
| artifact   | object    | Sí        | Artefacto o evidencia a aprobar/revisar      |
| approver   | string    | Sí        | Identificador del aprobador humano           |
| decision   | string    | Sí        | approved, rejected, needs_revision           |
| feedback   | string    | No        | Comentarios o justificación                  |

---

## Tipos y Enums Adicionales

### Estado de Agente (`AgentStatus`)
| Valor      | Descripción                                 |
|------------|---------------------------------------------|
| idle       | El agente está disponible y en espera        |
| busy       | El agente está procesando una tarea          |
| error      | El agente ha encontrado un error             |
| offline    | El agente no está disponible                 |

### Estado de Checkpoint de Gobernanza (`CheckpointStatus`)
| Valor      | Descripción                                 |
|------------|---------------------------------------------|
| pending    | Pendiente de revisión/aprobación             |
| approved   | Aprobado                                     |
| rejected   | Rechazado                                    |
| escalated  | Escalado a un nivel superior                 |

### Estado de Fase de Workflow (`WorkflowPhaseStatus`)
| Valor         | Descripción                               |
|---------------|-------------------------------------------|
| not_started   | La fase aún no ha comenzado                |
| in_progress   | La fase está en curso                      |
| completed     | La fase ha finalizado con éxito            |
| failed        | La fase ha fallado o no se completó        |

---

> **Nota:** Estos enums permiten modelar el estado y la transición de agentes, checkpoints y fases en los flujos de trabajo HugAI, facilitando la trazabilidad y la gestión dinámica del proceso.

> **Nota:** Los tipos y estructuras pueden extenderse según la evolución del protocolo. Cada campo debe documentarse y validarse en las implementaciones. 