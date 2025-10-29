# 📋 RELATÓRIO COMPLETO: IMPLEMENTAÇÃO "MONTE SUA LIGA"

**Data:** 29 de Outubro, 2025
**Projeto:** Fantasy League
**Objetivo:** Implementar funcionalidade completa de montagem de liga usando API BeSoccer

---

## 1. SITUAÇÃO ATUAL DO PROJETO

### ✅ O que já existe:
- Estrutura Flutter funcional com navegação
- Tela básica `monte_league.dart` (apenas esqueleto)
- Cliente HTTP configurado (`http: ^1.2.0`)
- Integração com ScoreBat para highlights de vídeos
- UI responsiva (web/mobile)
- Estrutura de pastas preparada (services/, models/, config/ vazias)

### ❌ O que precisa ser implementado:
- Integração com API BeSoccer
- Modelos de dados (jogadores, times, competições)
- Serviços de API (busca de jogadores, criação de liga)
- UI completa da tela de montar liga
- Sistema de seleção de jogadores
- Validações (orçamento, formação, regras)
- Persistência de dados (ligas criadas)
- Gerenciamento de estado

---

## 2. SOBRE A API BESOCCER

### 🔑 O que você precisa saber:

A **BeSoccer** é uma plataforma de dados de futebol que fornece:
- ⚽ Dados de jogadores (estatísticas, valores, posições)
- 🏆 Competições e ligas
- 📊 Estatísticas em tempo real
- 🔄 Atualizações de transferências

### 📡 Endpoints típicos (verificar documentação oficial):

```
Base URL: https://api.besoccer.com/v1/
Autenticação: API Key (geralmente via header ou query param)

Endpoints comuns:
- /competitions - Lista de competições
- /teams - Times
- /players - Jogadores
- /players/search - Buscar jogadores
- /player/{id} - Detalhes do jogador
- /standings - Classificação
```

### 🔐 Autenticação:
Você precisará:
1. Criar conta no BeSoccer
2. Obter API Key
3. Configurar header: `Authorization: Bearer YOUR_API_KEY`

**Alternativa:** API-Football (RapidAPI) - https://rapidapi.com/api-sports/api/api-football

---

## 3. ARQUITETURA PROPOSTA

```
frontend/lib/
├── config/
│   └── api_config.dart              # URLs, API Keys, constantes
├── models/
│   ├── player.dart                  # Modelo de jogador
│   ├── team.dart                    # Modelo de time
│   ├── league.dart                  # Modelo de liga customizada
│   ├── formation.dart               # Modelo de formação tática
│   └── competition.dart             # Modelo de competição
├── services/
│   ├── besoccer_service.dart        # Cliente API BeSoccer
│   ├── league_service.dart          # Lógica de criação de liga
│   └── storage_service.dart         # Persistência local
├── providers/ (ou state/)
│   ├── league_provider.dart         # Estado da liga sendo montada
│   └── players_provider.dart        # Estado dos jogadores selecionados
├── screens/
│   └── monte_league.dart            # Tela principal (será expandida)
└── widgets/
    ├── player_card.dart             # Card de jogador
    ├── formation_selector.dart      # Seletor de formação
    ├── budget_indicator.dart        # Indicador de orçamento
    └── player_search.dart           # Barra de busca
```

---

## 4. FUNCIONALIDADES A IMPLEMENTAR

### 🎯 Funcionalidades Core:

#### 1. **Seleção de Competição**
- Escolher liga (Premier League, La Liga, Brasileirão, etc.)
- Filtrar jogadores pela competição

#### 2. **Escolha de Formação**
- Opções: 4-3-3, 4-4-2, 3-5-2, etc.
- Validação de posições

#### 3. **Busca de Jogadores**
- Busca por nome
- Filtros: posição, time, valor
- Ordenação: preço, pontuação, popularidade

#### 4. **Montagem do Time**
- Drag-and-drop ou seleção por clique
- Visualização em campo (tática)
- 11 jogadores titulares + banco (4-7 reservas)

