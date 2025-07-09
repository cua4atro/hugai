# HUGAI Methodology Documentation

A comprehensive documentation site for the HUGAI (Human-Guided AI Dev) Methodology, maintained with MkDocs Material. This repository contains the source files and configuration needed to build, serve, and publish the documentation in both English and Spanish.

Table of Contents
-----------------
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Local Development](#local-development)
- [Building the Site](#building-the-site)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

Overview
--------

The HUGAI Methodology provides a structured approach to design, develop, and maintain AI-driven solutions, emphasizing human-guided processes that augment developer capabilities. This documentation guides you through the core principles, lifecycle phases, tooling, agent-based workflows, and best practices for successful AI projects.

Prerequisites
-------------

- Python 3.8 or higher
- pip (Python package installer)

Installation
------------

1. Clone this repository:

       git clone https://github.com/hugaidev/methodology.git
       cd methodology

2. Install Python dependencies:

       pip install -r requirements.txt

Local Development
-----------------

Serve the documentation locally with live reloading (English or Spanish):

    ./manage.sh serve en      # English docs at http://127.0.0.1:8000
    ./manage.sh serve es      # Spanish docs at http://127.0.0.1:8001
    ./manage.sh serve both    # Both languages simultaneously

or, using MkDocs directly:

    mkdocs serve -f mkdocs-en.yml   # English
    mkdocs serve -f mkdocs-es.yml   # Spanish

Building the Site
-----------------

Generate the static site for deployment:

    ./manage.sh build both

or:

    mkdocs build -f mkdocs-en.yml -d site/en
    mkdocs build -f mkdocs-es.yml -d site/es

The built site will be available in the `site/` directory.

Project Structure
-----------------

    .
    ├── methodology/         # English methodology docs (was docs-en/metodologia)
    ├── protocol/            # English protocol docs (was docs-en/protocolo)
    │   └── specification/   # English protocol specification (was docs-en/protocolo/especificacion)
    ├── docs-es/             # Spanish documentation
    ├── material/            # Custom theme overrides (MkDocs Material)
    ├── mkdocs-en.yml        # English site configuration
    ├── mkdocs-es.yml        # Spanish site configuration
    ├── mkdocs-base.yml      # Shared MkDocs configuration
    ├── requirements.txt     # Python dependencies for building the site
    ├── manage.sh            # Script to build/serve/deploy the site
    ├── README.md            # This file (English)
    └── LEEME.md             # Spanish readme

Contributing
------------

We welcome contributions to improve and expand the HUGAI Methodology documentation. To contribute:

1. Fork the repository and create a new branch for your feature or fix.
2. Commit your changes with clear, descriptive messages.
3. Submit a pull request describing the changes and linking any relevant issues.

Please ensure your contributions follow the style guidelines and formatting conventions of Markdown and MkDocs Material.

License
-------

© 2024–2025 Sebastian Larrauri. Documentation is released under the Creative Commons Attribution 4.0 International (CC BY 4.0). For more details, see the `mkdocs.yml` license configuration.

---

> Para instrucciones en español, consulta el archivo [LEEME.md](LEEME.md).
