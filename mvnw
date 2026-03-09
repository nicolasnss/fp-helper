#!/usr/bin/env bash
# /* Autor: Nicolas - Analista de Sistemas | 2026 */

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WRAPPER_DIR="$BASEDIR/.mvn/wrapper"
PROPERTIES_FILE="$WRAPPER_DIR/maven-wrapper.properties"

if [ ! -f "$PROPERTIES_FILE" ]; then
  echo "Erro: arquivo $PROPERTIES_FILE não encontrado." >&2
  exit 1
fi

DIST_URL="$(grep '^distributionUrl=' "$PROPERTIES_FILE" | cut -d'=' -f2-)"
if [ -z "$DIST_URL" ]; then
  echo "Erro: propriedade distributionUrl não definida em $PROPERTIES_FILE." >&2
  exit 1
fi

DIST_ZIP_NAME="$(basename "$DIST_URL")"
MAVEN_DIR_NAME="${DIST_ZIP_NAME%.zip}"
MAVEN_DIR="$WRAPPER_DIR/$MAVEN_DIR_NAME"
DIST_ZIP_PATH="$WRAPPER_DIR/$DIST_ZIP_NAME"

mkdir -p "$WRAPPER_DIR"

if [ ! -d "$MAVEN_DIR" ]; then
  echo "Baixando Maven de $DIST_URL..."
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL -o "$DIST_ZIP_PATH" "$DIST_URL"
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$DIST_ZIP_PATH" "$DIST_URL"
  else
    echo "Erro: nem curl nem wget encontrados para baixar o Maven." >&2
    exit 1
  fi

  echo "Extraindo Maven para $MAVEN_DIR..."
  if command -v unzip >/dev/null 2>&1; then
    unzip -q "$DIST_ZIP_PATH" -d "$WRAPPER_DIR"
  else
    echo "Erro: unzip não encontrado para extrair o Maven." >&2
    exit 1
  fi
fi

MVN_CMD="$MAVEN_DIR/bin/mvn"

if [ ! -x "$MVN_CMD" ]; then
  echo "Erro: comando Maven não encontrado em $MVN_CMD." >&2
  exit 1
fi

exec "$MVN_CMD" "$@"