#### 5. **Sistema de Orçamento**
- Orçamento inicial (ex: €100M)
- Cálculo em tempo real
- Alertas de limite

#### 6. **Validações**
- Máximo de jogadores por time real (ex: max 3 do mesmo clube)
- Todas as posições preenchidas
- Orçamento não ultrapassado
- Nomes de jogadores únicos

#### 7. **Salvamento**
- Nome da liga
- Persistência local (SharedPreferences ou Hive)
- Possibilidade de editar depois

---

## 5. DADOS NECESSÁRIOS DA API BESOCCER

### 📦 Estrutura de Dados de Jogador:

```dart
class Player {
  final String id;
  final String name;
  final String position;        // GK, DEF, MID, FWD
  final String team;
  final String teamLogo;
  final String photo;
  final double value;           // Preço em milhões
  final String nationality;
  final int shirtNumber;

  // Estatísticas (opcional)
  final int goals;
  final int assists;
  final double rating;
  final int matchesPlayed;
}
```

### 🔍 Endpoints que você vai precisar:

| Endpoint | Uso | Dados Retornados |
|----------|-----|------------------|
| `GET /competitions` | Listar competições disponíveis | ID, nome, país, logo |
| `GET /competitions/{id}/teams` | Times de uma competição | ID, nome, logo, estádio |
| `GET /players?competition={id}` | Jogadores de uma competição | Lista de jogadores completa |
| `GET /players/search?q={query}` | Buscar jogadores por nome | Resultados da busca |
| `GET /players/{id}` | Detalhes completos de jogador | Estatísticas, histórico, valor |

---

## 6. TECNOLOGIAS E PACOTES NECESSÁRIOS

### 📦 Dependências a adicionar no `pubspec.yaml`:

```yaml
dependencies:
  # Estado
  provider: ^6.1.2              # Gerenciamento de estado
  # OU
  riverpod: ^2.6.1             # Alternativa mais moderna

  # Persistência
  shared_preferences: ^2.3.3    # Dados simples
  # OU
  hive: ^2.2.3                 # Database local mais robusto
  hive_flutter: ^1.1.0

  # UI/UX
  flutter_svg: ^2.0.10         # Suporte para logos SVG
  cached_network_image: ^3.4.1 # Cache de imagens de jogadores
  shimmer: ^3.0.0              # Loading skeleton
  flutter_slidable: ^3.1.1     # Swipe actions

  # Utilidades
  intl: ^0.19.0                # Formatação de números/moedas
  equatable: ^2.0.5            # Comparação de objetos

  # Já tem:
  http: ^1.2.0                 # Cliente HTTP (já instalado)
```

### 🎨 Pacotes UI Opcionais (para melhorar UX):

```yaml
  # Drag and drop
  flutter_reorderable_list: ^2.0.0

  # Animações
  animated_text_kit: ^4.2.2

  # Bottom sheets
  sliding_up_panel: ^2.0.0+1

  # Skeleton loading
  skeletons: ^0.0.3
```

---

## 7. FLUXO DA EXPERIÊNCIA DO USUÁRIO

```
1. Usuário clica em "Monte sua Liga" (home)
   ↓
2. Entra na tela MonteLeagueScreen
   ↓
3. [PASSO 1] Escolhe competição
   - Premier League
   - La Liga
   - Brasileirão
   - etc.
   ↓
4. [PASSO 2] Escolhe formação tática
   - 4-3-3
   - 4-4-2
   - 3-5-2
   ↓
5. [PASSO 3] Monta o time
   - Busca jogadores
   - Adiciona ao campo
   - Vê orçamento restante
   - Preenche todas posições
   ↓
6. [PASSO 4] Nomeia e salva a liga
   - Dá um nome
   - Confirma criação
   ↓
7. Liga salva localmente
   - Pode visualizar depois
   - Pode editar
   - Pode comparar com amigos
```

---

## 8. WIREFRAME CONCEITUAL DA TELA

