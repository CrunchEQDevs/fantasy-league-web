#!/usr/bin/env bash
set -euo pipefail

### ========================
### CONFIGS — ajuste se precisar
### ========================
WEB_REPO_URL="https://github.com/CrunchEQDevs/fantasy-league-web.git"

# Aceita parâmetro para definir branch: ./deploy_web.sh dev ou ./deploy_web.sh main
# Se não passar nada, usa main por padrão
if [ "${1:-}" == "dev" ]; then
  WEB_BRANCH="dev"
  echo "🔧 Modo DEV ativado - Deploy para branch dev"
else
  WEB_BRANCH="main"
  echo "🚀 Modo PRODUÇÃO - Deploy para branch main"
fi

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
FRONTEND_DIR="$ROOT_DIR/frontend"
WEB_BUILD_DIR="$FRONTEND_DIR/build/web"
VERCEL_JSON_SOURCE="$ROOT_DIR/vercel.json"          # opcional (se existir na raiz)
VERCEL_JSON_FALLBACK="$FRONTEND_DIR/web/vercel.json" # opcional (se existir em frontend/web)

### ========================
### 0) Commit/push do repo principal (se houver mudanças)
### ========================
echo "🔎 Verificando mudanças no repo principal (Fantasy-League)…"
pushd "$ROOT_DIR" >/dev/null
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "❌ Este diretório não é um repositório git. Abra a pasta 'Fantasy-League'."
  exit 1
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
  read -r -p "📝 Mensagem do commit do repo principal: " MSG || true
  MSG="${MSG:-chore: update before web deploy}"
  git add .
  git commit -m "$MSG" || true
  echo "⬆️  Enviando para o remoto do repo principal…"
  CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  git push -u origin "$CURRENT_BRANCH"
else
  echo "✅ Nenhuma mudança para commitar no repo principal."
fi
popd >/dev/null

### ========================
### 1) Build Flutter Web (release)
### ========================
echo "🛠️  Gerando build Flutter Web…"
pushd "$FRONTEND_DIR" >/dev/null
flutter build web --release
popd >/dev/null

### ========================
### 2) Garantir vercel.json em build/web
### ========================
mkdir -p "$WEB_BUILD_DIR"
if [ -f "$VERCEL_JSON_SOURCE" ]; then
  cp -f "$VERCEL_JSON_SOURCE" "$WEB_BUILD_DIR/vercel.json"
elif [ -f "$VERCEL_JSON_FALLBACK" ]; then
  cp -f "$VERCEL_JSON_FALLBACK" "$WEB_BUILD_DIR/vercel.json"
elif [ ! -f "$WEB_BUILD_DIR/vercel.json" ]; then
  cat > "$WEB_BUILD_DIR/vercel.json" <<'JSON'
{
  "cleanUrls": true,
  "trailingSlash": false,
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "Cache-Control", "value": "public, max-age=0, must-revalidate" }
      ]
    }
  ],
  "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
}
JSON
fi
echo "✅ vercel.json OK em $WEB_BUILD_DIR"

### ========================
### 3) Commit/push do repo web (fantasy-league-web)
### ========================
echo "🌐 Preparando repositório web em ${WEB_BUILD_DIR}…"

# Garante que a variável existe e o caminho é válido
if [ -z "${WEB_BUILD_DIR:-}" ] || [ ! -d "${WEB_BUILD_DIR}" ]; then
  echo "❌ WEB_BUILD_DIR inválido: '${WEB_BUILD_DIR}'"
  exit 1
fi

cd "${WEB_BUILD_DIR}"

if [ ! -d .git ]; then
  echo "🔧 Inicializando repositório web local…"
  git init
  git checkout -b "${WEB_BRANCH}"
  git remote add origin "${WEB_REPO_URL}"
else
  git remote set-url origin "${WEB_REPO_URL}"
  git checkout "${WEB_BRANCH}" 2>/dev/null || git checkout -b "${WEB_BRANCH}"
fi

git add -A
git commit -m "deploy web build - $(date '+%Y-%m-%d %H:%M:%S')" || echo "ℹ️  Nada novo para commitar."
echo "⬆️  Enviando build para ${WEB_REPO_URL} (${WEB_BRANCH})…"
git push -u origin "${WEB_BRANCH}"

echo ""
echo "✅ Deploy concluído com sucesso!"
if [ "$WEB_BRANCH" == "dev" ]; then
  echo "🔗 URL de Preview (dev): https://fantasy-league-web-git-dev-cruncheqdevs.vercel.app"
else
  echo "🔗 URL de Produção: https://fantasy-league-web-blue.vercel.app"
fi
