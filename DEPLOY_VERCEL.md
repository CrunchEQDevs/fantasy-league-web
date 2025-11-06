# 🚀 Deploy na Vercel - Fantasy League

## 📋 Opções de Deploy

### ✅ Método Recomendado: Script Automatizado

Na raiz do projeto `fantasy-league`, use:

```bash
# Deploy para PRODUÇÃO (branch main)
./deploy_web.sh

# Deploy para DEV (branch dev)
./deploy_web.sh dev
```

O script faz automaticamente:
1. Verifica e commita mudanças no repo principal
2. Gera build Flutter web --release
3. Copia vercel.json necessário
4. Faz push para o repositório fantasy-league-web na branch correta
5. Mostra a URL do deploy

---

## 🔗 URLs dos Ambientes

- **Produção (main)**: https://fantasy-league-web-blue.vercel.app
- **Dev (dev)**: https://fantasy-league-web-git-dev-cruncheqdevs.vercel.app

A Vercel cria automaticamente um preview deployment para a branch dev!

---

## 📝 Método Manual (se necessário)

### Deploy Produção
```bash
cd frontend
flutter build web --release
cd build/web
git add -A
git commit -m "deploy web $(date '+%Y-%m-%d %H:%M')"
git push -u origin main
```

### Deploy Dev
```bash
cd frontend
flutter build web --release
cd build/web
git checkout dev  # ou git checkout -b dev se não existir
git add -A
git commit -m "deploy dev $(date '+%Y-%m-%d %H:%M')"
git push -u origin dev
```

---

## 🛠️ Ferramentas Úteis

### Verificar código antes do deploy
```bash
cd frontend
flutter analyze
flutter format .
```

### Testar localmente
```bash
cd frontend
flutter run -d chrome
```