```
╔════════════════════════════════════════════════╗
║  ← Monte sua Liga                              ║
╠════════════════════════════════════════════════╣
║                                                ║
║  Passo 1/4: Escolha a Competição             ║
║  ┌──────────┐ ┌──────────┐ ┌──────────┐     ║
║  │ Premier  │ │ La Liga  │ │Brasileirão│     ║
║  │  League  │ │          │ │          │     ║
║  └──────────┘ └──────────┘ └──────────┘     ║
║                                                ║
║  Passo 2/4: Escolha a Formação                ║
║  ○ 4-3-3  ○ 4-4-2  ● 3-5-2                   ║
║                                                ║
║  Passo 3/4: Monte seu Time                    ║
║  ┌────────────────────────────────────┐       ║
║  │  Orçamento: €75M / €100M          │       ║
║  │  🔍 Buscar jogadores...            │       ║
║  └────────────────────────────────────┘       ║
║                                                ║
║         [Campo Tático - Formação]              ║
║              🧑‍🦱 GK: Alisson                    ║
║     🧑‍🦱 DF1   🧑‍🦱 DF2   🧑‍🦱 DF3   🧑‍🦱 DF4      ║
║         🧑‍🦱 MID1   🧑‍🦱 MID2   🧑‍🦱 MID3         ║
║     🧑‍🦱 FW1         🧑‍🦱 FW2         🧑‍🦱 FW3      ║
║                                                ║
║  Jogadores Selecionados (8/11)                ║
║  ┌────────────────────────────────────┐       ║
║  │ ⚽ Alisson      Liverpool   €15M  │       ║
║  │ ⚽ Van Dijk     Liverpool   €20M  │       ║
║  │ ...                               │       ║
║  └────────────────────────────────────┘       ║
║                                                ║
║  [  Próximo: Nomear Liga  ]                   ║
║                                                ║
╚════════════════════════════════════════════════╝
```

---

# 🗓️ PLANO DE TRABALHO DETALHADO

## FASE 1: CONFIGURAÇÃO E SETUP (1-2 dias)

### ✅ Tarefas:

#### 1.1 Obter credenciais BeSoccer
- [ ] Criar conta no BeSoccer ou API-Football (RapidAPI)
- [ ] Gerar API Key
- [ ] Testar endpoints com Postman/Insomnia/curl
- [ ] Documentar endpoints disponíveis
- [ ] Verificar limites de rate (requests/dia)

#### 1.2 Adicionar dependências
- [ ] Atualizar `pubspec.yaml` com pacotes necessários
- [ ] Run `flutter pub get`
- [ ] Verificar compatibilidade de versões

#### 1.3 Criar estrutura de arquivos
- [ ] Criar pasta `lib/config/`
- [ ] Criar pasta `lib/models/`
- [ ] Criar pasta `lib/services/`
- [ ] Criar pasta `lib/providers/`
- [ ] Criar widgets específicos em `lib/widgets/`

#### 1.4 Configurar API
- [ ] Criar `config/api_config.dart` com URLs e chaves
- [ ] Adicionar `.env` para variáveis sensíveis (se usar flutter_dotenv)
- [ ] Atualizar `.gitignore` para não commitar API keys
- [ ] Criar constantes (orçamento inicial, limites, etc.)

**Arquivos a criar:**
- `lib/config/api_config.dart`
- `lib/config/constants.dart`
- `.env` (opcional)

---

## FASE 2: MODELOS E SERVIÇOS (2-3 dias)

### ✅ Tarefas:

#### 2.1 Criar modelos de dados

**`lib/models/player.dart`**
- [ ] Classe Player com todos os campos
- [ ] Método `fromJson(Map<String, dynamic> json)`
- [ ] Método `toJson()`
- [ ] Método `copyWith()`
- [ ] Override de `toString()` para debug

**`lib/models/team.dart`**
- [ ] Classe Team (id, name, logo, stadium)
- [ ] Serialização JSON

**`lib/models/competition.dart`**
- [ ] Classe Competition (id, name, country, logo)
- [ ] Serialização JSON

