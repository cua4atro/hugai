# Documentación de la Metodología HUGAI

Sitio de documentación integral para la Metodología HUGAI (Human-Guided AI Dev), mantenido con MkDocs Material. Este repositorio contiene los archivos fuente y la configuración necesarios para construir, servir y publicar la documentación en español e inglés.

Tabla de Contenidos
-------------------
- [Resumen](#resumen)
- [Requisitos](#requisitos)
- [Instalación](#instalacion)
- [Desarrollo Local](#desarrollo-local)
- [Construcción del Sitio](#construccion-del-sitio)
- [Despliegue](#despliegue)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)

Resumen
-------

La Metodología HUGAI proporciona un enfoque estructurado para diseñar, desarrollar y mantener soluciones impulsadas por IA, enfatizando procesos guiados por humanos que potencian las capacidades de los desarrolladores. Esta documentación te guía a través de los principios, fases del ciclo de vida, herramientas, flujos de trabajo basados en agentes y mejores prácticas para proyectos de IA exitosos.

Requisitos
----------

- Python 3.8 o superior
- pip (gestor de paquetes de Python)

Instalación
-----------

1. Clona este repositorio:

       git clone https://github.com/hugaidev/methodology.git
       cd methodology

2. Instala las dependencias de Python:

       pip install -r requirements.txt

Desarrollo Local
----------------

Sirve la documentación localmente con recarga en vivo (español o inglés):

    ./manage.sh serve es      # Documentación en español en http://127.0.0.1:8001
    ./manage.sh serve en      # Documentación en inglés en http://127.0.0.1:8000
    ./manage.sh serve both    # Ambos idiomas simultáneamente

O usando MkDocs directamente:

    mkdocs serve -f mkdocs-es.yml   # Español
    mkdocs serve -f mkdocs-en.yml   # Inglés

Construcción del Sitio
----------------------

Genera el sitio estático para despliegue:

    ./manage.sh build both

o:

    mkdocs build -f mkdocs-es.yml -d site/es
    mkdocs build -f mkdocs-en.yml -d site/en

El sitio generado estará disponible en el directorio `site/`.

Despliegue
----------

Para desplegar la documentación (ambos idiomas) en GitHub Pages:

1. Construye el sitio para ambos idiomas:

       ./manage.sh build both

2. Despliega en GitHub Pages (requiere ghp-import):

       ./manage.sh deploy

   Esto publicará el contenido del directorio `site/` en la rama `gh-pages` y hará la documentación accesible en:

       https://docs.hugai.dev

   > Nota: Debes tener instalado `ghp-import` (`pip install ghp-import`) y permisos de push en el repositorio.

Estructura del Proyecto
-----------------------

    .
    ├── methodology/         # Documentación de metodología en inglés
    ├── protocol/            # Documentación de protocolo en inglés
    │   └── specification/   # Especificación del protocolo en inglés
    ├── docs-es/             # Documentación en español
    ├── material/            # Personalizaciones de tema (MkDocs Material)
    ├── mkdocs-en.yml        # Configuración del sitio en inglés
    ├── mkdocs-es.yml        # Configuración del sitio en español
    ├── mkdocs-base.yml      # Configuración compartida de MkDocs
    ├── requirements.txt     # Dependencias de Python
    ├── manage.sh            # Script para construir/servir/desplegar el sitio
    ├── README.md            # Este archivo (inglés)
    └── LEEME.md             # Este archivo (español)

Contribuciones
--------------

¡Se agradecen contribuciones para mejorar y expandir la documentación de la Metodología HUGAI! Para contribuir:

1. Haz un fork del repositorio y crea una nueva rama para tu mejora o corrección.
2. Realiza tus cambios con mensajes de commit claros y descriptivos.
3. Envía un pull request describiendo los cambios y vinculando cualquier issue relevante.

Por favor, asegúrate de seguir las guías de estilo y convenciones de formato de Markdown y MkDocs Material.

Licencia
--------

© 2024–2025 Sebastian Larrauri. La documentación se publica bajo la licencia Creative Commons Atribución 4.0 Internacional (CC BY 4.0). Para más detalles, consulta la configuración de licencia en `mkdocs.yml`.

---

> For English instructions, see [README.md](README.md). 