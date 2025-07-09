#!/bin/bash

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Idiomas soportados
LANGS=("en" "es")

# Cargar variables de entorno desde .env si existe
if [[ -f .env ]]; then
  set -o allexport
  source .env
  set +o allexport
fi

# Función para mostrar ayuda
show_help() {
  echo -e "${BLUE}HUG AI DEV - Gestor de Documentación Multilenguaje${NC}"
  echo ""
  echo "Uso: $0 [COMANDO] [IDIOMA]"
  echo ""
  echo "COMANDOS:"
  echo "  build    - Construir la documentación"
  echo "  serve    - Servir la documentación localmente"
  echo "  deploy   - Desplegar a GitHub Pages"
  echo "  clean    - Limpiar archivos generados"
  echo "  kill     - Matar procesos de mkdocs y liberar puertos"
  echo "  restart  - Matar procesos y servir documentación"
  echo "  help     - Mostrar esta ayuda"
  echo ""
  echo "IDIOMAS:"
  echo "  en       - Inglés"
  echo "  es       - Español"
  echo "  both     - Ambos idiomas"
  echo ""
  echo "EJEMPLOS:"
  echo "  $0 build both     # Construir ambos idiomas"
  echo "  $0 serve en       # Servir solo inglés en puerto 8000"
  echo "  $0 serve es       # Servir solo español en puerto 8001"
  echo "  $0 serve both     # Servir ambos en puertos 8000 y 8001"
  echo "  $0 kill           # Matar procesos de mkdocs y liberar puertos"
  echo "  $0 restart both   # Matar procesos y servir ambos idiomas"
  echo "  $0 deploy         # Desplegar ambos idiomas a GitHub Pages"
  echo ""
}

# Función para verificar dependencias
check_dependencies() {
  echo -e "${BLUE}Verificando dependencias...${NC}"
  
  # Verificar Python
  if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Error: Python 3 no está instalado${NC}"
    exit 1
  fi
  
  # Verificar ghp-import para deploy
  if ! command -v ghp-import &> /dev/null; then
    echo -e "${YELLOW}Advertencia: ghp-import no está instalado. Instalando...${NC}"
    pip install ghp-import
  fi
  
  # Verificar y configurar Cairo en macOS
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e "${BLUE}Configurando Cairo para macOS...${NC}"
    
    # Verificar si Cairo está instalado con Homebrew
    if brew list cairo &> /dev/null; then
      echo -e "${YELLOW}Cairo detectado, configurando variables de entorno...${NC}"
      
      # Configurar variables de entorno para que cairosvg encuentre las librerías
      export DYLD_LIBRARY_PATH="/opt/homebrew/lib:/opt/homebrew/opt/cairo/lib:$DYLD_LIBRARY_PATH"
      export DYLD_FALLBACK_LIBRARY_PATH="/opt/homebrew/lib:/opt/homebrew/opt/cairo/lib:$DYLD_FALLBACK_LIBRARY_PATH"
      export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:/opt/homebrew/opt/libffi/lib/pkgconfig:$PKG_CONFIG_PATH"
      
      echo -e "${GREEN}✓ Variables de entorno de Cairo configuradas${NC}"
    else
      echo -e "${YELLOW}Advertencia: Cairo no está instalado. Instalando...${NC}"
      brew install cairo pango gdk-pixbuf libffi
      
      # Configurar variables de entorno después de la instalación
      export DYLD_LIBRARY_PATH="/opt/homebrew/lib:/opt/homebrew/opt/cairo/lib:$DYLD_LIBRARY_PATH"
      export DYLD_FALLBACK_LIBRARY_PATH="/opt/homebrew/lib:/opt/homebrew/opt/cairo/lib:$DYLD_FALLBACK_LIBRARY_PATH"
      export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:/opt/homebrew/opt/libffi/lib/pkgconfig:$PKG_CONFIG_PATH"
      
      echo -e "${GREEN}✓ Cairo instalado y variables configuradas${NC}"
    fi
  fi
  
  echo -e "${GREEN}✓ Dependencias verificadas${NC}"
}

# Función para preparar entorno virtual
setup_venv() {
  if [[ ! -d ".venv" ]]; then
    echo -e "${BLUE}Creando entorno virtual...${NC}"
    python3 -m venv .venv
  fi

  source .venv/bin/activate

  echo -e "${BLUE}Instalando dependencias desde requirements.txt...${NC}"
  pip install -r requirements.txt
  echo -e "${GREEN}✓ Entorno virtual configurado${NC}"
}