**`lib/models/league.dart`**
- [ ] Classe League (liga customizada do usuário)
- [ ] Campos: id, name, competition, formation, players, createdAt
- [ ] Serialização JSON para persistência

**`lib/models/formation.dart`**
- [ ] Enum ou classe Formation
- [ ] Distribuição de posições (ex: 4-3-3 = 1 GK + 4 DEF + 3 MID + 3 FWD)
- [ ] Método para validar se formação está completa

#### 2.2 Implementar serviço BeSoccer

**`lib/services/besoccer_service.dart`**
- [ ] Classe BeSoccerService com cliente HTTP
- [ ] Método `getCompetitions()` → Future<List<Competition>>
- [ ] Método `getPlayers(String competitionId)` → Future<List<Player>>
- [ ] Método `searchPlayers(String query)` → Future<List<Player>>
- [ ] Método `getPlayerDetails(String playerId)` → Future<Player>
- [ ] Tratamento de erros (try-catch, logging)
- [ ] Timeout de 30 segundos
- [ ] Headers de autenticação

#### 2.3 Implementar serviço de persistência

**`lib/services/storage_service.dart`**
- [ ] Inicialização do SharedPreferences ou Hive
- [ ] Método `saveLeague(League league)` → Future<void>
- [ ] Método `getLeagues()` → Future<List<League>>
- [ ] Método `getLeague(String id)` → Future<League?>
- [ ] Método `deleteLeague(String id)` → Future<void>
- [ ] Método `updateLeague(League league)` → Future<void>

#### 2.4 Testes unitários
- [ ] Testar parsing de JSON dos modelos
- [ ] Mockar respostas de API
- [ ] Testar casos de erro (JSON inválido, campos faltando)

---

## FASE 3: GERENCIAMENTO DE ESTADO (1-2 dias)

### ✅ Tarefas:

#### 3.1 Configurar Provider (ou Riverpod)
- [ ] Adicionar `ChangeNotifierProvider` no `main.dart`
- [ ] Envolver MaterialApp com `MultiProvider`

#### 3.2 Criar LeagueProvider

**`lib/providers/league_provider.dart`**
- [ ] Classe LeagueProvider extends ChangeNotifier
- [ ] Estado:
  - [ ] Competition? selectedCompetition
  - [ ] Formation? selectedFormation
  - [ ] List<Player> selectedPlayers
  - [ ] double budgetUsed
  - [ ] double budgetRemaining
  - [ ] int currentStep (1-4)
- [ ] Métodos:
  - [ ] `setCompetition(Competition comp)`
  - [ ] `setFormation(Formation formation)`
  - [ ] `addPlayer(Player player)` com validações
  - [ ] `removePlayer(String playerId)`
  - [ ] `calculateBudget()` → void
  - [ ] `canAddPlayer(Player player)` → bool
  - [ ] `isFormationComplete()` → bool
  - [ ] `getPlayersByPosition(String position)` → List<Player>
  - [ ] `nextStep()` e `previousStep()`
  - [ ] `reset()` para limpar tudo

#### 3.3 Criar PlayersProvider

**`lib/providers/players_provider.dart`**
- [ ] Classe PlayersProvider extends ChangeNotifier
- [ ] Estado:
  - [ ] List<Player> allPlayers
  - [ ] List<Player> filteredPlayers
  - [ ] bool isLoading
  - [ ] String? error
- [ ] Métodos:
  - [ ] `fetchPlayers(String competitionId)` → Future<void>
  - [ ] `searchPlayers(String query)` → void
  - [ ] `filterByPosition(String position)` → void
  - [ ] `sortByPrice()`, `sortByName()`, etc.

#### 3.4 Validações
- [ ] Validar orçamento antes de adicionar jogador
- [ ] Validar máximo de jogadores por time (ex: max 3 do Liverpool)
- [ ] Validar posição (não adicionar 5 goleiros)
- [ ] Validar duplicatas (mesmo jogador 2x)

---

