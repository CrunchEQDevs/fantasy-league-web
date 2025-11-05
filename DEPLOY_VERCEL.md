# 🚀 Deploy na Vercel - Fantasy League

## ❌ COMANDOS ERRADOS (NÃO USAR):
```bash
# ❌ NÃO FAÇA ISSO:
flutter build web --release
cd build/web
git add .
git commit -m "update web build"
git push
```

**Problemas:**
1. A pasta `build/` não deve ser commitada no git (está no .gitignore)
2. A Vercel faz o build automaticamente
3. Commitando build você aumenta o tamanho do repositório desnecessariamente

---

## ✅ COMANDOS CORRETOS:

### Opção 1: Deploy via CLI da Vercel (Recomendado)

#### 1. Instalar Vercel CLI
```bash
npm install -g vercel
```

#### 2. Fazer login
```bash
vercel login
```

#### 3. Deploy
```bash
# Na raiz do projeto
vercel
```

#### 4. Para produção
```bash
vercel --prod
```

---

### Opção 2: Deploy via GitHub (Mais Simples)

#### 1. Commit apenas o código-fonte
```bash
git add .
git commit -m "Preparar para deploy web"
git push origin main
```

#### 2. Conectar na Vercel
1. Acesse [vercel.com](https://vercel.com)
2. Faça login com sua conta GitHub
3. Clique em "Add New Project"
4. Importe o repositório `fantasy-league`
5. Configure:
   - **Framework Preset**: Other
   - **Build Command**: `cd frontend && flutter build web --release`
   - **Output Directory**: `frontend/build/web`
   - **Install Command**: deixe em branco (Flutter deve estar pré-instalado)

#### 3. Deploy automático
- Toda vez que você fizer `git push`, a Vercel faz deploy automaticamente!

---

## 📋 Arquivos Necessários

Já foram criados:

✅ `vercel.json` - Configuração da Vercel
```json
{
  "buildCommand": "cd frontend && flutter build web --release",
  "outputDirectory": "frontend/build/web",
  "installCommand": "echo 'Flutter should be pre-installed on Vercel'",
  "framework": null,
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

✅ `.vercelignore` - Arquivos a ignorar no deploy

---

## 🔧 Workflow Correto

### Para desenvolvimento:
```bash
# 1. Fazer mudanças no código
# 2. Testar localmente
flutter run -d chrome

# 3. Commit apenas o código-fonte
git add frontend/lib/ frontend/pubspec.yaml
git commit -m "feat: adicionar nova funcionalidade"
git push
```

### Para produção:
```bash
# 1. Testar o build localmente
cd frontend
flutter build web --release

# 2. Testar o build
cd build/web
python3 -m http.server 8000
# Abrir http://localhost:8000

# 3. Se estiver OK, fazer commit do código (NÃO do build)
cd ../..
git add .
git commit -m "ready for production"
git push

# 4. A Vercel faz o build e deploy automaticamente
```

---

## 🌐 Acessar o Site

Após o deploy, você receberá uma URL tipo:
- `https://fantasy-league-xxx.vercel.app`

Você pode configurar um domínio customizado nas configurações da Vercel.

---

## 🔍 Verificar Status do Deploy

Via CLI:
```bash
vercel list
vercel inspect [deployment-url]
```

Via Dashboard:
- Acesse [vercel.com/dashboard](https://vercel.com/dashboard)
- Veja os deploys, logs e status

---

## 🐛 Solução de Problemas

### Build falha na Vercel
- A Vercel precisa ter Flutter instalado
- Pode ser necessário usar um template/buildpack específico
- Alternativa: Use GitHub Actions para fazer o build e deploy

### Assets não carregam
- Verifique se os assets estão no `pubspec.yaml`
- Verifique se a pasta `assets/` está commitada no git

### Rotas não funcionam
- O `vercel.json` já está configurado para SPA
- Todas as rotas redirecionam para `index.html`

---

## 📝 Resumo

**✅ Fazer:**
- Commitar apenas código-fonte (`lib/`, `pubspec.yaml`, `assets/`)
- Deixar a Vercel fazer o build
- Usar git push para deploy automático

**❌ Não fazer:**
- Commitar pasta `build/`
- Commitar `.dart_tool/`
- Fazer build manual e commitar

---

## 🎯 Comando Rápido

```bash
# Workflow completo em um comando:
git add . && git commit -m "deploy: atualizar versão web" && git push
```

A Vercel cuida do resto! 🚀
