# Database - Fantasy League

## Setup do Banco de Dados

### 1. Executar o Schema

```bash
mysql -u root -p < schema.sql
```

Ou via phpMyAdmin:
1. Abrir phpMyAdmin
2. Importar o arquivo `schema.sql`

### 2. Criar Usuário da Aplicação (Recomendado)

```sql
CREATE USER 'fantasy_app'@'localhost' IDENTIFIED BY 'sua_senha_segura';
GRANT ALL PRIVILEGES ON fantasy_league.* TO 'fantasy_app'@'localhost';
FLUSH PRIVILEGES;
```

### 3. Executar Seeds (Dados Iniciais)

```bash
mysql -u root -p fantasy_league < seeds.sql
```

## Estrutura do Banco

### Tabelas Principais

- **users**: Usuários do app
- **auth_otp**: Códigos OTP para autenticação WhatsApp
- **leagues**: Ligas criadas
- **league_participants**: Participantes de cada liga
- **real_players**: Jogadores reais disponíveis
- **participant_teams**: Times montados pelos participantes
- **matches**: Partidas/rodadas
- **player_match_scores**: Pontuação dos jogadores por partida
- **transfers**: Histórico de transferências
- **notifications**: Notificações para usuários

## Diagramas

Ver: `database/diagrams/` para ER Diagram