## FASE 4: UI - PASSO 1 E 2 (2-3 dias)

### ✅ Tarefas:

#### 4.1 Refatorar MonteLeagueScreen
- [ ] Adicionar Stepper ou PageView para passos
- [ ] Criar indicador de progresso (1/4, 2/4, etc.)
- [ ] Layout responsivo (mobile/web)

#### 4.2 Seletor de Competição

**Widget: `lib/widgets/competition_selector.dart`**
- [ ] GridView de competições
- [ ] Cards com logo e nome
- [ ] Estado selecionado (border, cor diferente)
- [ ] Loading enquanto busca competições
- [ ] Tratamento de erro

#### 4.3 Seletor de Formação

**Widget: `lib/widgets/formation_selector.dart`**
- [ ] Lista de formações (4-3-3, 4-4-2, 3-5-2, 4-2-3-1)
- [ ] Radio buttons ou Chips
- [ ] Visualização prévia da formação em mini campo
- [ ] Descrição da formação

#### 4.4 Navegação entre passos
- [ ] Botões "Próximo" e "Voltar"
- [ ] Validação antes de avançar:
  - [ ] Passo 1: Competição deve estar selecionada
  - [ ] Passo 2: Formação deve estar selecionada
- [ ] Animações de transição

---

## FASE 5: UI - PASSO 3 (MONTAGEM) (3-4 dias)

### ✅ Tarefas:

#### 5.1 Barra de busca de jogadores

**Widget: `lib/widgets/player_search.dart`**
- [ ] TextField com ícone de busca
- [ ] Debounce (aguardar 500ms antes de buscar)
- [ ] Filtros:
  - [ ] Por posição (dropdown: Todos, GK, DEF, MID, FWD)
  - [ ] Por time (dropdown com times da competição)
  - [ ] Por faixa de preço (slider)
- [ ] Ordenação (dropdown: Nome, Preço, Rating)
- [ ] Resultados em ListView abaixo

#### 5.2 Card de jogador

**Widget: `lib/widgets/player_card.dart`**
- [ ] Foto do jogador (cached_network_image)
- [ ] Nome
- [ ] Posição (badge colorido)
- [ ] Time (nome + logo pequeno)
- [ ] Valor (formatado com intl: €10.5M)
- [ ] Estatísticas opcionais (gols, assistências)
- [ ] Botão "Adicionar" / "Remover"
- [ ] Estado disabled se não pode adicionar
- [ ] Skeleton loading (shimmer)

#### 5.3 Campo tático

**Widget: `lib/widgets/formation_field.dart`**
- [ ] Container com fundo de campo de futebol
- [ ] Positioned widgets para cada posição
- [ ] Layout baseado na formação escolhida
- [ ] Slots vazios (dotted border) vs preenchidos
- [ ] Avatar de jogador ou placeholder
- [ ] Nome abreviado abaixo do avatar
- [ ] Tap para ver detalhes
- [ ] Long press para remover
- [ ] Animações ao adicionar/remover

#### 5.4 Indicador de orçamento

**Widget: `lib/widgets/budget_indicator.dart`**
- [ ] Barra de progresso (LinearProgressIndicator)
- [ ] Texto: "€75M / €100M"
- [ ] Cor verde → amarela → vermelha conforme aproxima do limite
- [ ] Ícone de alerta quando próximo do limite
- [ ] Animação ao atualizar valor

#### 5.5 Lista de jogadores selecionados

**Widget: `lib/widgets/selected_players_list.dart`**
- [ ] ListView com cards compactos
- [ ] Agrupado por posição (GK, DEF, MID, FWD)
- [ ] Swipe para remover (flutter_slidable)
- [ ] Totalizador de gastos no rodapé
- [ ] Contador: "8/11 jogadores"
- [ ] Empty state quando vazio

---

## FASE 6: UI - PASSO 4 E FINALIZAÇÃO (1-2 dias)

### ✅ Tarefas:

#### 6.1 Tela de nomeação e confirmação