# Función para copiar y reemplazar el index de redirección
copy_redirect_index() {
  local ga_id=${GOOGLE_ANALYTICS_KEY:-G-XXXXXXXXXX}
  if [[ -f "public/index.html" ]]; then
    mkdir -p site
    sed "s/{{GA_ID}}/$ga_id/g" public/index.html > site/index.html
    echo -e "${GREEN}✓ index.html de redirección copiado a site/index.html con GA_ID=${ga_id}${NC}"
  else
    echo -e "${YELLOW}Advertencia: public/index.html no existe, no se copió index de redirección${NC}"
  fi
}

# Función para reemplazar temporalmente el GA_ID en mkdocs-base.yml
backup_and_replace_ga_id() {
  local ga_id=${GOOGLE_ANALYTICS_KEY:-G-XXXXXXXXXX}
  local yml_file="mkdocs-base.yml"
  local backup_file="${yml_file}.bak"
  cp "$yml_file" "$backup_file"
  # Reemplaza la línea property: !ENV GOOGLE_ANALYTICS_KEY por property: $ga_id
  sed -i '' "s/property: !ENV GOOGLE_ANALYTICS_KEY/property: $ga_id/" "$yml_file"
}

restore_ga_id_yml() {
  local yml_file="mkdocs-base.yml"
  local backup_file="${yml_file}.bak"
  if [[ -f "$backup_file" ]]; then
    mv "$backup_file" "$yml_file"
  fi
}

# Función para construir documentación
build_docs() {
  local target=$1
  echo -e "${BLUE}Construyendo documentación para: ${target}${NC}"
  backup_and_replace_ga_id
  
  # Configurar variables de entorno para Cairo en macOS
  if [[ "$OSTYPE" == "darwin"* ]]; then
    export DYLD_LIBRARY_PATH="/opt/homebrew/lib:/opt/homebrew/opt/cairo/lib:$DYLD_LIBRARY_PATH"
    export DYLD_FALLBACK_LIBRARY_PATH="/opt/homebrew/lib:/opt/homebrew/opt/cairo/lib:$DYLD_FALLBACK_LIBRARY_PATH"
    export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:/opt/homebrew/opt/libffi/lib/pkgconfig:$PKG_CONFIG_PATH"
  fi
  
  if [[ "$target" == "both" ]]; then
    echo -e "${YELLOW}Construyendo versión en inglés...${NC}"
    mkdocs build -f mkdocs-en.yml -d site/en
    
    echo -e "${YELLOW}Construyendo versión en español...${NC}"
    mkdocs build -f mkdocs-es.yml -d site/es
    
    echo -e "${GREEN}✓ Ambas versiones construidas${NC}"
  else
    echo -e "${YELLOW}Construyendo versión en ${target}...${NC}"
    mkdocs build -f "mkdocs-$target.yml" -d "site/$target"
    echo -e "${GREEN}✓ Versión ${target} construida${NC}"
  fi
  restore_ga_id_yml
  copy_redirect_index
}

# Función para servir documentación
serve_docs() {
  local target=$1
  echo -e "${BLUE}Sirviendo documentación para: ${target}${NC}"
  
  # Configurar variables de entorno para Cairo en macOS
  if [[ "$OSTYPE" == "darwin"* ]]; then
    export DYLD_LIBRARY_PATH="/opt/homebrew/lib:/opt/homebrew/opt/cairo/lib:$DYLD_LIBRARY_PATH"
    export DYLD_FALLBACK_LIBRARY_PATH="/opt/homebrew/lib:/opt/homebrew/opt/cairo/lib:$DYLD_FALLBACK_LIBRARY_PATH"
    export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:/opt/homebrew/opt/libffi/lib/pkgconfig:$PKG_CONFIG_PATH"
  fi
  
  if [[ "$target" == "both" ]]; then
    echo -e "${YELLOW}Iniciando servidor inglés en http://127.0.0.1:8000${NC}"
    mkdocs serve -f mkdocs-en.yml -a 127.0.0.1:8000 &
    local en_pid=$!
    
    echo -e "${YELLOW}Iniciando servidor español en http://127.0.0.1:8001${NC}"
    mkdocs serve -f mkdocs-es.yml -a 127.0.0.1:8001 &
    local es_pid=$!
    
    echo -e "${GREEN}✓ Ambos servidores iniciados${NC}"
    echo -e "${BLUE}Presiona Ctrl+C para detener ambos servidores${NC}"
    echo -e "${YELLOW}Nota: El selector de idioma funciona correctamente en producción${NC}"
    
    # Esperar a que ambos procesos terminen
    wait $en_pid $es_pid
  else
    local port=8000
    [[ "$target" == "es" ]] && port=8001
    
    echo -e "${YELLOW}Iniciando servidor ${target} en http://127.0.0.1:${port}${NC}"
    mkdocs serve -f "mkdocs-$target.yml" -a 127.0.0.1:$port
  fi
}

