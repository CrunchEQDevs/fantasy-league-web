# Guia de Início Rápido - Fantasy League

### 1️⃣ Configurar Banco de Dados

```bash
# Entrar no MySQL
mysql -u root -p

# No prompt do MySQL, executar:
source database/schema.sql
source database/seeds.sql
exit
```

Ou se preferir em uma linha:
```bash
mysql -u root -p < database/schema.sql
mysql -u root -p fantasy_league < database/seeds.sql
```

### 2️⃣ Iniciar Backend (API PHP)

```bash
cd backend/api
php -S localhost:8000
```

**Testar se está funcionando:**
```bash
curl http://localhost:8000/health
```

Você deve ver:
```json
{
  "success": true,
  "message": "API está funcionando",
  "data": {
    "status": "online",
    "timestamp": "2025-10-23 15:30:00",
    "version": "1.0.0"
  }
}
```

### 3️⃣ Configurar Frontend Flutter

```bash
cd frontend

# Adicionar dependências necessárias
flutter pub add http provider shared_preferences

# Rodar o app
flutter run
```

Escolha o dispositivo (Android, iOS, Web, etc.)

---

## 📱 Testar Fluxo Completo

### 1. Enviar OTP (Autenticação)

```bash
curl -X POST http://localhost:8000/auth/send-otp \
  -H "Content-Type: application/json" \
  -d '{"phone_number": "+5511999999999"}'
```

Copie o `otp_code` da resposta.

### 2. Verificar OTP

```bash
curl -X POST http://localhost:8000/auth/verify-otp \
  -H "Content-Type: application/json" \
  -d '{
    "phone_number": "+5511999999999",
    "otp_code": "SEU_CODIGO_AQUI"
  }'
```

---

## 🗂️ Estrutura do Projeto

```
fantasy-league/
├── backend/              ✅ API PHP configurada
│   ├── api/             # Endpoints
│   ├── config/          # DB, CORS
│   ├── controllers/     # AuthController
│   ├── models/          # User
│   └── utils/           # Response helper
│
├── frontend/            ✅ Flutter inicializado
│   └── lib/
│       ├── models/
│       ├── screens/
│       ├── services/
│       └── providers/
│
├── database/            ✅ Banco criado
│   ├── schema.sql      # Estrutura das tabelas
│   └── seeds.sql       # Dados de teste
│
└── docs/               # Documentação
```

---

## ✅ Checklist de Instalação

- [x] Flutter instalado
- [x] Dart instalado
- [x] PHP instalado
- [x] MySQL instalado e rodando
- [x] Composer instalado
- [x] Extensões VSCode instaladas
- [ ] Banco de dados criado (executar schema.sql)
- [ ] Servidor PHP rodando (php -S localhost:8000)
- [ ] App Flutter rodando (flutter run)

---

## 🚀 Próximos Passos

1. **Criar telas do Flutter:**
   - Login (WhatsApp)
   - Home/Dashboard
   - Ligas
   - Escalação

2. **Expandir API:**
   - LeagueController
   - PlayerController
   - MatchController

3. **Integrar Twilio:**
   - Criar conta
   - Configurar WhatsApp Business
   - Implementar envio real de OTP

4. **Deploy:**
   - Backend: HostGator, DigitalOcean, AWS
   - Frontend: Play Store, App Store

---

## 📞 Endpoints Disponíveis

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/health` | Health check da API |
| POST | `/auth/send-otp` | Enviar código OTP |
| POST | `/auth/verify-otp` | Verificar OTP e login |

---

## 🛠️ Comandos Úteis

```bash
# Backend
cd backend/api && php -S localhost:8000

# Frontend
cd frontend && flutter run

# MySQL
mysql -u root -p fantasy_league

# Ver estrutura do banco
mysql -u root -p -e "SHOW TABLES" fantasy_league

# Ver usuários de teste
mysql -u root -p -e "SELECT * FROM users" fantasy_league
```

---

## ❓ Troubleshooting

**Erro de conexão MySQL:**
```bash
brew services restart mysql
```

**Porta 8000 ocupada:**
```bash
php -S localhost:8080  # Usar porta diferente
```

**Flutter não encontra dispositivos:**
```bash
flutter doctor
flutter devices
```

---

Pronto! Você já pode começar a desenvolver! 🎉