**Passo 4 em MonteLeagueScreen:**
- [ ] TextField para nome da liga
- [ ] Validação (min 3 caracteres, max 30)
- [ ] Preview do time montado:
  - [ ] Competição escolhida
  - [ ] Formação
  - [ ] Campo com 11 jogadores
  - [ ] Orçamento utilizado
- [ ] Resumo em cards (estatísticas agregadas)

#### 6.2 Salvamento
- [ ] Botão "Criar Liga"
- [ ] Loading indicator (CircularProgressIndicator)
- [ ] Gerar ID único para liga (uuid ou timestamp)
- [ ] Salvar via StorageService
- [ ] Feedback de sucesso (SnackBar ou Dialog)
- [ ] Navegação automática para tela de visualização

#### 6.3 Tela de visualização de ligas

**Nova tela: `lib/screens/my_leagues_screen.dart`**
- [ ] AppBar com título "Minhas Ligas"
- [ ] ListView de ligas criadas
- [ ] Card com:
  - [ ] Nome da liga
  - [ ] Competição
  - [ ] Data de criação
  - [ ] Preview dos jogadores principais
  - [ ] Valor total gasto
- [ ] Opções:
  - [ ] Tap para ver detalhes completos
  - [ ] Botão editar
  - [ ] Botão excluir (com confirmação)
- [ ] Empty state ("Nenhuma liga criada ainda")
- [ ] Pull-to-refresh

---

## FASE 7: POLIMENTO E TESTES (2-3 dias)

### ✅ Tarefas:

#### 7.1 Tratamento de erros
- [ ] Sem internet:
  - [ ] Detectar com connectivity_plus
  - [ ] Mostrar banner/dialog
  - [ ] Botão "Tentar novamente"
- [ ] API indisponível:
  - [ ] Timeout handling
  - [ ] Mensagem user-friendly
  - [ ] Opção de usar dados em cache
- [ ] Validações falhas:
  - [ ] Mensagens específicas por tipo de erro
  - [ ] Highlight nos campos problemáticos
- [ ] JSON parsing erros:
  - [ ] Logging detalhado
  - [ ] Fallback para valores padrão

#### 7.2 Loading states
- [ ] Skeleton screens em listas
- [ ] Shimmer effects (pacote shimmer)
- [ ] Pull-to-refresh em listas
- [ ] Indicadores de progresso em ações longas
- [ ] Disabled states em botões durante loading

#### 7.3 Responsividade
- [ ] Testar em dispositivos móveis (iOS/Android)
- [ ] Testar em tablets
- [ ] Testar em navegadores web (Chrome, Safari, Firefox)
- [ ] Breakpoints para layouts diferentes:
  - [ ] Mobile: < 600px
  - [ ] Tablet: 600-900px
  - [ ] Desktop: > 900px
- [ ] Orientação landscape vs portrait

#### 7.4 Testes de integração
- [ ] Fluxo completo end-to-end:
  - [ ] Abrir app → Monte Liga → Selecionar tudo → Salvar
- [ ] Edge cases:
  - [ ] Tentar avançar sem selecionar competição
  - [ ] Tentar adicionar jogador sem orçamento
  - [ ] Tentar salvar com formação incompleta
  - [ ] Buscar jogador que não existe
- [ ] Widget tests para componentes críticos
- [ ] Unit tests para providers e services

#### 7.5 Performance
- [ ] Cache de imagens (cached_network_image já implementado)
- [ ] Lazy loading de jogadores (pagination)
- [ ] Otimização de listas (ListView.builder)
- [ ] Debounce em buscas
- [ ] Memoization em cálculos pesados
- [ ] Profile da app (Flutter DevTools)
- [ ] Reduzir rebuilds desnecessários

#### 7.6 Acessibilidade
- [ ] Semantics para leitores de tela
- [ ] Contraste de cores (WCAG AA)
- [ ] Tamanhos de fonte ajustáveis
- [ ] Tap targets mínimos (44x44 dp)

