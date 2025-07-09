# 7. Enumerations and Error Codes - HugAI v2 Specification

This section defines the key enumerations and standard error codes used in the HugAI v2 protocol.

---

## 7.1. Key Enumerations

### governanceLevel
| Value              | Description                                      |
|--------------------|-------------------------------------------------|
| autonomous         | The agent acts without human intervention        |
| supervised         | Requires reviews/approvals at key points         |
| human-in-the-loop  | Every relevant action requires human approval    |
| manual             | Only suggests actions, human must execute them   |

### decision (governance)
| Value           | Description                        |
|-----------------|------------------------------------|
| approved        | Approved                            |
| rejected        | Rejected                            |
| needs_revision  | Requires review/changes             |

### priority
| Value     | Description                |
|-----------|---------------------------|
| low       | Low priority               |
| medium    | Medium priority            |
| high      | High priority              |
| critical  | Critical/urgent            |

### logging.level
| Value   | Description                |
|---------|---------------------------|
| error   | Only severe errors         |
| warn    | Warnings                   |
| info    | General information        |
| debug   | Detailed debugging         |
| trace   | Full traces                |

### environment
| Value        | Description                |
|--------------|---------------------------|
| development  | Development environment    |
| staging      | Pre-production/testing     |
| production   | Production                 |

---

## 7.2. Standard Error Codes

| Code      | Name                      | Description                                         | Typical Use                       |
|-----------|---------------------------|-----------------------------------------------------|-----------------------------------|
| -32700    | Parse Error               | Error parsing the JSON message                      | Malformed JSON                    |
| -32600    | Invalid Request           | The request is not valid                            | Incorrect format                  |
| -32601    | Method Not Found          | The requested method does not exist                 | Method not implemented            |
| -32602    | Invalid Params            | Invalid or missing parameters                       | Validation error                  |
| -32603    | Internal Error            | Internal system/agent error                         | Unexpected exception              |
| -32000    | Governance Required       | Human intervention/approval required                | Missing approval                  |
| -32001    | Capability Not Allowed    | Capability not allowed for the agent                | Permission restriction            |
| -32002    | Tool Integration Error    | Error interacting with external tool                | Integration failure               |
| -32003    | Audit Log Failure         | Could not log to audit                              | Traceability issue                |
| -32010    | Agent Not Found           | The requested agent does not exist or is unavailable| Routing or registration error     |
| -32011    | Governance Violation      | Governance policy violation                         | Action not allowed by rules       |
| -32012    | Human Approval Required   | Explicit human approval required                    | Mandatory checkpoint              |
| -32013    | Workflow State Error      | Inconsistent workflow state                         | Invalid phase or transition       |

---

## 7.3. Example Usage in Messages

**Unsupported method error:**
```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "error": { "code": -32601, "message": "Method not supported" }
}
```

**Governance required error:**
```json
{
  "jsonrpc": "2.0",
  "id": 4,
  "error": { "code": -32000, "message": "Human approval required" }
}
```

**Agent not found error:**
```json
{
  "jsonrpc": "2.0",
  "id": 5,
  "error": { "code": -32010, "message": "The requested agent does not exist" }
}
```

**Tool integration error:**
```json
{
  "jsonrpc": "2.0",
  "id": 6,
  "error": { "code": -32002, "message": "Error interacting with external tool" }
}
```

---

> **Note:** Negative codes follow the JSON-RPC convention. Additional codes may be defined as needed by the system and protocol evolution.