# 3. Protocol Messages - HugAI v2 Specification

This section describes the main messages of the HugAI v2 protocol, their fields, purpose, and usage examples.

---

## 3.1. Initialization Message (`initialize`)

**Purpose:** Establish the connection, negotiate capabilities, and share context information between agents, clients, and the system.

| Field            | Type      | Required | Description                                  |
|------------------|-----------|----------|----------------------------------------------|
| processId        | number    | Yes      | Client process identifier                    |
| agentId          | string    | Yes      | Agent/client identifier                      |
| capabilities     | object    | Yes      | Supported capabilities                       |
| governanceLevel  | string    | Yes      | Requested governance level                   |
| clientInfo       | object    | No       | Client information (name, version)           |
| workspaceFolders | array     | No       | Associated workspace folders                 |

**Example:**
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
    "workspaceFolders": ["/project/demo"]
  },
  "id": 1
}
```

---

## 3.2. Agent Registration (`agent/register`)

**Purpose:** Register an agent in the system, announcing its capabilities and metadata.

| Field         | Type      | Required | Description                                  |
|---------------|-----------|----------|----------------------------------------------|
| agentId       | string    | Yes      | Unique agent identifier                      |
| capabilities  | object    | Yes      | Supported capabilities and tasks             |
| governanceLevel | string  | Yes      | Supported governance level                   |
| version       | string    | No       | Agent version                                |
| author        | string    | No       | Author or responsible team                   |
| description   | string    | No       | Short description                            |
| dependencies  | string[]  | No       | Other required agents                        |

**Example:**
```json
{
  "jsonrpc": "2.0",
  "method": "agent/register",
  "params": {
    "agentId": "advanced-agent-1",
    "capabilities": { "code-generation": true, "testing": true, "refactoring": true },
    "governanceLevel": "supervised",
    "version": "1.2.0",
    "author": "HugAI Team",
    "description": "Advanced agent for code generation and refactoring",
    "dependencies": ["test-agent", "review-agent"]
  },
  "id": 2
}
```

---

## 3.3. Task Request / Agent Communication (`agent/request`)

**Purpose:** Request the execution of a task or collaboration between agents.

| Field        | Type      | Required | Description                                  |
|--------------|-----------|----------|----------------------------------------------|
| sourceAgent  | string    | Yes      | Agent originating the request                |
| targetAgent  | string    | Yes      | Target agent                                 |
| task         | string    | Yes      | Task to execute                              |
| context      | object    | No       | Additional context (files, data, etc.)       |
| priority     | string    | No       | Priority: low, medium, high, critical        |

**Example:**
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

## 3.4. Response (`response`)

**Purpose:** Return the result of a previous request.

| Field   | Type           | Required | Description                                  |
|---------|----------------|----------|----------------------------------------------|
| id      | string/number  | Yes      | Original request identifier                  |
| result  | object         | No       | Operation result                             |
| error   | object         | No       | Error object if the operation failed         |

**Example (success):**
```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "result": { "ack": true, "output": "Tests generated" }
}
```
**Example (error):**
```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "error": { "code": -32601, "message": "Method not supported" }
}
```

---

## 3.5. Event (`event`)

**Purpose:** Notify state changes, incidents, progress, or relevant events.

| Field   | Type      | Required | Description                                  |
|---------|-----------|----------|----------------------------------------------|
| event   | string    | Yes      | Event name                                   |
| data    | object    | No       | Data associated with the event               |

**Example:**
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

## 3.6. Governance Approval (`governance/approval`)

**Purpose:** Manage human checkpoints, approvals, reviews, and auditing of critical decisions.

| Field      | Type      | Required | Description                                  |
|------------|-----------|----------|----------------------------------------------|
| checkpoint | string    | Yes      | Checkpoint name                              |
| artifact   | object    | Yes      | Artifact or evidence to approve/review       |
| approver   | string    | Yes      | Human approver identifier                    |
| decision   | string    | Yes      | approved, rejected, needs_revision           |
| feedback   | string    | No       | Comments or justification                    |

**Example:**
```json
{
  "jsonrpc": "2.0",
  "method": "governance/approval",
  "params": {
    "checkpoint": "code-review",
    "artifact": { "file": "main.ts", "diff": "..." },
    "approver": "user-123",
    "decision": "approved",
    "feedback": "Meets the standards."
  },
  "id": 4
}
```

---

## 3.7. Tool Integration (`tool/integration`)

**Purpose:** Interact with external systems, execute commands, receive results, or integrate third-party tool events.

| Field    | Type      | Required | Description                                  |
|----------|-----------|----------|----------------------------------------------|
| tool     | string    | Yes      | External tool name                           |
| action   | string    | Yes      | Action to execute                            |
| data     | object    | No       | Data or parameters for the action            |
| callback | string    | No       | Method/callback to receive the response      |

**Example:**
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

## 3.8. Audit and Traceability (`audit/log`)

**Purpose:** Record actions, decisions, and relevant events for traceability and compliance.

| Field     | Type      | Required | Description                                  |
|-----------|-----------|----------|----------------------------------------------|
| action    | string    | Yes      | Recorded action                              |
| actor     | string    | Yes      | Responsible agent or human                   |
| target    | string    | No       | Affected object or entity                    |
| details   | object    | No       | Additional details                           |
| timestamp | string    | Yes      | Date and time (ISO 8601)                     |

**Example:**
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

> **Note:** Each message must be validated against its structure and required fields. Examples may be extended as the protocol evolves.