#### 7.7 UX Enhancements
- [ ] Animações suaves (Hero, Fade, Slide)
- [ ] Haptic feedback em ações importantes
- [ ] Confirmações antes de ações destrutivas
- [ ] Undo/Redo para remover jogadores
- [ ] Tutorial/Onboarding na primeira vez
- [ ] Easter eggs? 😄

---

## 📊 CRONOGRAMA RESUMIDO

| Fase | Duração | Entregas | Prioridade |
|------|---------|----------|------------|
| 1. Setup | 1-2 dias | Config, deps, API key | 🔴 Crítica |
| 2. Backend | 2-3 dias | Models, services, API client | 🔴 Crítica |
| 3. Estado | 1-2 dias | Providers, validações | 🔴 Crítica |
| 4. UI (1-2) | 2-3 dias | Competição e formação | 🟡 Alta |
| 5. UI (3) | 3-4 dias | Montagem de time | 🟡 Alta |
| 6. UI (4) | 1-2 dias | Salvamento | 🟡 Alta |
| 7. Polish | 2-3 dias | Testes, erros, UX | 🟢 Média |
| **TOTAL** | **12-19 dias** | **App completo** | - |

---

## 🎯 PRÓXIMOS PASSOS IMEDIATOS

### 1. Decisões de Arquitetura

#### Gerenciamento de Estado:
- [ ] **Provider** (mais simples, padrão Flutter)
- [ ] **Riverpod** (mais moderno, type-safe)
- [ ] **BLoC** (mais complexo, empresarial)

**Recomendação:** Provider para começar rápido, migrar para Riverpod depois se necessário.

#### Persistência:
- [ ] **SharedPreferences** (key-value simples)
- [ ] **Hive** (database local, mais robusto)
- [ ] **SQLite** (relacional, overkill para este caso)

**Recomendação:** SharedPreferences para MVP, Hive se precisar de queries complexas.

#### API:
- [ ] **BeSoccer** (se tiver acesso)
- [ ] **API-Football (RapidAPI)** (alternativa popular)
- [ ] **TheSportsDB** (gratuita, limitada)

**Recomendação:** API-Football (RapidAPI) tem boa documentação e plano free.

---

### 2. Obter API BeSoccer/API-Football

#### Passos:
1. [ ] Acessar https://rapidapi.com/api-sports/api/api-football
2. [ ] Criar conta
3. [ ] Subscrever plano (Free: 100 req/dia)
4. [ ] Copiar API Key
5. [ ] Testar com Postman:
   ```bash
   curl -X GET "https://v3.football.api-sports.io/players?league=39&season=2024" \
   -H "x-rapidapi-key: YOUR_API_KEY" \
   -H "x-rapidapi-host: v3.football.api-sports.io"
   ```
6. [ ] Documentar endpoints relevantes

#### Endpoints úteis da API-Football:
- `GET /leagues` - Listar ligas
- `GET /teams?league={id}&season={year}` - Times de uma liga
- `GET /players/squads?team={id}` - Elenco de um time
- `GET /players?league={id}&season={year}` - Todos jogadores de uma liga (cuidado: muitos dados)

---

### 3. Configuração Inicial do Projeto

#### Comandos:
```bash
# 1. Adicionar dependências
cd /Users/williamcavalcanti/fantasy-league/frontend
flutter pub add provider
flutter pub add shared_preferences
flutter pub add cached_network_image
flutter pub add shimmer
flutter pub add intl

# 2. Criar estrutura de pastas
mkdir -p lib/config
mkdir -p lib/models
mkdir -p lib/services
mkdir -p lib/providers

# 3. Obter dependências
flutter pub get

# 4. Testar build
flutter analyze
```

---

### 4. Primeira Tarefa: Config e API

**Arquivo:** `lib/config/api_config.dart`

