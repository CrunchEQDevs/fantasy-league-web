# 🚀 Deploy na Vercel - Fantasy League

🔹 Passos rápidos no terminal

Sempre na raiz do projeto principal (fantasy-league):

# 1️⃣ Garanta que está tudo salvo e commitado no projeto principal
git add .
git commit -m "atualiza tela de login" 
git push

# 2️⃣ Gere a nova versão da web
cd frontend
flutter build web --release

# 3️⃣ Vá para a pasta da build
cd build/web

# 4️⃣ Faça o deploy pro repositório da web
git add -A
git commit -m "deploy nova versão web"
git push -u origin main --force



Repositorio para o Git
Repositório Fantasy-League (principal)

git add .
git commit -m "corrige menu e ajustes gerais"
git push


Repositório fantasy-league-web

cd frontend
flutter build web --release
cp vercel.json build/web/
cd build/web
git add .
git commit -m "nova build web"
git push



./deploy_web.sh


git push -u origin main --force


Essa é a versao tudo junto.
#!/bin/bash
cd frontend
flutter build web --release
cd build/web
git add -A
git commit -m "deploy web $(date '+%Y-%m-%d %H:%M')"
git push -u origin main --force



verificar - para limpar 
cd frontend
flutter analyze
flutter run
Flutter Lint / Dart Analyzer


para formatar 
flutter format .
