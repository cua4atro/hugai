# 5. Configuración y Variables - Especificación HugAI v2

Esta sección describe cómo se configuran el sistema, los agentes y las variables clave en el protocolo HugAI v2.

---

## 5.1. Descripción General

La configuración en HugAI v2 permite adaptar el comportamiento de agentes, clientes y el sistema central. Puede gestionarse mediante archivos (JSON/YAML), variables de entorno o parámetros en tiempo de ejecución.

---

## 5.2. Variables Globales y de Entorno

| Variable            | Tipo     | Descripción                                               |
|---------------------|----------|-----------------------------------------------------------|
| governanceLevel     | string   | Nivel de gobernanza: autonomous, supervised, human-in-the-loop |
| workspaceFolders    | string[] | Rutas de carpetas de trabajo asociadas                    |
| capabilities        | object   | Capacidades habilitadas para el agente o sistema          |
| logging.level       | string   | Nivel de log: error, warn, info, debug, trace             |
| logging.path        | string   | Ruta del archivo/log                                      |
| integration.tools   | object[] | Herramientas externas integradas                          |
| agentId             | string   | Identificador único del agente                            |
| agentSecret         | string   | Token/clave para autenticación (si aplica)                |
| environment         | string   | Entorno: development, staging, production                 |

---

## 5.3. Ejemplo de Archivo de Configuración (JSON)

```json
{
  "agentId": "demo-agent-1",
  "governanceLevel": "supervised",
  "workspaceFolders": ["/proyecto/demo"],
  "capabilities": {
    "code-generation": true,
    "testing": true,
    "refactoring": false
  },
  "logging": {
    "level": "info",
    "path": "./logs/agent.log"
  },
  "integration": {
    "tools": [
      { "name": "ci-pipeline", "enabled": true },
      { "name": "static-analysis", "enabled": false }
    ]
  },
  "environment": "development"
}
```

---

## 5.4. Parámetros Clave

- **governanceLevel**: Define el grado de intervención humana. Valores típicos:
  - `autonomous`: El agente actúa sin intervención humana.
  - `supervised`: Requiere revisiones o aprobaciones en puntos críticos.
  - `human-in-the-loop`: Toda acción relevante requiere aprobación humana.

- **workspaceFolders**: Directorios de trabajo sobre los que opera el agente.

- **capabilities**: Funcionalidades habilitadas (ej. code-generation, testing, refactoring).

- **logging**: Configuración de logs para auditoría y depuración.

- **integration.tools**: Herramientas externas disponibles para el agente.

- **agentId / agentSecret**: Identificadores y credenciales para autenticación y trazabilidad.

- **environment**: Permite adaptar el comportamiento según el entorno (desarrollo, producción, etc.).

---

## 5.5. Buenas Prácticas para la Gestión de Configuración

- Usar archivos de configuración versionados y validados.
- Separar credenciales sensibles (ej. agentSecret) usando variables de entorno.
- Documentar todos los parámetros y valores posibles.
- Validar la configuración al inicio y ante cambios dinámicos.
- Permitir la sobreescritura de parámetros por línea de comandos o variables de entorno.
- Mantener la configuración modular para facilitar la extensión y personalización.

---

> **Nota:** La configuración puede evolucionar según las necesidades del sistema y los agentes. Se recomienda mantener compatibilidad hacia atrás y documentar los cambios. 