```dart
class ApiConfig {
  // API-Football (RapidAPI)
  static const String baseUrl = 'https://v3.football.api-sports.io';
  static const String apiKey = 'YOUR_API_KEY_HERE'; // TODO: Mover para .env

  static Map<String, String> get headers => {
    'x-rapidapi-key': apiKey,
    'x-rapidapi-host': 'v3.football.api-sports.io',
  };

  // Endpoints
  static String get leaguesEndpoint => '$baseUrl/leagues';
  static String teamsEndpoint(int leagueId, int season) =>
      '$baseUrl/teams?league=$leagueId&season=$season';
  static String playersEndpoint(int leagueId, int season) =>
      '$baseUrl/players?league=$leagueId&season=$season';
}
```

**Arquivo:** `lib/config/constants.dart`

```dart
class LeagueConstants {
  // Orçamento
  static const double initialBudget = 100.0; // 100M

  // Limites
  static const int maxPlayersPerTeam = 3;
  static const int totalPlayers = 11;
  static const int benchPlayers = 4;

  // Ligas populares (IDs da API-Football)
  static const int premierLeagueId = 39;
  static const int laLigaId = 140;
  static const int brasileiraoId = 71;
  static const int serieAId = 135;
  static const int bundesligaId = 78;

  // Temporada atual
  static const int currentSeason = 2024;
}
```

---

## 📚 RECURSOS E REFERÊNCIAS

### Documentação:
- **Flutter:** https://docs.flutter.dev/
- **Provider:** https://pub.dev/packages/provider
- **API-Football:** https://www.api-football.com/documentation-v3
- **BeSoccer:** https://www.besoccer.com/ (verificar se tem API pública)

### Inspiração de Design:
- **Fantasy Premier League:** https://fantasy.premierleague.com/
- **Cartola FC:** https://cartolafc.globo.com/
- **UEFA Fantasy:** https://gaming.uefa.com/

### Tutoriais:
- Provider state management: https://www.youtube.com/watch?v=d_m5csmrf7I
- API integration: https://www.youtube.com/watch?v=7I4EYhADi6U
- Drag and drop: https://www.youtube.com/watch?v=QzA4c4QHZCY

---

## 🐛 TROUBLESHOOTING COMUM

### Problema: API retorna 401 Unauthorized
**Solução:** Verificar se API Key está correta e no header correto.

### Problema: Too many requests (429)
**Solução:** Implementar cache local, reduzir chamadas desnecessárias, upgrade do plano.

### Problema: Imagens não carregam
**Solução:** Verificar permissões de internet (Android: manifest, iOS: Info.plist).

### Problema: App lento com muitos jogadores
**Solução:** Implementar pagination, lazy loading, otimizar ListView.

### Problema: Estado não atualiza na UI
**Solução:** Chamar `notifyListeners()` no Provider após mudanças.

---

## ✅ CHECKLIST FINAL

Antes de considerar a feature completa:

- [ ] Todos os passos funcionam (1-4)
- [ ] Validações implementadas
- [ ] Erros tratados gracefully
- [ ] UI responsiva (mobile/web)
- [ ] Loading states em todas as ações assíncronas
- [ ] Dados persistem após fechar app
- [ ] Testes básicos passando
- [ ] Sem warnings no `flutter analyze`
- [ ] Performance aceitável (< 3s para carregar jogadores)
- [ ] Documentação básica (comentários em código)

---

## 🚀 MELHORIAS FUTURAS (PÓS-MVP)

### Fase 2 (depois do lançamento):
1. **Pontuação automática**
   - Integrar com API de estatísticas em tempo real
   - Calcular pontos baseado em performance real

2. **Modo multiplayer**
   - Criar ligas privadas com amigos
   - Leaderboard
   - Chat entre participantes

3. **Notificações**
   - Alertas de jogos ao vivo
   - Lembretes de deadline para mudanças
   - Notificações de ranking

4. **Análise avançada**
   - Gráficos de performance
   - Comparação com outros usuários
   - Sugestões de substituições (IA)

5. **Monetização**
   - Ligas premium
   - Remoção de anúncios
   - Features exclusivas

---

**Documento criado em:** 29 de Outubro de 2025
**Última atualização:** 29 de Outubro de 2025
**Versão:** 1.0
