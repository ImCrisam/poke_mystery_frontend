#!/bin/bash
set -e

MODEL_NAME="Qwen3-Coder-30B-A3B-Instruct-UD-IQ1_S.gguf"

MODEL_PATH="/models/$MODEL_NAME"
MODEL_URL="https://huggingface.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF/resolve/main/$MODEL_NAME"

# Crear carpeta si no existe
mkdir -p /models
echo MODEL_URL
if [ ! -f "$MODEL_PATH" ]; then
  echo "Descargando modelo..."
  curl -L -o "$MODEL_PATH" "$MODEL_URL"
else
  echo "Modelo ya existe en $MODEL_PATH"
fi

exec ./llama-server \
  --model "$MODEL_PATH" \
  --ctx-size 32768 \
  --jinja \
  -ub 2048 \
  -b 2048 \
  --port 8000 \
  --host 0.0.0.0
