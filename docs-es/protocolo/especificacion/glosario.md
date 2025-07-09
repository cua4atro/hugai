# 11. Glosario y FAQ - Especificación HugAI v2

Esta sección proporciona definiciones de términos clave y responde preguntas frecuentes sobre el protocolo HugAI v2.

---

## 11.1. Glosario de Términos

- **Agente:** Entidad autónoma (software) que ejecuta tareas, colabora y se comunica mediante el protocolo.
- **Gobernanza:** Mecanismos y políticas para supervisar, aprobar y auditar acciones de agentes y humanos.
- **Capability:** Funcionalidad o tarea específica que un agente puede anunciar y ejecutar (ej. code-generation, testing).
- **Workspace:** Conjunto de carpetas o recursos sobre los que opera un agente.
- **Approval:** Proceso de revisión y autorización humana para acciones críticas.
- **Audit:** Registro detallado de acciones, decisiones y eventos para trazabilidad y cumplimiento.
- **Mensaje:** Estructura JSON intercambiada entre agentes, humanos y herramientas siguiendo el protocolo.
- **Extensión:** Adición de nuevos mensajes, capacidades o flujos al protocolo base.
- **Integración:** Conexión con herramientas externas (CI/CD, análisis, etc.) mediante mensajes estándar o custom.
- **Human-in-the-loop:** Modelo donde la intervención humana es obligatoria en puntos críticos.
- **Supervised:** Modelo donde la intervención humana es opcional o en puntos definidos.
- **Autonomous:** Modelo donde los agentes actúan sin intervención humana.

---

## 11.2. Preguntas Frecuentes (FAQ)

**¿Qué es HugAI v2 y para qué sirve?**
> Es un protocolo abierto para orquestar agentes de IA y humanos en procesos de desarrollo y automatización, con gobernanza y trazabilidad.

**¿Cómo se extiende el protocolo?**
> Añadiendo nuevos tipos de mensajes, capacidades o agentes siguiendo el esquema JSON-RPC y documentando la extensión.

**¿Qué mecanismos de seguridad existen?**
> Autenticación de agentes y humanos, validación de mensajes, auditoría, uso de canales cifrados y gestión segura de secretos.

**¿Puedo integrar mis propias herramientas?**
> Sí, mediante mensajes `tool/integration` o extensiones custom, siempre siguiendo las buenas prácticas de validación y seguridad.

**¿Qué pasa si un agente recibe un mensaje desconocido?**
> Debe ignorarlo (si no es crítico) o responder con un error estándar, manteniendo la robustez y compatibilidad.

**¿Cómo se gestiona la configuración?**
> Mediante archivos (JSON/YAML), variables de entorno y parámetros en tiempo de ejecución, siguiendo las buenas prácticas documentadas.

**¿Qué niveles de gobernanza existen?**
> Autonomous, supervised y human-in-the-loop, según el grado de intervención humana requerido.

**¿Cómo se auditan las acciones?**
> Usando el mensaje `audit/log` para registrar actor, acción, timestamp, detalles y resultado en sistemas protegidos.

**¿El protocolo es compatible con JSON-RPC?**
> Sí, se basa en JSON-RPC 2.0 para la estructura de mensajes y extensibilidad.

---

> **Nota:** Para dudas adicionales, sugerencias o contribuciones, consultar la documentación oficial o contactar con los responsables del protocolo. 