# 🚀 Deploy na Vercel - Fantasy League

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
