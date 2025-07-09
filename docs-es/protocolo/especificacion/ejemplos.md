# 10. Ejemplos de Uso y Casos Prácticos - Especificación HugAI v2

Esta sección presenta ejemplos completos y casos prácticos de uso del protocolo HugAI v2, con mensajes JSON y diagramas de secuencia.

---

## 10.1. Ciclo Completo: Inicialización, Registro, Solicitud, Aprobación y Auditoría

**Flujo:** Un agente se inicializa, se registra, solicita una tarea que requiere aprobación humana, y todo queda auditado.

```mermaid
sequenceDiagram
    participant Cliente
    participant Protocolo
    participant Agente
    participant Humano
    participant Auditoría
    Cliente->>Protocolo: initialize
    Protocolo-->>Cliente: response
    Cliente->>Protocolo: agent/register
    Protocolo-->>Cliente: response
    Cliente->>Protocolo: agent/request (tarea crítica)
    Protocolo->>Humano: governance/approval
    Humano-->>Protocolo: governance/approval (decisión)
    Protocolo-->>Cliente: response
    Protocolo->>Auditoría: audit/log
```

**Mensajes JSON:**
- `initialize`, `agent/register`, `agent/request`, `governance/approval`, `response`, `audit/log`

---

## 10.2. Integración con Herramienta Externa (CI/CD)

**Flujo:** Un agente solicita ejecutar pruebas en una herramienta CI/CD y recibe el resultado.

```mermaid
sequenceDiagram
    participant Agente
    participant Protocolo
    participant CI
    Agente->>Protocolo: tool/integration (run-tests)
    Protocolo->>CI: tool/integration (run-tests)
    CI-->>Protocolo: response (resultado)
    Protocolo-->>Agente: response (resultado)
```

**Mensaje de solicitud:**
```json
{
  "jsonrpc": "2.0",
  "method": "tool/integration",
  "params": {
    "tool": "ci-pipeline",
    "action": "run-tests",
    "data": { "branch": "main" }
  },
  "id": 20
}
```

---

## 10.3. Caso de Gobernanza Humana

**Flujo:** Un agente genera código, pero requiere revisión y aprobación humana antes de integrarlo.

```mermaid
sequenceDiagram
    participant Agente
    participant Protocolo
    participant Humano
    Agente->>Protocolo: agent/request (code-generation)
    Protocolo->>Humano: governance/approval (revisión de código)
    Humano-->>Protocolo: governance/approval (aprobado/rechazado)
    Protocolo-->>Agente: response
```

**Mensaje de aprobación:**
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
  "id": 21
}
```

---

## 10.4. Ejemplo de Extensión/Customización

**Flujo:** Un agente especializado realiza un análisis de seguridad usando un mensaje custom.

```mermaid
sequenceDiagram
    participant Cliente
    participant Protocolo
    participant SecurityAgent
    Cliente->>Protocolo: agent/securityScan (custom)
    Protocolo->>SecurityAgent: agent/securityScan
    SecurityAgent-->>Protocolo: response (resultado)
    Protocolo-->>Cliente: response (resultado)
```

**Mensaje custom:**
```json
{
  "jsonrpc": "2.0",
  "method": "agent/securityScan",
  "params": {
    "target": "main.ts",
    "level": "deep"
  },
  "id": 22
}
```

---

> **Nota:** Estos ejemplos pueden adaptarse y ampliarse según los escenarios de uso y la evolución del protocolo. 