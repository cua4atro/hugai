# 11. Glossary and FAQ - HugAI v2 Specification

This section provides definitions of key terms and answers frequently asked questions about the HugAI v2 protocol.

---

## 11.1. Glossary of Terms

- **Agent:** Autonomous entity (software) that executes tasks, collaborates, and communicates via the protocol.
- **Governance:** Mechanisms and policies to supervise, approve, and audit actions of agents and humans.
- **Capability:** Specific functionality or task that an agent can announce and execute (e.g., code-generation, testing).
- **Workspace:** Set of folders or resources operated on by an agent.
- **Approval:** Process of human review and authorization for critical actions.
- **Audit:** Detailed record of actions, decisions, and events for traceability and compliance.
- **Message:** JSON structure exchanged between agents, humans, and tools following the protocol.
- **Extension:** Addition of new messages, capabilities, or workflows to the base protocol.
- **Integration:** Connection with external tools (CI/CD, analysis, etc.) via standard or custom messages.
- **Human-in-the-loop:** Model where human intervention is mandatory at critical points.
- **Supervised:** Model where human intervention is optional or at defined points.
- **Autonomous:** Model where agents act without human intervention.

---

## 11.2. Frequently Asked Questions (FAQ)

**What is HugAI v2 and what is it for?**
> It is an open protocol to orchestrate AI agents and humans in development and automation processes, with governance and traceability.

**How is the protocol extended?**
> By adding new types of messages, capabilities, or agents following the JSON-RPC scheme and documenting the extension.

**What security mechanisms exist?**
> Authentication of agents and humans, message validation, auditing, use of encrypted channels, and secure secret management.

**Can I integrate my own tools?**
> Yes, via `tool/integration` messages or custom extensions, always following best practices for validation and security.

**What happens if an agent receives an unknown message?**
> It should ignore it (if not critical) or respond with a standard error, maintaining robustness and compatibility.

**How is configuration managed?**
> Through files (JSON/YAML), environment variables, and runtime parameters, following the documented best practices.

**What governance levels exist?**
> Autonomous, supervised, and human-in-the-loop, according to the required degree of human intervention.

**How are actions audited?**
> Using the `audit/log` message to record actor, action, timestamp, details, and result in protected systems.

**Is the protocol compatible with JSON-RPC?**
> Yes, it is based on JSON-RPC 2.0 for message structure and extensibility.

---

> **Note:** For additional questions, suggestions, or contributions, consult the official documentation or contact the protocol maintainers.