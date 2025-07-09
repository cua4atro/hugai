# 2. Base Types and Structures - HugAI v2 Specification

This section defines the fundamental types and structures of the HugAI v2 protocol. All protocol messages and flows are based on these types.

---

## 2.1. Base JSON-RPC Message

| Field     | Type                | Required | Description                                      |
|-----------|---------------------|----------|--------------------------------------------------|
| jsonrpc   | string ("2.0")      | Yes      | JSON-RPC protocol version                        |
| method    | string              | Yes      | Name of the method/procedure                     |
| params    | object (optional)   | No       | Method-specific parameters                       |
| id        | string / number     | Optional | Unique identifier for the request/response        |

---

## 2.2. Agent

| Field           | Type                | Required | Description                                      |
|-----------------|---------------------|----------|--------------------------------------------------|
| agentId         | string              | Yes      | Unique identifier of the agent                   |
| type            | string (enum)       | Yes      | Agent type (analysis, implementation, etc.)      |
| capabilities    | string[]            | Yes      | List of supported capabilities/tasks             |
| governanceLevel | string (enum)       | Yes      | Governance level: autonomous, supervised, manual |
| version         | string              | No       | Agent version                                   |
| author          | string              | No       | Author or responsible team                      |
| description     | string              | No       | Brief description of the agent                   |
| dependencies    | string[]            | No       | Other required agents                            |

---

## 2.3. Agent Capability

| Field      | Type      | Required | Description                                  |
|------------|-----------|----------|----------------------------------------------|
| name       | string    | Yes      | Name of the capability/task                  |
| inputs     | string[]  | No       | Required input types                         |
| outputs    | string[]  | No       | Generated output types                       |
| params     | object    | No       | Specific configuration parameters            |

---

## 2.4. Workflow Object

| Field           | Type                | Required | Description                                  |
|-----------------|---------------------|----------|----------------------------------------------|
| id              | string              | Yes      | Unique identifier of the workflow            |
| projectId       | string              | Yes      | Associated project                           |
| currentPhase    | string (enum)       | Yes      | Current phase (planning, design, etc.)       |
| status          | string (enum)       | Yes      | General status (in_progress, completed, etc.)|
| phases          | object[]            | Yes      | List of phases and their information         |
| governanceRules | object[]            | Yes      | Applied governance rules                     |
| requirements    | object              | Yes      | Workflow requirements                        |
| createdAt       | string (ISO date)   | Yes      | Creation date                                |
| updatedAt       | string (ISO date)   | Yes      | Last update date                             |

---

## 2.5. Approval/Governance Object

| Field      | Type      | Required | Description                                  |
|------------|-----------|----------|----------------------------------------------|
| checkpoint | string    | Yes      | Name of the control point                    |
| artifact   | object    | Yes      | Artifact or evidence to approve/review       |
| approver   | string    | Yes      | Identifier of the human approver             |
| decision   | string    | Yes      | approved, rejected, needs_revision           |
| feedback   | string    | No       | Comments or justification                     |

---

## Additional Types and Enums

### Agent Status (`AgentStatus`)
| Value      | Description                                 |
|------------|---------------------------------------------|
| idle       | The agent is available and on standby        |
| busy       | The agent is processing a task              |
| error      | The agent has encountered an error           |
| offline    | The agent is not available                   |

### Governance Checkpoint Status (`CheckpointStatus`)
| Value      | Description                                 |
|------------|---------------------------------------------|
| pending    | Pending review/approval                       |
| approved   | Approved                                     |
| rejected   | Rejected                                      |
| escalated  | Escalated to a higher level                 |

### Workflow Phase Status (`WorkflowPhaseStatus`)
| Value         | Description                               |
|---------------|-------------------------------------------|
| not_started   | The phase has not started yet              |
| in_progress   | The phase is in progress                   |
| completed     | The phase has been successfully completed  |
| failed        | The phase has failed or was not completed  |

---

> **Note:** These enums allow modeling the state and transition of agents, checkpoints, and phases in HugAI workflows, facilitating traceability and dynamic process management.

> **Note:** Types and structures may be extended as the protocol evolves. Each field must be documented and validated in implementations.