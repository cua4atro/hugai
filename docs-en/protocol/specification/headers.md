# Headers of the HugAI v2 Protocol

This section describes the structure and use of headers in the HugAI v2 protocol, ensuring compatibility and extensibility.

---

## 1. Header Structure

Messages in the HugAI v2 protocol follow a structure similar to LSP, separating headers and the message body. Headers are sent in plain text (ASCII), followed by a blank line (`\r\n`), and then the JSON content (body).

---

## 2. Supported Headers Table

| Header Field Name   | Type    | Description                                                                 |
|-------------------- |---------|-----------------------------------------------------------------------------|
| Content-Length      | number  | Length of the JSON content in bytes. Required.                              |
| Content-Type        | string  | MIME type of the content. Default: application/vscode-jsonrpc; charset=utf-8 |
| HugAI-Version       | string  | HugAI protocol version. E.g.: 2.0.0                                         |
| Governance-Level    | string  | Required governance level: autonomous, supervised, human-in-the-loop, manual |
| Request-Id          | string/number | Unique request identifier (optional, redundant with JSON-RPC)           |
| Custom-*            | string  | Custom headers for future extensions                                         |

---

## 3. Example of a Complete Message (Headers + Body)

```
Content-Length: 234\r\n
Content-Type: application/vscode-jsonrpc; charset=utf-8\r\n
HugAI-Version: 2.0.0\r\n
Governance-Level: supervised\r\n
\r\n
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "agent/register",
  "params": {
    "agentId": "architecture-agent",
    "capabilities": {
      "tasks": ["design", "review"],
      "governanceLevel": "supervised"
    }
  }
}
```

---

## 4. Best Practices and Compatibility

- All messages must include `Content-Length` and `Content-Type`.
- It is recommended to include `HugAI-Version` and `Governance-Level` for traceability and governance control.
- Custom headers should use the `Custom-` prefix to avoid collisions.
- The body must be valid JSON, encoded in UTF-8.
- Agents and servers should ignore unknown headers to maintain future compatibility.
- Header validation is critical for interoperability and security.

---

> **Note:** The header structure allows the protocol to be extended without breaking compatibility, facilitating evolution and adoption in different environments.