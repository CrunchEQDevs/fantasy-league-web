# Guia: Primeiro Commit Flutter no Git

## Comandos Flutter vs npm/Node.js

### JavaScript/Node.js
```bash
npm run lint
npm run build
```

### Flutter (equivalentes)
```bash
flutter analyze     # análise estática (lint)
flutter format .    # formatação de código
flutter test        # testes
flutter build       # compilação (opcional)
```

---

## Workflow Recomendado para Primeiro Commit

### 1. Análise de Código (Lint)
```bash
flutter analyze
```
- Verifica problemas no código
- Detecta erros, warnings e sugestões
- **Recomendado:** corrigir todos os erros antes de commitar

### 2. Formatação de Código
```bash
flutter format .
dart format .

```
- Formata todo o código seguindo o style guide do Dart
- Garante consistência no código

### 3. Testes (se existirem)
```bash
flutter test
Test directory "test" not found.

```
- Roda todos os testes do projeto
- **Importante:** garantir que todos os testes passem

### 4. Build (Opcional)
```bash
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web
flutter build appbundle  # Android App Bundle
```
**⚠️ IMPORTANTE:** Os arquivos de build **NÃO devem ser commitados**

---

## Comandos Git - Primeiro Commit

```bash
# 1. Verificar status
git status

# 2. Adicionar arquivos
git add .

# 3. Criar commit
git commit -m "Initial commit: Flutter project setup"

# 4. Criar/renomear branch para main
git branch -M main

# 5. Adicionar repositório remoto
git remote add origin https://github.com/seu-usuario/seu-repo.git

# 6. Enviar para o GitHub
git push -u origin main
```

---

## Arquivos que NÃO devem ser commitados

O `.gitignore` padrão do Flutter já exclui:

- `build/` - arquivos compilados
- `.dart_tool/` - ferramentas do Dart
- `.flutter-plugins` - plugins cache
- `.flutter-plugins-dependencies`
- `.packages` - dependências (deprecated)
- `*.iml` - arquivos do IntelliJ
- `.idea/` - configurações do Android Studio
- `*.apk` - binários Android
- `*.ipa` - binários iOS

---

## Checklist Antes do Primeiro Commit

- [ ] `flutter analyze` sem erros
- [ ] `flutter format .` aplicado
- [ ] `flutter test` passando (se tiver testes)
- [ ] `.gitignore` configurado corretamente
- [ ] Arquivos sensíveis não incluídos (.env, keys, etc)
- [ ] README.md criado/atualizado

---

## Comandos Úteis Pós-Commit

```bash
# Ver histórico de commits
git log --oneline

# Ver diferenças antes de commitar
git diff

# Ver status do repositório
git status

# Verificar saúde do projeto Flutter
flutter doctor
```

---

## Workflow Contínuo (commits seguintes)

```bash
# 1. Verificar mudanças
git status

# 2. Analisar código
flutter analyze

# 3. Formatar
flutter format .

# 4. Testar
flutter test

# 5. Commitar
git add .
git commit -m "feat: descrição da mudança"
git push
```

---

## Dicas

1. **Mensagens de commit**: Use conventional commits
   - `feat:` - nova feature
   - `fix:` - correção de bug
   - `docs:` - documentação
   - `style:` - formatação
   - `refactor:` - refatoração
   - `test:` - testes
   - `chore:` - tarefas gerais

2. **Branches**: Use branches para features
   ```bash
   git checkout -b feature/nova-funcionalidade
   ```

3. **Pre-commit hooks**: Configure hooks para rodar `flutter analyze` automaticamente

4. **CI/CD**: Configure GitHub Actions para rodar testes automaticamente


PARA BOUBLICAER NA VERSAO WEB 



flutter build web --release
cd build/web
git add .
git commit -m "update web build"
git push


envia para a versao web, roda isso e depois o normal.
flutter build web --release