# Función para desplegar
deploy_docs() {
  echo -e "${BLUE}Iniciando despliegue a GitHub Pages...${NC}"
  
  # Construir ambas versiones
  build_docs "both"
  
  # copy_redirect_index ya se llama desde build_docs
  
  # Configurar CNAME para dominio personalizado
  echo "docs.hugai.dev" > site/CNAME
  
  # Crear archivo .nojekyll para GitHub Pages
  touch site/.nojekyll
  
  echo -e "${YELLOW}Publicando en GitHub Pages...${NC}"
  
  # Verificar si ghp-import está disponible
  if command -v ghp-import &> /dev/null; then
    ghp-import -n -p -f site
    echo -e "${GREEN}✓ Despliegue completado exitosamente${NC}"
    echo -e "${BLUE}El sitio estará disponible en: https://docs.hugai.dev${NC}"
  else
    echo -e "${RED}Error: ghp-import no está disponible${NC}"
    echo -e "${YELLOW}Instala ghp-import con: pip install ghp-import${NC}"
    exit 1
  fi
}

# Función para limpiar
clean_docs() {
  echo -e "${BLUE}Limpiando archivos generados...${NC}"
  
  if [[ -d "site" ]]; then
    rm -rf site
    echo -e "${GREEN}✓ Directorio site eliminado${NC}"
  fi
  
  if [[ -d ".cache" ]]; then
    rm -rf .cache
    echo -e "${GREEN}✓ Directorio .cache eliminado${NC}"
  fi
  
  echo -e "${GREEN}✓ Limpieza completada${NC}"
}

# Función para matar procesos de mkdocs serve
kill_mkdocs_processes() {
  echo -e "${YELLOW}Matando procesos de mkdocs serve...${NC}"
  pkill -f "mkdocs serve" 2>/dev/null || true
  echo -e "${GREEN}✓ Procesos de mkdocs serve terminados${NC}"
}

# CLI principal
ACTION=$1
TARGET=$2

# Mostrar ayuda si no hay argumentos o si se solicita
if [[ -z "$ACTION" || "$ACTION" == "help" || "$ACTION" == "-h" || "$ACTION" == "--help" ]]; then
  show_help
  exit 0
fi

# Validación de argumentos
if [[ -z "$TARGET" ]]; then
  case "$ACTION" in
    deploy|clean|kill)
      # deploy, clean y kill no necesitan target
      ;;
    *)
      echo -e "${RED}Error: Se requiere especificar el idioma (en|es|both)${NC}"
      echo ""
      show_help
      exit 1
      ;;
  esac
fi

# Validar idioma si se especifica
if [[ -n "$TARGET" && "$TARGET" != "both" ]]; then
  if [[ ! " ${LANGS[@]} " =~ " ${TARGET} " ]]; then
    echo -e "${RED}Error: Idioma no válido. Usa: en, es, o both${NC}"
    exit 1
  fi
fi

# Verificar dependencias
check_dependencies

# Preparar entorno virtual
setup_venv

# Ejecutar acción seleccionada
case "$ACTION" in
  build)
    build_docs "$TARGET"
    ;;
    
  serve)
    serve_docs "$TARGET"
    ;;
    
  deploy)
    deploy_docs
    ;;
    
  clean)
    clean_docs
    ;;
    
  kill)
    kill_mkdocs_processes
    ;;
    
  restart)
    kill_mkdocs_processes
    exec "$0" serve "$TARGET"
    ;;
    
  *)
    echo -e "${RED}Error: Acción no válida: $ACTION${NC}"
    echo ""
    show_help
    exit 1
    ;;
esac
