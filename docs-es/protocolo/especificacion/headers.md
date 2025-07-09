# Headers del Protocolo HugAI v2

Esta sección describe la estructura y uso de los headers en el protocolo HugAI v2, asegurando compatibilidad y extensibilidad.

---

## 1. Estructura de Headers

Los mensajes del protocolo HugAI v2 siguen una estructura similar a LSP, separando headers y cuerpo (body) del mensaje. Los headers se envían en texto plano (ASCII), seguidos de una línea vacía (`\r\n`), y luego el contenido JSON (body).

---

## 2. Tabla de Headers Soportados

| Header Field Name   | Tipo    | Descripción                                                                 |
|-------------------- |---------|-----------------------------------------------------------------------------|
| Content-Length      | number  | Longitud del contenido JSON en bytes. Obligatorio.                          |
| Content-Type        | string  | Tipo MIME del contenido. Por defecto: application/vscode-jsonrpc; charset=utf-8 |
| HugAI-Version       | string  | Versión del protocolo HugAI. Ej: 2.0.0                                      |
| Governance-Level    | string  | Nivel de gobernanza requerido: autonomous, supervised, human-in-the-loop, manual |
| Request-Id          | string/number | Identificador único de la solicitud (opcional, redundante con JSON-RPC)   |
| Custom-*            | string  | Headers personalizados para extensiones futuras                              |

---

## 3. Ejemplo de Mensaje Completo (Headers + Body)

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

## 4. Buenas Prácticas y Compatibilidad

- Todos los mensajes deben incluir `Content-Length` y `Content-Type`.
- Se recomienda incluir `HugAI-Version` y `Governance-Level` para trazabilidad y control de gobernanza.
- Los headers personalizados deben usar el prefijo `Custom-` para evitar colisiones.
- El cuerpo debe ser JSON válido, codificado en UTF-8.
- Los agentes y servidores deben ignorar headers desconocidos para mantener compatibilidad futura.
- La validación de headers es crítica para interoperabilidad y seguridad.

---

> **Nota:** La estructura de headers permite extender el protocolo sin romper compatibilidad, facilitando la evolución y adopción en distintos entornos. 