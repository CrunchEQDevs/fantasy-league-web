# Backend - Fantasy League API

API REST em PHP para aplicação Fantasy League.

## Tecnologias

- PHP 8.4
- MySQL 9.5
- PDO para conexão com banco
- Arquitetura MVC

## Estrutura

```
backend/
├── api/
│   └── index.php         # Entry point da API
├── config/
│   ├── database.php      # Configuração do banco
│   └── cors.php          # Configuração CORS
├── controllers/
│   └── AuthController.php # Controller de autenticação
├── models/
│   └── User.php          # Model de usuário
├── middlewares/          # Middlewares (auth, etc)
└── utils/
    └── Response.php      # Utilitário para respostas
```

## Instalação

### 1. Configurar Banco de Dados

Editar [config/database.php](config/database.php):

```php
define('DB_HOST', 'localhost');
define('DB_NAME', 'fantasy_league');
define('DB_USER', 'root');
define('DB_PASS', 'sua_senha');
```

### 2. Executar Scripts SQL

```bash
cd ../database
mysql -u root -p < schema.sql
mysql -u root -p fantasy_league < seeds.sql
```

### 3. Configurar Servidor PHP

#### Opção 1: PHP Built-in Server (Desenvolvimento)

```bash
cd backend/api
php -S localhost:8000
```

#### Opção 2: XAMPP/MAMP

1. Copiar pasta `backend` para `htdocs` ou `www`
2. Acessar: `http://localhost/backend/api/`

#### Opção 3: Apache/Nginx

Configurar DocumentRoot para `backend/api/`

## Endpoints

### Health Check

```
GET /api/health
```

**Response:**
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

### Autenticação

#### Enviar OTP

```
POST /api/auth/send-otp
Content-Type: application/json

{
  "phone_number": "+5511999999999"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Código OTP enviado com sucesso",
  "data": {
    "phone_number": "+5511999999999",
    "expires_in": 600
  }
}
```

#### Verificar OTP

```
POST /api/auth/verify-otp
Content-Type: application/json

{
  "phone_number": "+5511999999999",
  "otp_code": "123456"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login realizado com sucesso",
  "data": {
    "user": {
      "id": 1,
      "phone_number": "+5511999999999",
      "name": "João Silva",
      "email": "joao@example.com"
    },
    "token": "base64_encoded_token"
  }
}
```

## TODO

- [ ] Implementar JWT para tokens
- [ ] Integrar Twilio/WhatsApp API
- [ ] Criar controllers: League, Player, Match
- [ ] Implementar middleware de autenticação
- [ ] Sistema de upload de imagens
- [ ] Rate limiting
- [ ] Logs de requisições

## Testes

```bash
# Testar health check
curl http://localhost:8000/health

# Testar envio de OTP
curl -X POST http://localhost:8000/auth/send-otp \
  -H "Content-Type: application/json" \
  -d '{"phone_number": "+5511999999999"}'
```
